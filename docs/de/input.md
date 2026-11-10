---
title: Maus und Touchpad
description: Konfigurieren Sie das Verhalten von Zeiger und Touchpad in ARGVUS.
---
Öffnen Sie **Systemsteuerung → Sprache & Region → Maus & Touchpad**, oder führen Sie `argvus control-center input` aus.

## Maus

Wenn eine Maus erkannt wird, zeigt die Seite an:

- Empfindlichkeit von `-1.0` bis `1.0`;
- adaptives oder flaches Beschleunigungsprofil;
- Scrollfaktor von `0.1` bis `10.0`;
- natürliches Scrollen;
- linkshändige Tastenbelegung.

Empfindlichkeit, Scrollfaktor und die Schalter gelten in Hyprland, solange die Seite geöffnet ist, danach wird der komplette Eingabestatus gespeichert. Die Seite liest den aktuellen Wert des Compositors, wenn keine ARGVUS-Eingabedatei vorhanden ist.

## Touchpad

Wenn ein Touchpad erkannt wird, zeigt die Seite natürliches Scrollen, Tippen zum Klicken, Tippen und Ziehen, Rechtsklick mit zwei Fingern und Deaktivieren beim Tippen. Diese Optionen werden nur als nützliche Steuerungen angezeigt, wenn die laufende Sitzung ein Touchpad meldet.

## Hardwareabhängige Steuerungen

Erweiterte Mauskontrollen, die durch `ratbag` unterstützt werden, werden nur für unterstützte Geräte angezeigt. ARGVUS behauptet nicht, dass jede Maus DPI, Profile oder Abtastratenänderungen unterstützt. Wenn ein Gerät nicht erkannt wird oder der optionale Geräteservice nicht verfügbar ist, können diese Steuerungen auf dieser Seite nicht angewendet werden. 

## Persistenz und Zurücksetzen

Die Einstellungen werden als Benutzerzustand gespeichert und ein generiertes Hyprland-Eingabefragment wird für die Sitzung neu erstellt. Verwenden Sie die Zurücksetzen-Aktion der Seite, wenn diese vorhanden ist; bearbeiten Sie das generierte Fragment nicht direkt. Eine Einstellung kann nur für den aktuellen Kompositor gelten, wenn die Sitzung den relevanten Gerätezustand nicht neu laden kann.

Siehe [Control Center](/docs/components/argvus-control-center/)] und [Where to configure things](/docs/user-guide/where-to-configure/)].
