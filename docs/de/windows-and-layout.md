---
title: Fenster und Layout
description: Verstehen Sie Lücken, Grenzen, Modi und Paneelraum in ARGVUS.
---
ARGVUS verwendet Hyprland für die Platzierung von gekachelten und schwebenden Fenstern. Die benutzerseitigen Layout-Steuerungen befinden sich auf drei Control-Center-Seiten: **Control Center → Erscheinungsbild → Taskleiste** (Position, Bereiche und Symbole), **Control Center → Desktop & Eingabe → Hyprland → Fenster → Bereiche** und **Control Center → Desktop & Eingabe → Hyprland → Ränder**.

## Die Konzepte

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```
- **Fensterabstände** sind der Raum zwischen gekachelten Fenstern und dem äußeren Rand des Kachel-Layouts.
- **Taskleiste- oder Shell-Abstände** sind der Rand um Desktop-Oberflächen wie die Taskleiste und das Panel. Es ist nicht derselbe Wert wie ein Fensterabstand.
- **Ränder** sind die sichtbaren Kanten, die um ein Fenster gezeichnet werden. **Kantenstärke** steuert die Breite des Rahmens, der auf der Erscheinungsseite sichtbar ist.
- **Abrundung** ist Teil des ausgewählten visuellen Modus. Sie verändert die Form der Fensterkante, ohne das Fenster zu verschieben.
- **Panel-Reservierung und sichtbarer Rand** sind getrennte Aspekte: Ein Panel kann Platz einnehmen oder visuell nutzen, während Hyprland die Fenster weiterhin gemäß dem aktiven Abstandszustand anordnet.

## Feste und Abstand-Modi

Die mitgelieferten Themenmodi bieten zwei Ausgangsgeometrien:

| Modus | Fensterverhalten | Oberflächenbehandlung |
| --- | --- | --- |
| Sticky | Innenabstand `2`, Außenabstand `0` standardmäßig | Eckig, kompakt und nah am Bildschirmrand |
| Spaced | Innenabstand `10`, Außenabstand `18` standardmäßig | Abgerundet, mit Schatten und großzügiger; Taskbar-/Shell-Rand standardmäßig `18` |

Dies sind Standardwerte, keine Grenzen. Die Seiten Fensterabstände und Taskbar-Abstände können Fensterabstände und Taskbar-Ränder unabhängig speichern. Das Ändern eines Designs oder Modus kann unterschiedliche effektive Layoutwerte ergeben.

## Layout-Steuerungen

Jede Steuerung ist unabhängig und befindet sich auf der hier aufgeführten Seite:

- **Taskleiste → Position** — Taskleistenposition, obere oder untere Kante.
- **Taskleiste → Abstände** — obere, linke, rechte und untere Ränder der Taskleiste, jeweils von `0` bis `100`. Sticky setzt standardmäßig den unteren Rand auf `2`; Spaced verwendet `18`.
- **Taskleiste → Symbole** — ob die Taskleisten-Dienstgruppe automatisches oder stets erweitertes Verhalten verwendet.
- **Hyprland → Fenster → Abstände** — innerer Abstand und äußerer Abstand oben/links/rechts/unten, jeweils von `0` bis `100`.
- **Hyprland → Ränder** — allgemeine Ränder: abgerundete Ecken aktivieren; wenn aktiviert, ist die Rundung von `2` bis `10` wählbar. Kantenstärke wird hier ebenfalls festgelegt, von `0` bis `10`.
- **Hyprland → Ränder → Schatten** — der Fensterschatten, standardmäßig ausgeschaltet. Es werden Bereich, Renderkraft, scharfe Ecken, Versatz und Maßstab festgelegt, und seine Farbe folgt dem Akzent des Themas mit Alpha `99`, es sei denn, eine Farbe wird manuell eingegeben.

Diese Werte werden in den ARGVUS-Aussehungszustand geschrieben, und `argvus-config` projiziert sie in die erzeugten Hyprland-Dateien, die dann von der Sitzung angewendet werden. Ein Taskleistenabstand ändert die Position der Shell-Oberfläche; ein äußerer Fensterabstand ändert den Bereich der gekachelten Fenster. Sie können eine ähnliche visuelle Distanz erzeugen, aber die Änderung des einen ändert nicht das andere.

## Fenster und Arbeitsbereiche

Gekachelte Fenster werden von Hyprland auf dem aktiven Arbeitsbereich angeordnet. ARGVUS unterstützt auch schwebende Dienstfenster; `SUPER + SHIFT + Space` schaltet das fokussierte Fenster zwischen gekachelten und schwebenden Layouts um. Die Bewegung des Arbeitsbereichs und der Fensterfokus werden durch das aktive Tastenkombinations-Manifest gesteuert; siehe [Tastenkürzel](/docs/argvus-hyprland/keyboard-shortcuts/).

Die bereitgestellte Konfiguration öffnet das Kontrollzentrum, Snake und den Datenträgernutzungs-Analyzer als schwebende, zentrierte Fenster. Der Datenträgernutzungs-Analyzer verwendet dieselbe anfängliche `1399 × 920`-Geometrie wie das Speicher-Popup der Taskleiste, angewendet durch seine Fensterklassenregel beim Öffnen des Fensters. ARGVUS Focus und ARGVUS Clock sind GTK-Layer-Shell-Popups, die neben der Taskleiste verankert sind, daher sind sie keine gekachelten Fenster und verwenden keine Hyprland-Fensterregeln. Die Weckerkarte der Uhr ist eine separate Layer-Oberfläche (`argvus-clock-alarm`).

Das Kontrollpanel verwendet eine Layer-Oberfläche im Vollbildmodus, während sein Modal geöffnet ist. Die bereitgestellten Regeln lassen den Polkit-Agenten, GTK-Portal- und KDialog-Fenster schweben, zentrieren und anheften, sodass Dialoge, die vom Panel gestartet werden, über dem Modal bleiben und Eingaben erhalten können.

`hyprpicker`, geöffnet mit `SUPER + P`, verwendet keine Hyprland-Animationen. Diese Ausnahme betrifft nur den Farbwähler; andere Animationen folgen weiterhin den globalen Einstellungen.

### Arbeitsbereichsplatzierung für Browser und IDEs

Es sind standardmäßig keine Fensterregeln auf einer frischen Installation definiert. Sie können Ihre eigenen Anwendungs-spezifischen Arbeitsbereichsplatzierungsregeln unter `hyprland.window_rules` in `argvus-config` hinzufügen, zum Beispiel:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```
Jede Regel hat eine `workspace` von 1 bis 10 und eine `classes`-Liste. Einträge in `classes` sind reguläre Ausdrücke, die auf die Fensterklasse (Groß-/Kleinschreibung beachtet) angewendet werden, zum Beispiel `[Cc]ode.*` oder `jetbrains-.*`. Es werden nur Buchstaben, Ziffern und `._*+?-[]()|^$` akzeptiert. `argvus-config` schreibt die Regeln in `generated/hypr/window-rules.lua`, die die Hyprland-Konfiguration lädt. Um die Regeln zu ersetzen, ohne die Standardwerte zu ändern, fügen Sie `hl.window_rule`-Aufrufe zu `rules.lua` in Ihrem ARGVUS-Datenverzeichnis hinzu; diese werden nach den generierten Regeln geladen.

## Was zuerst zu ändern ist

- Wenn Fenster überfüllt wirken, erhöhe den Fensterabstand oder benutze den Modus „Spaced“.
- Wenn Fenster zu weit vom Bildschirmrand entfernt erscheinen, verringere den äußeren/Taskleiste-Abstand oder benutze den Modus „Sticky“.
- Wenn die Taskleiste nach dem Ändern ihrer Position falsch ausgerichtet erscheint, überprüfe die Taskleistenposition und alle vier Taskleisten-/Shell-Ränder zusammen.
- Wenn Fenster ein visuelles Panel überlappen, überprüfe die Panel- und Taskleisten-Layout-Einstellungen, bevor du die Fensterabstände änderst.

Änderungen werden über die ARGVUS-Aussehen-/Sitzungsintegration angewendet. Verwende die Reset-Aktion der Seite, wenn verfügbar; bearbeite die automatisch erzeugten Hyprland-Dateien nicht direkt.

## Verwandt

- [Aussehen](/docs/user-guide/appearance/)
- [Themen](/docs/user-guide/appearance/)
- [Taskleiste](/docs/argvus-taskbar/taskbar/)
- [Systemsteuerung](/docs/argvus-control-panel/)

## Fensterwackeln

Öffne **Desktop & Eingabe → Hyprland → Animationen → Fenster** und benutze die
**Wackel**-Steuerung. Suche nach `wobble` oder öffne die Seite direkt:

```sh
argvus control-center hyprland animations windows
```
Wackeln ist standardmäßig deaktiviert. Seine ARGVUS-Standardeinstellungen sind Steifigkeit `100`, Dämpfung `10`, Masse `1`, Intensität `1` und Mesh-Auflösung `8`. Steifigkeit und Masse akzeptieren `0.0001–1000`, Dämpfung `0–1000`, Intensität `0–2`, und Mesh eine Ganzzahl `2–32`. Eine höhere Mesh-Auflösung erhöht die Rendering-Kosten. Verwenden Sie die Pfeiltasten, um Werte anzupassen, oder Enter, um sie einzugeben. **Wackel-Standardeinstellungen wiederherstellen** ändert den Entwurf; **Anwenden** speichert alle ausstehenden Animationsbearbeitungen und lädt Hyprland einmal neu, ohne die Sitzung neu zu starten. Zurückgehen innerhalb von Animationen behält den geteilten Entwurf bei.

Der globale Animationsschalter unterdrückt das Wackeln, während die individuellen Einstellungen beibehalten werden. Die kanonischen Werte befinden sich unter `effects.wobble_*` im ARGVUS-Zustand; `hypr/state.lua` wird generiert und darf nicht manuell bearbeitet werden.

Dies erfordert Hyprland **0.57.0 oder neuer**, durch die Paketabhängigkeit von `argvus-hyprland` vorgeschrieben. Version 0.56 wird für diese Konfiguration nicht unterstützt. Das maximale Intensitätsniveau folgt der [veröffentlichten 0.57.0-Quelle](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp), die es auf `2` begrenzt, auch wenn neuere Dokumentationen möglicherweise `3` angeben.

## Globaler Fenstermodus

Öffnen Sie **Systemsteuerung → Desktop & Eingabe → Hyprland → Fenster → Modus** und wählen Sie **Fenster kacheln (Standard)** oder **Schwebende Fenster**. Derselbe Selektor ist auch über das Fenstermodus-Symbol in der Taskleiste verfügbar.

Die Einstellung gilt für jeden Monitor und Arbeitsplatz und wird nach dem Abmelden gespeichert. Floating wandelt bestehende Anwendungsfenster und neu geöffnete Fenster um. Tile stellt nur Fenster wieder her, die durch diese Richtlinie konvertiert wurden; Dialoge und andere Fenster, die bereits im Floating-Modus sind, bleiben im Floating-Modus. Ein Fenster, das explizit angepinnt ist, während Floating aktiv ist, bleibt ebenfalls im Floating-Modus, um seine Anheftung zu erhalten. Das gekachelte Layout wird neu berechnet; sein exakter vorheriger Split-Baum wird nicht wiederhergestellt.

`SUPER + SHIFT + Space` behält sein normales Verhalten pro Fenster im Tile-Modus bei. Im Floating-Modus wechselt es ein Fenster nicht zurück zum Kachelmodus. Panels, die Taskleiste und Benachrichtigungen sind Layer-Shell-Oberflächen und werden nicht beeinflusst. Der Vollbildmodus verwendet weiterhin das normale Verhalten von Hyprland; ARGVUS-Maximierung bewahrt die Ränder im Spaced-Modus.

Die kanonische Voreinstellung ist `/hyprland/window_mode` in `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. Ihre erzeugte Projektion ist `data/generated/hypr/window-mode.lua`; bearbeiten Sie sie nicht. Das Registrierungsarchiv für die Wiederherstellung pro Fenster befindet sich unter `$XDG_RUNTIME_DIR/argvus`, ist auf die Kompositorinstanz beschränkt und übersteht Konfigurationsneuladungen. Es wird in einer neuen Sitzung nicht wiederverwendet.

Wenn die Anwendung aussteht oder fehlschlägt, unterscheidet die Schnittstelle dies von der gespeicherten Voreinstellung. Wählen Sie die Option erneut, um es wieder zu versuchen. Ohne einen Kompositor wird die Voreinstellung für die nächste Anmeldung gespeichert.

## Fenster-Buttons und Anwendungsleiste

Der Schwebemodus fügt ein ARGVUS-Titelleiste mit **Minimieren**, **Maximieren / Wiederherstellen** und **Schließen** zu normalen Anwendungsfenstern hinzu. Ein Doppelklick auf die Titelleiste schaltet die Maximierung um. Die zusätzliche Dekoration wird in Kachel- und Vollbildansichten ausgeblendet. Anwendungen, die ihre eigenen Steuerelemente zeichnen, können beide Leisten anzeigen; einheitliche ARGVUS-Steuerelemente sind beabsichtigt.

Eine zweite Waybar erscheint auf jedem Monitor, am gegenüberliegenden Rand der Haupttaskleiste. Sie listet nur die Fenster des aktuellen Arbeitsbereichs dieses Monitors, einschließlich der minimierten Fenster. Versteckte Gruppentabs erzeugen keine zusätzlichen Einträge. Minimierte Einträge behalten ihre ursprüngliche Monitor-/Arbeitsbereichszuordnung bei. Klicken Sie auf ein inaktives Fenster, um es zu aktivieren, auf ein aktives Fenster, um es zu minimieren, oder auf ein minimiertes Fenster, um es wiederherzustellen; sein Kontextmenü bietet Wiederherstellen, Minimieren, Maximieren/Wiederherstellen und Schließen. Symbole unbekannter Anwendungen fallen auf ein Fenstersymbol zurück. Das Aktivieren oder Wiederherstellen eines Eintrags behält die Position des Zeigers bei. Die sekundäre Leiste verwendet die effektive primäre CSS (Farben, Schriftarten, Rahmen und Abrundungen), mit ihrer Höhe und den gespiegelten Rändern am gegenüberliegenden Rand.

`SUPER + Alt + Up` platziert die Hauptleiste oben und die Fensterleiste unten. `SUPER + Alt + Down` macht das Gegenteil. Wird eine Richtung wiederholt, bleiben die Positionen unverändert. Kachel hat nur die Hauptleiste. Die Rückkehr zur Kachel stellt alle minimierten Fenster wieder her, bevor die Fensterleiste entfernt wird, und bewahrt dann die ursprüngliche Kachel-/Schwebe-Strategie.

Die Minimierung verwendet den reservierten Arbeitsbereich `special:argvus-minimized`. Verwenden Sie diesen Arbeitsbereich nicht manuell. Der Prozess `argvus windows service` zeichnet Identität, ursprünglichen Arbeitsbereich/Monitor, Geometrie, Vollbild/Maximierung und Pinnstatus in einem compositorspezifischen Laufzeit-Register unter `$XDG_RUNTIME_DIR/argvus` auf. Die Aufzeichnungen überleben einen Dienstneustart oder das Neuladen der Konfiguration, überschreiten jedoch nicht die Compositor-Sitzungen. Das Schließen eines Fensters entfernt seinen Eintrag. Verschwindet ein Monitor, wird bei der Wiederherstellung ein verfügbarer Ausgang verwendet. Eine fehlende oder fehlgeschlagene Wiederherstellungsleiste verhindert neue Minimierungen; eine fehlgeschlagene Wiederherstellung behält den Eintrag und die Wiederherstellungsleiste bei.

Die Sitzung besitzt `argvus-windows.service` und `argvus-window-bar.service`. Letzterer hält sein Waybar-Kind im Tile-Modus inaktiv. Das Hyprbars-Plugin wird von `argvus-hyprland` gebündelt, gebaut für die Hyprland 0.57.0 ABI auf x86_64; es ist nicht im Home-Verzeichnis des Benutzers kompiliert. Bauen Sie das Plugin bei einem Update der Compositor-ABI neu.Befehle: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` und `minimize|restore|activate|maximize|close ADDRESS`. Die Fensteradressen stammen aus der Liste. `position top --persist` speichert/projektiert die Voreinstellung, ohne die Hauptleiste neu zu starten. Konfigurations- und Laufzeitfehlerdetails werden im Journal geschrieben; sichtbare Aktionsfehler zeigen ebenfalls eine übersetzte Benachrichtigung an.

In **Spaced + Floating** respektieren Fenster äußere Abstände und die von beiden Leisten reservierten Bereiche. Die Begrenzungen beinhalten Rahmen und Titel, der innerhalb desselben Fensterrahmens sitzt. Maximieren über ARGVUS-Steuerungen füllt diesen Bereich mit Rand; Wiederherstellen bringt die vorherige Geometrie zurück, auch nach einem Dienstneustart. Vollbild nutzt weiterhin die gesamte Ausgabe. Schwebende Fenster können sich überlappen; innere Lücken im Kachelmodus trennen sie nicht.

`SUPER + Alt + Space` schaltet den globalen Kachel-/Schwebemodus um und verwendet dieselbe Einstellung wie die Taskleiste und das Kontrollzentrum. Der entsprechende Befehl ist `argvus config window-mode toggle`. Gleichzeitige Aufrufe werden serialisiert; das Umschalten verwendet die gespeicherte Einstellung, auch wenn die Anwendung aussteht. Die Verknüpfung kann in den Tastaturkürzeln geändert oder deaktiviert werden; `SUPER + Shift + Space` behält ihre Aktion für einzelne Fenster bei.
