---
title: Atajos de teclado
description: Encuentra los atajos proporcionados por la configuración de ARGVUS Hyprland.
---
Abre **Centro de Control → Escritorio y Entrada → Atajos de Teclado**, o ejecuta `argvus control-center keybindings`.

## Qué hace la página

**Todos los Atajos** busca y agrupa el manifiesto de teclas activas. Puedes seleccionar un atajo, editar su combinación de teclas, capturar una nueva combinación, habilitar o deshabilitar un atajo configurable y restaurar todos los atajos desde la acción de restaurar de la página. Un atajo debe contener una tecla que no sea modificadora; el editor normaliza nombres como Super/Win, Ctrl, Alt, Shift, flechas, teclas de función y teclas de medios. `SUPER + Y` abre **Centro de Control → Apariencia → Fondos de Pantalla**.

Los cambios oficiales de atajos se almacenan en `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`, representados por `/keyboard_shortcuts` en el modelo lógico; el fragmento generado de Hyprland se escribe debajo de `~/.config/argvus/data/generated/hypr/`. Un atajo deshabilitado se representa por `null`. Las claves son claves de configuración estables en inglés, independientes de la localidad seleccionada: un ID de manifiesto como `window.close` se asigna a `close_window`, mientras que `window.drag_mouse` se asigna a `drag_window__floating_window_only`. La antigua sección `/hyprland/keybindings` y `keybindings.toml` son solo para migración. ARGVUS programa una recarga de sesión solo cuando el plan de proyección informa un cambio real.

**Crear Atajos** crea un atajo de teclado global de manera independiente del manifiesto empaquetado. Proporcione una descripción, teclas y un comando o un despachador Lua compatible (por ejemplo, `window.float` con argumentos JSON `{"action":"toggle"}`). **Crear** lo guarda y aplica, luego lo selecciona en **Todos los Atajos → Atajos Personalizados**. Cancelar o `Esc` descarta el borrador. La creación y la captura no ejecutan el comando.

Los atajos personalizados se pueden editar, habilitar/deshabilitar y eliminar con confirmación. Los conflictos con atajos habilitados en el mismo contexto requieren confirmación de reemplazo; las asignaciones protegidas no se pueden reemplazar. Restaurar los valores predeterminados oficiales preserva los registros personalizados. Si restaurar chocaría con un atajo personalizado activo, primero cambie o deshabilite ese atajo personalizado. Las definiciones personalizadas se almacenan bajo `/hyprland/custom_shortcuts` en `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. El `data/generated/hypr/custom-shortcuts.lua` generado se carga con el cargador protegido existente; los registros inválidos se registran sin abortar el resto de la configuración. Los errores al guardar preservan el borrador; los fallos de la aplicación informan que el registro se guardó y se puede reintentar.

Ejecute `argvus control-center shortcuts create` o `argvus control-center shortcuts list` para abrir cualquiera de las páginas. Para submapas avanzados, asignaciones de mouse o banderas, [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) sigue disponible. Nunca edite los fragmentos generados.

## Referencia actual

El manifiesto base y las hojas de trucos instaladas están bajo `/usr/share/argvus/hyprland/`. La anulación activa del usuario no es un manifiesto de reemplazo: cambia las entradas seleccionadas en el Centro de Control. Por eso, una lista específica de versión, copiada manualmente, puede volverse obsoleta.

Algunas acciones integradas útiles incluyen mover el enfoque y los espacios de trabajo, alternar ventanas flotantes, capturas de pantalla y grabación, abrir el lanzador/terminal, cambiar la apariencia, bloquear la sesión, controlar los medios y recargar Hyprland. Las combinaciones de teclas predeterminadas se enumeran en la [tabla de atajos predeterminada](#default-shortcut-table) a continuación; la página del Centro de Control muestra las combinaciones de teclas tal como están configuradas actualmente.

`SUPER + Shift + R` es la recarga explícita en tiempo de ejecución: recarga Hyprland y reinicia la barra de tareas ARGVUS, el Panel de Control y los servicios de Telemetría de Widgets. Las recargas basadas en la configuración siguen siendo condicionales y omiten la recarga gráfica cuando el estado canónico no ha cambiado.

## Tabla de atajos predeterminada

La tabla enumera las combinaciones del manifiesto base (`/usr/share/argvus/hyprland/keybindings.json`) con sus teclas predeterminadas. Sus propios cambios en el Centro de Control reemplazan las teclas que se muestran aquí para las combinaciones afectadas, y las combinaciones deshabilitadas no se ejecutan.### Navegación

| Atajo | Descripción |
| --- | --- |
| `SUPER + Left Arrow` | Enfocar ventana en mosaico por dirección |
| `SUPER + Right Arrow` | Enfocar ventana en mosaico por dirección |
| `SUPER + Up Arrow` | Enfocar ventana en mosaico por dirección |
| `SUPER + Down Arrow` | Enfocar ventana en mosaico por dirección |
| `SUPER + CTRL + Left Arrow` | Cambiar el enfoque entre ventanas (en mosaico y flotantes) |
| `SUPER + CTRL + Right Arrow` | Cambiar el enfoque entre ventanas (en mosaico y flotantes) |

### Espacios de trabajo

| Atajo | Descripción |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Moverse entre áreas de trabajo |
| `CTRL + ALT + Left Arrow` | Moverse entre áreas de trabajo |
| `Mouse extra button (mouse:276)` | Moverse entre áreas de trabajo |
| `Mouse side button (mouse:275)` | Moverse entre áreas de trabajo |
| `SUPER + 1` | Espacio de trabajo 1 |
| `SUPER + 2` | Espacio de trabajo 2 |
| `SUPER + 3` | Espacio de trabajo 3 |
| `SUPER + 4` | Espacio de trabajo 4 |
| `SUPER + 5` | Espacio de trabajo 5 |
| `SUPER + 6` | Espacio de trabajo 6 |
| `SUPER + 7` | Espacio de trabajo 7 |
| `SUPER + 8` | Espacio de trabajo 8 |
| `SUPER + 9` | Espacio de trabajo 9 |
| `SUPER + CTRL + 1` a `SUPER + CTRL + 9` | Abre el proyecto en esa posición de `argvus projects` |
| `SUPER + Shift + 1` | Mover ventana al escritorio 1 |
| `SUPER + Shift + 2` | Mover ventana al escritorio 2 |
| `SUPER + Shift + 3` | Mover ventana al escritorio 3 |
| `SUPER + Shift + 4` | Mover ventana al escritorio 4 |
| `SUPER + Shift + 5` | Mover ventana al escritorio 5 |
| `SUPER + Shift + 6` | Mover ventana al escritorio 6 |
| `SUPER + Shift + 7` | Mover ventana al escritorio 7 |
| `SUPER + Shift + 8` | Mover ventana al escritorio 8 |
| `SUPER + Shift + 9` | Mover ventana al escritorio 9 |

### ventanas

| Atajo | Descripción |
| --- | --- |
| `SUPER + S` | Maximizar ventana (alternar) |
| `SUPER + Q` | Cerrar ventana |
| `SUPER + Shift + Space` | Activar/Desactivar ventana flotante |
| `SUPER + F` | Ventana a pantalla completa |
| `SUPER + E` | Alternar división vertical/horizontal |
| `SUPER + W` | Agrupar/Desagrupar en pestañas |
| `SUPER + Tab` | Navegar entre pestañas |
| `SUPER + Shift + Left Arrow` | Mover ventana |
| `SUPER + Shift + Right Arrow` | Mover ventana |
| `SUPER + Shift + Up Arrow` | Mover ventana |
| `SUPER + Shift + Down Arrow` | Mover ventana |
| `SUPER + Left mouse button (mouse:272)` | Arrastrar ventana (solo ventana flotante) |
| `SUPER + Right mouse button (mouse:273)` | Modo de cambio de tamaño de ventana (solo ventana flotante) |
| `SUPER + R` | Entrar en modo de cambio de tamaño de ventana (solo ventana flotante) |

### Aplicaciones

| Atajo | Descripción |
| --- | --- |
| `SUPER + Enter` | Terminales |
| `SUPER + [` | Bloc de notas del terminal (desplegable en un espacio de trabajo especial; presiona de nuevo para ocultar) |
| `SUPER + Space` | Administrador de archivos |
| `SUPER + CTRL + Space` | Monitor del sistema |
| `SUPER + Shift + D` | Menú de dispositivos extraíbles |
| `SUPER + Shift + F` | ARGVUS Focus (sesiones Pomodoro y de concentración) |
| `SUPER + Shift + C` | ARGVUS Clock (reloj, temporizadores y alarmas) |
| `SUPER + D` | Lanzador de programas |
| `SUPER + B` | Navegador predeterminado |
| `SUPER + C` | Calculadora |
| `SUPER + ALT + S` | Selector de host SSH (`argvus ssh`) |
| `SUPER + ALT + N` | Selector de fragmentos (`argvus snippets`) |
| `SUPER + ALT + G` | Selector de proyectos, luego TUI de git (lazygit o gitui) en el proyecto elegido (`argvus git`) |

### Medios

| Atajo | Descripción |
| --- | --- |
| `XF86AudioRaiseVolume` | Subir volumen |
| `Volume Down` | Bajar volumen |
| `Mute` | Silenciar |
| `Brightness Up` | Subir brillo |
| `Brightness Down` | Bajar brillo |
| `Play/Pause` | Reproducir/Pausar |
| `Next Track` | Siguiente pista |
| `Previous Track` | Pista anterior |
| `Stop` | Detener pista |

### Capturas de pantalla y grabación

| Atajo | Descripción |
| --- | --- |
| `Print` | Capturar área seleccionada |
| `SUPER + Print` | Capturar ventana enfocada |
| `SUPER + Shift + Print` | Capturar toda la pantalla |
| `SUPER + G` | Iniciar/Pausar/Continuar grabación de pantalla |
| `SUPER + Shift + G` | Detener y guardar grabación de pantalla |

### Sesión

| Atajo | Descripción |
| --- | --- |
| `SUPER + L` | Bloquear sistema |
| `SUPER + escape` | Salir del sistema |
| `SUPER + Shift + R` | Recargar Hyprland |
| `SUPER + Shift + S` | Apagar/encender monitor (no suspender sistema) |
| `SUPER + Shift + L` | Elegir tiempo de espera para el bloqueo por inactividad |
| `SUPER + ALT + W` | Alternar Mantener Activo |

### Sistema

| Atajo | Descripción |
| --- | --- |
| `SUPER + Shift + /` | Hojas de trucos de Hyprland |
| `SUPER + CTRL + /` | Hojas de trucos de Kitty |
| `SUPER + F1` | Abrir Acerca de ARGVUS |
| `SUPER + ALT + C` | Abrir Centro de Control |
| `SUPER + P` | Selector de color |
| `SUPER + .` | Selección de emoji |
| `SUPER + H` | Historial del portapapeles |
| `SUPER + Shift + H` | Borrar historial del portapapeles |

### widgets

| Atajo | Descripción |
| --- | --- |
| `SUPER + ,` | Abrir/Cerrar la barra lateral de notificaciones |
| `Middle mouse button (mouse:274)` | Abrir/Cerrar la barra lateral de notificaciones |
| `SUPER + Backspace` | Alternar Waybar superior |
| `SUPER + Shift + W` | Configurar ubicación del clima |
| `SUPER + ALT + Up Arrow` | Mover la barra de tareas a la parte superior |
| `SUPER + ALT + Down Arrow` | Mover la barra de tareas a la parte inferior |

### Apariencia

| Atajo | Descripción |
| --- | --- |
| `SUPER + Y` | Abrir fondos de pantalla del Centro de Control |
| `SUPER + Shift + T` | Abrir selector de temas |
| `SUPER + Shift + M` | Abrir selector de modo Fijo/Espaciado |
| `SUPER + F5` | Alternar entre los temas ARGVUS Dark y ARGVUS Light |
| `SUPER + F6` | Alternar animaciones |
| `SUPER + Shift + B` | Abrir selector de brillo y alternar Luz Nocturna |

### Modo de redimensionamiento (después de SUPER + R)

Estos atajos funcionan solo mientras el modo de redimensionamiento está activado. `Esc` o `Enter` sale del modo.

| Atajo | Descripción |
| --- | --- |
| `Right Arrow` | Cambiar tamaño |
| `Left Arrow` | Cambiar tamaño |
| `Up Arrow` | Cambiar tamaño |
| `Down Arrow` | Cambiar tamaño |
| `Shift + Right Arrow` | Mover ventana |
| `Shift + Left Arrow` | Mover ventana |
| `Shift + Up Arrow` | Mover ventana |
| `Shift + Down Arrow` | Mover ventana |
| `escape` | Salir del modo de cambio de tamaño |
| `Enter` | Salir del modo de cambio de tamaño |

Vea [Windows and layout](/docs/argvus-hyprland/windows-and-layout/) para el comportamiento de ventanas flotantes y del espacio de trabajo y [Control Center](/docs/components/argvus-control-center/) para el flujo de configuración.

## Luz Nocturna

**SUPER + Shift + B** mantiene la acción `appearance.brightness` en el manifiesto de asignaciones de teclas canónicas. Su menú de brillo de Rofi también ofrece Luz Nocturna cuando Hyprsunset está disponible. Configura la temperatura (1000–20000 K) y los horarios locales de inicio/fin en **Centro de Control > Escritorio y Entrada > Pantallas > Luz Nocturna**. La acción rápida utiliza la CLI compartida y no recarga Hyprland ni cambia el Lua generado.

Con el paquete opcional argvus-ai instalado, SUPER + A abre el menú de agentes de IA. La asignación respeta las anulaciones del usuario de app.ai y desaparece después de la eliminación del paquete y la recarga del compositor. Hasta la recarga, la acción protegida está inactiva.


El paquete opcional argvus-ai posee /usr/share/argvus/ai/hyprland.lua. Hyprland lo carga de forma segura antes de las modificaciones del usuario; eliminar el módulo elimina su vinculación al recargar. El paquete Hyprland proporciona un hook de Pacman que solo toca la marca de tiempo de la configuración del sistema después de la instalación/actualización/eliminación del módulo, activando la recarga automática nativa. Si la recarga automática está deshabilitada o se utiliza una configuración de usuario root separada, recargue explícitamente esa configuración. El catálogo del Centro de Control incluye app.ai con las mismas teclas predeterminadas y etiqueta localizada; la vinculación permanece inactiva sin el módulo opcional.

## Paquetes terminal

Estas teclas se aplican dentro de **Centro de Control > Administración del Sistema > Paquetes**, en lugar de aplicarse a Hyprland globalmente. `F8` vuelve a abrir la terminal de transacciones, `Esc` la oculta sin detener el proceso, `Shift+PageUp/PageDown` desplaza el historial, `Shift+End` vuelve a la salida en vivo y `Ctrl+C` interrumpe el hijo enfocado. La hoja de trucos instalada incluye las mismas teclas.

En Paquetes, `/` enfoca la barra de **Búsqueda** superior. `Enter` allí envía búsquedas de instalación Oficial/AUR; las listas de eliminación y actualización se filtran mientras escribes. `Down` se mueve a los resultados, `Up` en el primer resultado regresa a Búsqueda, y `Esc` en Búsqueda conserva la consulta y regresa a la lista. Enter en un resultado realiza la acción del paquete.
