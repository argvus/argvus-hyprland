---
title: Ratón y panel táctil
description: Configure el comportamiento del puntero y del panel táctil en ARGVUS.
---
Abre **Centro de Control → Configuración Regional y de Idioma → Ratón y Panel Táctil**, o ejecuta `argvus control-center input`.

## Ratón

Cuando se detecta un ratón, la página muestra:

- sensibilidad de `-1.0` a `1.0`;
- perfil de aceleración adaptativa o plana;
- factor de desplazamiento de `0.1` a `10.0`;
- desplazamiento natural;
- disposición de botones para zurdos.

La sensibilidad, el factor de desplazamiento y los interruptores se aplican a través de Hyprland mientras la página está abierta, luego se guarda el estado completo de entrada. La página lee el valor actual del compositor cuando no existe un archivo de entrada ARGVUS.

## Panel táctil

Cuando se detecta un panel táctil, la página muestra desplazamiento natural, tocar para hacer clic, tocar y arrastrar, clic derecho con dos dedos y desactivar mientras se escribe. Estas opciones solo se muestran como controles útiles cuando la sesión en ejecución reporta un panel táctil.

## Controles dependientes del hardware

Los controles avanzados del ratón respaldados por `ratbag` se muestran solo para dispositivos compatibles. ARGVUS no garantiza que todos los ratones soporten cambios de DPI, perfiles o sondeo. Si no se detecta un dispositivo o el servicio opcional del dispositivo no está disponible, esos controles no pueden aplicarse mediante esta página.

## Persistencia y restablecimiento

Los ajustes se almacenan como estado de usuario y se regenera un fragmento de entrada de Hyprland para la sesión. Utilice la acción de restablecimiento de la página cuando esté presente; no edite el fragmento generado directamente. Un ajuste solo puede aplicarse al compositor actual cuando la sesión no puede recargar el estado relevante del dispositivo.

Vea [Centro de control](/docs/components/argvus-control-center/) y [Dónde configurar cosas](/docs/user-guide/where-to-configure/).
