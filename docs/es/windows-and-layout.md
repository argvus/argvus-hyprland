---
title: Ventanas y diseño
description: Comprende las brechas, los bordes, los modos y el espacio del panel en ARGVUS.
---
ARGVUS utiliza Hyprland para la colocación de ventanas en mosaico y flotantes. Los controles de diseño visibles para el usuario se encuentran en tres páginas del Centro de Control: **Centro de Control → Apariencia → Barra de Tareas** (posición, espacios e íconos), **Centro de Control → Escritorio y Entrada → Hyprland → Ventanas → Espacios** y **Centro de Control → Escritorio y Entrada → Hyprland → Bordes**.

## Los conceptos

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```
- **Espacios entre ventanas** son el espacio entre ventanas en mosaico y el borde exterior del diseño en mosaico.
- **Espaciado de barra de tareas o shell** es el margen alrededor de las superficies del escritorio, como la barra de tareas y el panel. No es el mismo valor que un espacio entre ventanas.
- **Bordes** son el borde visible dibujado alrededor de una ventana. **Grosor del borde** controla el ancho del borde que se muestra en la página de apariencia.
- **Redondeo** es parte del modo visual seleccionado. Cambia la forma de las esquinas de la ventana en lugar de mover la ventana.
- **Reserva de panel y margen visible** son preocupaciones separadas: un panel puede ocupar o usar espacio visualmente mientras Hyprland aún organiza las ventanas de acuerdo al estado de espaciado activo.

## Modos Pegajoso y Espaciado

Los modos de tema incluidos proporcionan dos geometrías iniciales:

| Modo | Comportamiento de la ventana | Tratamiento de la superficie |
| --- | --- | --- |
| Pegajoso | Espacio interno `2`, espacio externo `0` por defecto | Cuadrado, compacto y cerca del borde de la pantalla |
| Separado | Espacio interno `10`, espacio externo `18` por defecto | Redondeado, con sombra y más espacioso; el margen de la barra de tareas/shell por defecto es `18` |

Estos son valores por defecto, no límites. Las páginas de espacios de ventanas y espacios de la barra de tareas pueden almacenar los espacios de las ventanas y los márgenes de la barra de tareas de forma independiente. Cambiar un tema o modo puede proyectar diferentes valores efectivos del diseño.

## Controles de diseño

Cada control es independiente y se encuentra en la página que se indica aquí:

- **Barra de tareas → Posición** — posición de la barra de tareas, borde superior o inferior.
- **Barra de tareas → Espacios** — márgenes de la barra de tareas superior, izquierdo, derecho e inferior, cada uno de `0` a `100`. Sticky establece por defecto el margen inferior en `2`; Spaced usa `18`.
- **Barra de tareas → Iconos** — si el grupo de utilidades de la barra de tareas utiliza comportamiento automático o siempre expandido.
- **Hyprland → Ventanas → Espacios** — espacio interno y márgenes externos superior/izquierdo/derecho/inferior, cada uno de `0` a `100`.
- **Hyprland → Bordes** — bordes generales: habilitar esquinas redondeadas; cuando está habilitado, el redondeo se puede seleccionar de `2` a `10`. El grosor del borde también se establece aquí, de `0` a `10`.
- **Hyprland → Bordes → Sombra** — la sombra de la ventana, desactivada por defecto. Establece el rango, potencia de renderizado, esquinas definidas, desplazamientos y escala, y su color sigue el acento del tema con alfa `99` a menos que se escriba un color.

Estos valores se escriben en el estado de apariencia de ARGVUS, y `argvus-config` los proyecta en los archivos generados de Hyprland que luego aplica la sesión. Un margen de la barra de tareas cambia la posición de la superficie del shell; un espacio entre ventanas externas cambia el área de ventanas en mosaico. Pueden producir una distancia visual similar, pero cambiar uno no cambia el otro.

## Ventanas y espacios de trabajo

Las ventanas en mosaico son organizadas por Hyprland en el espacio de trabajo activo. ARGVUS también soporta ventanas de utilidad flotantes; `SUPER + SHIFT + Space` alterna la ventana enfocada entre los diseños en mosaico y flotante. El movimiento del espacio de trabajo y el enfoque de la ventana son controlados por el manifiesto de teclas activas; vea [Atajos de teclado](/docs/argvus-hyprland/keyboard-shortcuts/).

La configuración empaquetada abre el Centro de Control, Snake y el Analizador de Uso de Disco como ventanas flotantes y centradas. El Analizador de Uso de Disco utiliza la misma geometría inicial `1399 × 920` que el popup de memoria de la barra de tareas, aplicada por su regla de clase de ventana cuando se abre la ventana. ARGVUS Focus y ARGVUS Clock son popups de GTK layer-shell anclados al lado de la barra de tareas, por lo que no son ventanas en mosaico y no utilizan las reglas de ventana de Hyprland. La tarjeta de alarma del Reloj es una superficie de capa separada (`argvus-clock-alarm`).

El Panel de Control utiliza una superficie de capa de pantalla completa mientras su modal está abierto. Las reglas empaquetadas flotan, centran y fijan las ventanas del agente Polkit, el portal GTK y KDialog para que los diálogos lanzados por el panel permanezcan sobre el modal y puedan recibir entradas.

`hyprpicker`, abierta con `SUPER + P`, no utiliza animaciones de Hyprland. Esta excepción afecta únicamente al selector de color; otras animaciones continúan siguiendo la configuración global.

### Ubicación de espacios de trabajo para navegadores e IDEs

No se definen reglas de ventana por defecto en una instalación nueva. Puedes agregar tus propias reglas de ubicación de espacios de trabajo por aplicación bajo `hyprland.window_rules` en `argvus-config`, por ejemplo:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```
Cada regla tiene un `workspace` de 1 a 10 y una lista `classes`. Las entradas en `classes` son expresiones regulares que se comparan con la clase de ventana (sensible a mayúsculas y minúsculas), por ejemplo `[Cc]ode.*` o `jetbrains-.*`. Solo se aceptan letras, dígitos y `._*+?-[]()|^$`. `argvus-config` escribe las reglas en `generated/hypr/window-rules.lua`, que se cargan en la configuración de Hyprland. Para reemplazar las reglas sin cambiar los valores predeterminados, agregue llamadas `hl.window_rule` a `rules.lua` en su directorio de datos ARGVUS; estas se cargan después de las reglas generadas.

## Qué cambiar primero

- Si las ventanas se sienten abarrotadas, aumente la separación entre ventanas o use el modo Espaciado. 
- Si las ventanas parecen demasiado alejadas del borde de la pantalla, reduzca el espacio exterior/la barra de tareas o use el modo Pegajoso. 
- Si la barra de tareas aparece desalineada después de cambiar su posición, revise la posición de la barra de tareas y los cuatro márgenes de la barra de tareas/shell juntos. 
- Si las ventanas se superponen a un panel visual, revise la configuración del panel y la barra de tareas antes de cambiar los espacios entre ventanas.

Los cambios se aplican a través de la integración de apariencia/sesión de ARGVUS. Use la acción de restablecer de la página donde esté disponible; no edite directamente los archivos generados de Hyprland.

## Relacionados

- [Apariencia](/docs/user-guide/appearance/)
- [Temas](/docs/user-guide/appearance/)
- [Barra de tareas](/docs/argvus-taskbar/taskbar/)
- [Panel de control](/docs/argvus-control-panel/)

## Oscilación de ventanas

Abra **Escritorio y Entrada → Hyprland → Animaciones → Ventanas** y use los controles de **Oscilación**. Busque `wobble`, o abra la página directamente:

```sh
argvus control-center hyprland animations windows
```
El movimiento oscilante está desactivado por defecto. Sus valores predeterminados en ARGVUS son rigidez `100`, amortiguamiento `10`, masa `1`, intensidad `1` y resolución de malla `8`. La rigidez y la masa aceptan `0.0001–1000`, el amortiguamiento `0–1000`, la intensidad `0–2`, y la malla un número entero `2–32`. Una mayor resolución de malla aumenta el coste de renderizado. Usa las teclas de flecha para ajustar los valores o Enter para escribirlos. **Restaurar los valores predeterminados de Wobble** cambia el borrador; **Aplicar** guarda todas las ediciones pendientes de animación y recarga Hyprland una vez, sin reiniciar la sesión. Volver dentro de Animations mantiene el borrador compartido. 

El interruptor global de Animations suprime Wobble mientras mantiene sus configuraciones individuales. Los valores canónicos se encuentran bajo `effects.wobble_*` en el estado ARGVUS; `hypr/state.lua` se genera y no debe editarse manualmente.

Esto requiere Hyprland **0.57.0 o más reciente**, impuesto por la dependencia del paquete de `argvus-hyprland`. La versión 0.56 no es compatible con esta configuración. El máximo de intensidad sigue el [código fuente de la versión 0.57.0 liberada](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp), que lo limita a `2`, aunque la documentación más reciente pueda listar `3`.

## Modo de ventana global

Abra **Centro de Control → Escritorio y Entrada → Hyprland → Ventanas → Modo** y seleccione **Ventanas en mosaico (Predeterminado)** o **Ventanas flotantes**. El mismo selector está disponible desde el ícono de modo de ventana en el grupo de utilidad de la barra de tareas.

La preferencia se aplica a cada monitor y espacio de trabajo y se recuerda después de cerrar sesión. Flotante convierte las ventanas de aplicación existentes y las ventanas recién abiertas. Mosaico solo restaura las ventanas que esta política convirtió; los diálogos y otras ventanas que ya estaban flotando permanecen flotando. Una ventana fijada explícitamente mientras Flotante está activo también permanece flotando para conservar su fijación. El diseño en mosaico se recalcula; no se restaura su árbol de división exacto anterior.

`SUPER + SHIFT + Space` mantiene su comportamiento normal por ventana en Mosaico. En Flotante, no cambia una ventana de nuevo a mosaico. Los paneles, la barra de tareas y las notificaciones son superficies de capa-shell y no se ven afectados. Pantalla completa continúa usando el comportamiento normal de Hyprland; la maximización ARGVUS conserva los márgenes en Espaciado.

La preferencia canónica es `/hyprland/window_mode` en `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. Su proyección generada es `data/generated/hypr/window-mode.lua`; no la edite. El registro de restauración por ventana se encuentra bajo `$XDG_RUNTIME_DIR/argvus`, limitado a la instancia del compositor, y sobrevive a las recargas de configuración. No se reutiliza en una nueva sesión.

Si la aplicación está pendiente o falla, la interfaz lo distingue de la preferencia guardada. Seleccione la opción de nuevo para reintentar. Sin un compositor, la preferencia se guarda para el próximo inicio de sesión.

## Botones de ventana y barra de aplicación

El modo flotante añade una barra de título ARGVUS con **Minimizar**, **Maximizar / Restaurar** y **Cerrar** a las ventanas normales de la aplicación. Hacer doble clic en la barra de título alterna la maximización. La decoración adicional se oculta en Mosaico y pantalla completa. Las aplicaciones que dibujan sus propios controles pueden mostrar ambas barras; los controles ARGVUS uniformes son intencionales.

Una segunda Waybar aparece en cada monitor, en el borde opuesto a la barra de tareas principal. Solo lista las ventanas del espacio de trabajo actual de ese monitor, incluyendo sus ventanas minimizadas. Las pestañas de grupo ocultas no crean entradas adicionales. Las entradas minimizadas conservan su asociación original con el monitor/espacio de trabajo. Haga clic en una ventana inactiva para activarla, en una ventana activa para minimizarla, o en una ventana minimizada para restaurarla; su menú contextual ofrece restaurar, minimizar, maximizar/restaurar y cerrar. Los íconos de aplicaciones desconocidas se reemplazan por un símbolo de ventana. Activar o restaurar una entrada preserva la posición del puntero. La barra secundaria utiliza el CSS primario efectivo (colores, fuentes, bordes y redondeo), con su altura y márgenes reflejados en el borde opuesto.

`SUPER + Alt + Up` coloca la barra principal en la parte superior y la barra de ventana en la parte inferior. `SUPER + Alt + Down` hace lo contrario. Repetir una dirección deja las posiciones sin cambios. Tile solo tiene la barra principal. Volver a Tile restaura todas las ventanas minimizadas antes de quitar la barra de ventana y luego preserva la política original de mosaico/flotante.

La minimización utiliza el espacio de trabajo reservado `special:argvus-minimized`. No use ese espacio de trabajo manualmente. El proceso `argvus windows service` registra la identidad, el espacio de trabajo/monitor original, la geometría, el estado de pantalla completa/maximización y el estado de fijación en un registro de tiempo de ejecución específico de la instancia del compositor bajo `$XDG_RUNTIME_DIR/argvus`. Los registros sobreviven a un reinicio del servicio o recarga de configuración, pero no cruzan sesiones del compositor. Cerrar una ventana elimina su registro. Si un monitor desaparece, la restauración utiliza una salida disponible. Una barra de recuperación faltante o con fallo evita nuevas minimizaciones; la restauración fallida conserva el registro y la barra de recuperación.

La sesión posee `argvus-windows.service` y `argvus-window-bar.service`. Esta última mantiene su hijo Waybar inactivo en Tile. El plugin hyprbars está incluido por `argvus-hyprland`, construido para la ABI de Hyprland 0.57.0 en x86_64; no se compila en el directorio de inicio del usuario. Reconstruya el plugin con una actualización de ABI del compositor.Comandos: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` y `minimize|restore|activate|maximize|close ADDRESS`. Las direcciones de las ventanas provienen de la lista. `position top --persist` almacena/proyecta la preferencia sin reiniciar la barra principal. Los detalles de configuración y errores en tiempo de ejecución se escriben en el diario; las fallas visibles de acción también muestran una notificación traducida.

En **Espaciado + Flotante**, las ventanas respetan los huecos exteriores y las áreas reservadas por ambas barras. Los límites incluyen el borde y el título, que se encuentra dentro del mismo borde de la ventana. Maximizar a través de ARGVUS llena esta área con márgenes; restaurar recupera la geometría anterior, incluso después de reiniciar un servicio. La pantalla completa aún utiliza toda la salida. Las ventanas flotantes pueden superponerse; los huecos internos en mosaico no las separan.

`SUPER + Alt + Space` alterna el modo global de Azulejo/Flotante, utilizando la misma preferencia que la barra de tareas y el Centro de Control. El comando equivalente es `argvus config window-mode toggle`. Las invocaciones concurrentes se serializan; alternar utiliza la preferencia guardada incluso cuando la aplicación está pendiente. El atajo se puede cambiar o desactivar en Atajos de Teclado; `SUPER + Shift + Space` mantiene su acción de ventana individual.
