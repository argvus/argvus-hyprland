---
title: Sobrescrituras de Hyprland
description: Personaliza la configuración de ARGVUS Hyprland sin editar los archivos empaquetados.
---
ARGVUS admite dos formas diferentes de personalizar Hyprland. No deben confundirse:

- `~/.config/hypr/hyprland.lua` es una configuración completa de usuario. Cuando es válida y no es la plantilla estándar de Hyprland, `argvus start` lanza Hyprland con este archivo en lugar de la configuración incluida.
- `~/.config/argvus/data/hypr/` contiene sobrescrituras incrementales de ARGVUS. La configuración incluida sigue siendo la base y carga estos fragmentos al final.

Para la mayoría de las personalizaciones, use las sobrescrituras incrementales de ARGVUS. Mantienen los valores predeterminados de ARGVUS, el estado generado y la integración de la sesión disponibles a través de las actualizaciones del paquete.

## Archivos de sobrescritura compatibles

Cree el directorio antes de agregar un fragmento:

```sh
mkdir -p ~/.config/argvus/data/hypr
```
La configuración empaquetada carga estos archivos en este orden cuando existen:

```text
~/.config/argvus/data/hypr/monitors.lua
~/.config/argvus/data/hypr/rules.lua
~/.config/argvus/data/hypr/bindings.lua
~/.config/argvus/data/hypr/user.lua
```
Usa los archivos según la responsabilidad:

- `monitors.lua` — declaraciones adicionales o de reemplazo de monitores.
- `rules.lua` — reglas de ventanas y capas.
- `bindings.lua` — atajos de teclado adicionales o acciones personalizadas.
- `user.lua` — variables de entorno y otra configuración de Lua que no encaje en las categorías anteriores.

Un fragmento con un error de Lua no detiene el resto de la configuración. Hyprland omite ese archivo, informa `ARGVUS: ignoring invalid user override` con su ruta y el error, y aún así carga los fragmentos restantes. Revisa un fragmento con `luac -p` antes de recargar.

No edites `/usr/share/argvus/hyprland/config/hyprland.lua`. Es propiedad del paquete y puede ser reemplazado por una actualización.

## Sobrescrituras de entorno

Usa `user.lua` para los valores del entorno de la sesión:

```lua
-- ~/.config/argvus/data/hypr/user.lua
hl.env("MY_VARIABLE", "1")
```
Los cambios en el entorno afectan a las aplicaciones iniciadas por la sesión. Cierra sesión y vuelve a iniciarla cuando el valor debe ser heredado por toda la sesión; solo recargar un compositor no es suficiente para las aplicaciones que ya se habían iniciado.

ARGVUS posee `XDG_CONFIG_DIRS` y lo reconstruye en cada recarga de Hyprland, incluidas las recargas provocadas por cambios de tema. Cada directorio de configuración de ARGVUS aparece una sola vez, y las entradas heredadas de la sesión se mantienen después de ellas sin repetición, por lo que el valor permanece limitado. Las sesiones iniciadas por versiones anteriores aún pueden llevar las entradas duplicadas; si Kitty, `argvus terminal` o `argvus --control-center` fallan con `Out of buffer space calling sprintf`, cierra sesión y vuelve a iniciarla para empezar con un entorno limpio.

## Agregando un atajo de teclado

Usa `bindings.lua` para una nueva combinación de teclas que no forme parte del manifiesto de combinaciones de teclas de ARGVUS:

```lua
-- ~/.config/argvus/data/hypr/bindings.lua
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty"))
```
Usa los ayudantes del despachador Lua de ARGVUS para acciones del compositor:

```lua
-- Focus the next window with a custom shortcut.
hl.bind("SUPER + CTRL + Tab", hl.dsp.group.next())
```
La vinculación se evalúa junto con la configuración empaquetada. Verifique posibles conflictos con los atajos existentes antes de elegir una combinación. Mantenga las opciones apropiadas al definir vinculaciones especiales, por ejemplo:

```lua
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)
```
El Centro de Control es la forma preferida de cambiar o desactivar una vinculación ARGVUS existente:

```sh
argvus control-center keybindings
```
Esos cambios se almacenan de manera canónica bajo `/keyboard_shortcuts` y se materializan en `~/.config/argvus/data/generated/hypr/keybindings.lua`. Un enlace creado manualmente en `bindings.lua` no se agrega al manifiesto del Centro de Control y no es gestionado por su acción de restauración.

## Configuración completa nativa de Hyprland

`~/.config/hypr/hyprland.lua` no es un archivo de superposición. Si lo crea, `argvus start` lo valida y lo utiliza como la configuración completa de Hyprland:

```sh
mkdir -p ~/.config/hypr
cp /usr/share/argvus/hyprland/config/hyprland.lua ~/.config/hypr/hyprland.lua
```
Este enfoque ofrece control total, pero el archivo copiado se convierte en tu responsabilidad. Puede quedarse obsoleto a medida que ARGVUS cambia, y un archivo personalizado que omita el cargador de ARGVUS o el manejo del estado generado puede perder la integración con ARGVUS. Prefiere los archivos fragmento mencionados arriba a menos que necesites intencionalmente un reemplazo completo.

El archivo estándar de Hyprland que contiene `AUTOGENERATED HYPRLAND CONFIG` es ignorado por `argvus start`, por lo que su presencia no reemplaza la configuración de ARGVUS. Un archivo de usuario personalizado se selecciona solo después de la validación; si la validación falla, el lanzador vuelve al archivo empaquetado.

## Aplicar y solucionar problemas

Después de cambiar un fragmento de Lua, recarga la configuración de la sesión:

```sh
argvus sessionctl reload
```
Valida un archivo Lua completo antes de iniciar sesión de nuevo:

```sh
luac -p ~/.config/hypr/hyprland.lua
Hyprland --verify-config --config ~/.config/hypr/hyprland.lua
```
Si la configuración del usuario es rechazada durante el inicio, inspeccione:

```sh
grep -E "Hyprland Lua config|failed validation|using user Lua|fallback" \
  ~/.local/state/argvus/session.log
```
El código fuente empaquetado y los auxiliares están bajo `/usr/share/argvus/hyprland/`. Los archivos generados bajo `~/.config/argvus/data/generated/` son estado derivado; edita la configuración propietaria o el fragmento de anulación en lugar de editar directamente la salida generada.

Consulta [Atajos de teclado](/docs/argvus-hyprland/keyboard-shortcuts/) para el flujo de trabajo del Centro de Control y [ubicaciones de archivos](/docs/reference/file-locations/) para la referencia completa de la ruta de configuración.

La potencia de renderizado de sombras se limita a 1–4 (predeterminado 4) antes de llamar a Hyprland, incluyendo proyecciones de efectos heredados. Esto evita que los valores aceptados por versiones anteriores de ARGVUS bloqueen el inicio en Hyprland 0.57.
