---
title: Tastenkombinationen
description: Finden Sie die Tastenkombinationen, die von der ARGVUS Hyprland-Konfiguration bereitgestellt werden.
---
Öffnen Sie **Systemsteuerung → Desktop & Eingabe → Tastenkombinationen**, oder führen Sie `argvus control-center keybindings` aus.

## Was die Seite macht

**Alle Tastenkombinationen** durchsucht und gruppiert das aktive Keybinding-Manifest. Sie können eine Bindung auswählen, ihre Tastenkombination bearbeiten, eine neue Kombination erfassen, eine konfigurierbare Bindung aktivieren oder deaktivieren und alle Tastenkombinationen über die Wiederherstellungsaktion der Seite zurücksetzen. Eine Tastenkombination muss eine Nicht-Modifikatortaste enthalten; der Editor normalisiert Namen wie Super/Win, Strg, Alt, Umschalt, Pfeile, Funktionstasten und Medientasten. `SUPER + Y` öffnet **Systemsteuerung → Erscheinungsbild → Hintergrundbilder**.

Offizielle Tastenkürzeländerungen werden in `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json` gespeichert, dargestellt durch `/keyboard_shortcuts` im logischen Modell; das generierte Hyprland-Fragment wird unter `~/.config/argvus/data/generated/hypr/` geschrieben. Ein deaktiviertes Tastenkürzel wird durch `null` dargestellt. Tasten sind stabile englische Konfigurationsschlüssel, unabhängig von der gewählten Spracheinstellung: Eine Manifest-ID wie `window.close` wird `close_window` zugeordnet, während `window.drag_mouse` `drag_window__floating_window_only` zugeordnet wird. Der alte Abschnitt `/hyprland/keybindings` und `keybindings.toml` sind nur für Migrationen. ARGVUS plant ein Sitzungsneuladen nur, wenn der Projektionsplan eine tatsächliche Änderung meldet.

**Shortcuts erstellen** erstellt eine globale Tastenkombination unabhängig vom gepackten Manifest. Geben Sie eine Beschreibung, Tasten und entweder einen Befehl oder einen unterstützten Lua-Dispatcher an (zum Beispiel `window.float` mit JSON-Argumenten `{"action":"toggle"}`). **Erstellen** speichert und wendet sie an, und wählt sie dann unter **Alle Shortcuts → Benutzerdefinierte Shortcuts** aus. Abbrechen oder `Esc` verwirft den Entwurf. Erstellung und Erfassung führen den Befehl nicht aus.

Benutzerdefinierte Tastenkombinationen können bearbeitet, aktiviert/deaktiviert und mit Bestätigung gelöscht werden. Konflikte mit aktivierten Tastenkombinationen im gleichen Kontext erfordern eine Austauschbestätigung; geschützte Belegungen können nicht ersetzt werden. Das Wiederherstellen der offiziellen Standardwerte bewahrt benutzerdefinierte Einträge. Wenn das Wiederherstellen mit einer aktiven benutzerdefinierten Tastenkombination kollidieren würde, ändern oder deaktivieren Sie diese benutzerdefinierte Tastenkombination zuerst. Benutzerdefinierte Definitionen werden unter `/hyprland/custom_shortcuts` in `$XDG_CONFIG_HOME/argvus/config/hyprland.json` gespeichert. Die generierte `data/generated/hypr/custom-shortcuts.lua` wird mit dem vorhandenen geschützten Loader geladen; ungültige Registrierungen werden protokolliert, ohne den Rest der Konfiguration abzubrechen. Speicherfehler bewahren den Entwurf; Anwendungsfehler melden, dass der Eintrag gespeichert wurde und erneut versucht werden kann.

Führen Sie `argvus control-center shortcuts create` oder `argvus control-center shortcuts list` aus, um eine der Seiten zu öffnen. Für erweiterte Subkarten, Maustastenbindungen oder Flags bleibt [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) verfügbar. Bearbeiten Sie niemals die generierten Fragmente.

## Aktueller Bezug

Das Basismanifest und die installierten Cheatsheets befinden sich unter `/usr/share/argvus/hyprland/`. Die aktive Benutzerüberschreibung ist kein Ersatzmanifest: Sie ändert die im Control Center ausgewählten Einträge. Aus diesem Grund kann eine versionsspezifische, manuell kopierte Liste veralten.

Einige nützliche integrierte Aktionen umfassen das Verschieben des Fokus und der Arbeitsbereiche, das Umschalten von schwebenden Fenstern, Screenshots und Aufnahmen, das Öffnen des Launchers/Terminals, das Ändern des Erscheinungsbildes, das Sperren der Sitzung, die Steuerung von Medien und das Neuladen von Hyprland. Die Standardbelegungen sind in der unten stehenden [Standard-Tastenkürzeltabelle](#default-shortcut-table) aufgelistet; die Seite des Kontrollzentrums zeigt die Belegungen so, wie sie derzeit konfiguriert sind.

`SUPER + Shift + R` ist das explizite Laufzeit-Neuladen: Es lädt Hyprland neu und startet die ARGVUS-Taskleiste, die Systemsteuerung und die Widget-Telemetrie-Dienste neu. Konfigurationsbasierte Neuladungen bleiben bedingt und überspringen das grafische Neuladen, wenn der kanonische Zustand unverändert ist.

## Standard-Tastenkürzeltabelle

Die Tabelle listet die Belegungen des Basismanifests (`/usr/share/argvus/hyprland/keybindings.json`) mit ihren Standardtasten auf. Eigene Änderungen im Kontrollzentrum ersetzen die hier gezeigten Tasten für die betroffenen Belegungen, und deaktivierte Belegungen werden nicht ausgeführt.### Navigation

| Shortcut | Beschreibung |
| --- | --- |
| `SUPER + Left Arrow` | Kachel-Fenster nach Richtung fokussieren |
| `SUPER + Right Arrow` | Kachel-Fenster nach Richtung fokussieren |
| `SUPER + Up Arrow` | Kachel-Fenster nach Richtung fokussieren |
| `SUPER + Down Arrow` | Kachel-Fenster nach Richtung fokussieren |
| `SUPER + CTRL + Left Arrow` | Fokus zwischen Fenstern (kachelig und frei beweglich) wechseln |
| `SUPER + CTRL + Right Arrow` | Fokus zwischen Fenstern (kachelig und frei beweglich) wechseln |

### Arbeitsbereiche

| Shortcut | Beschreibung |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Zwischen Arbeitsbereichen wechseln |
| `CTRL + ALT + Left Arrow` | Zwischen Arbeitsbereichen wechseln |
| `Mouse extra button (mouse:276)` | Zwischen Arbeitsbereichen wechseln |
| `Mouse side button (mouse:275)` | Zwischen Arbeitsbereichen wechseln |
| `SUPER + 1` | Arbeitsbereich 1 |
| `SUPER + 2` | Arbeitsbereich 2 |
| `SUPER + 3` | Arbeitsbereich 3 |
| `SUPER + 4` | Arbeitsbereich 4 |
| `SUPER + 5` | Arbeitsbereich 5 |
| `SUPER + 6` | Arbeitsbereich 6 |
| `SUPER + 7` | Arbeitsbereich 7 |
| `SUPER + 8` | Arbeitsbereich 8 |
| `SUPER + 9` | Arbeitsbereich 9 |
| `SUPER + CTRL + 1` bis `SUPER + CTRL + 9` | Öffnet das Projekt an dieser Position von `argvus projects` |
| `SUPER + Shift + 1` | Fenster auf Desktop 1 verschieben |
| `SUPER + Shift + 2` | Fenster auf Desktop 2 verschieben |
| `SUPER + Shift + 3` | Fenster auf Desktop 3 verschieben |
| `SUPER + Shift + 4` | Fenster auf Desktop 4 verschieben |
| `SUPER + Shift + 5` | Fenster auf Desktop 5 verschieben |
| `SUPER + Shift + 6` | Fenster auf Desktop 6 verschieben |
| `SUPER + Shift + 7` | Fenster auf Desktop 7 verschieben |
| `SUPER + Shift + 8` | Fenster auf Desktop 8 verschieben |
| `SUPER + Shift + 9` | Fenster auf Desktop 9 verschieben |

### Windows

| Verknüpfung | Beschreibung |
| --- | --- |
| `SUPER + S` | Fenster maximieren (umschalten) |
| `SUPER + Q` | Fenster schließen |
| `SUPER + Shift + Space` | Schwebendes Fenster aktivieren/deaktivieren |
| `SUPER + F` | Fenster im Vollbild |
| `SUPER + E` | Vertikal/Horizontal teilen (umschalten) |
| `SUPER + W` | In Registerkarten gruppieren/aus Gruppen lösen |
| `SUPER + Tab` | Zwischen Registerkarten navigieren |
| `SUPER + Shift + Left Arrow` | Fenster verschieben |
| `SUPER + Shift + Right Arrow` | Fenster verschieben |
| `SUPER + Shift + Up Arrow` | Fenster verschieben |
| `SUPER + Shift + Down Arrow` | Fenster verschieben |
| `SUPER + Left mouse button (mouse:272)` | Fenster ziehen (nur schwebendes Fenster) |
| `SUPER + Right mouse button (mouse:273)` | Fenstergrößenmodus (nur schwebendes Fenster) |
| `SUPER + R` | Fenstergrößenmodus eingeben (nur schwebendes Fenster) |

### Anwendungen

| Tastenkürzel | Beschreibung |
| --- | --- |
| `SUPER + Enter` | Terminal |
| `SUPER + [` | Terminal-Notizblock (Dropdown auf einem speziellen Arbeitsbereich; erneut drücken, um zu verbergen) |
| `SUPER + Space` | Dateimanager |
| `SUPER + CTRL + Space` | Systemmonitor |
| `SUPER + Shift + D` | Menü für Wechselmedien |
| `SUPER + Shift + F` | ARGVUS Fokus (Pomodoro- und Fokussitzungen) |
| `SUPER + Shift + C` | ARGVUS Uhr (Uhr, Timer und Alarme) |
| `SUPER + D` | Programmstarter |
| `SUPER + B` | Standardbrowser |
| `SUPER + C` | Rechner |
| `SUPER + ALT + S` | SSH-Host-Auswahl (`argvus ssh`) |
| `SUPER + ALT + N` | Snippet-Auswahl (`argvus snippets`) |
| `SUPER + ALT + G` | Projekt-Auswahl, dann Git-TUI (lazygit oder gitui) im gewählten Projekt (`argvus git`) |

### Medien

| Tastenkürzel | Beschreibung |
| --- | --- |
| `XF86AudioRaiseVolume` | Lautstärke erhöhen |
| `Volume Down` | Lautstärke verringern |
| `Mute` | Stummschalten |
| `Brightness Up` | Helligkeit erhöhen |
| `Brightness Down` | Helligkeit verringern |
| `Play/Pause` | Wiedergabe/Pause |
| `Next Track` | Nächster Titel |
| `Previous Track` | Vorheriger Titel |
| `Stop` | Titel stoppen |

### Screenshots und Aufnahme

| Tastenkürzel | Beschreibung |
| --- | --- |
| `Print` | Ausgewählten Bereich aufnehmen |
| `SUPER + Print` | Aktuelles Fenster aufnehmen |
| `SUPER + Shift + Print` | Gesamten Bildschirm aufnehmen |
| `SUPER + G` | Bildschirmaufnahme starten/pausieren/fortsetzen |
| `SUPER + Shift + G` | Bildschirmaufnahme stoppen und speichern |

### Sitzung

| Tastenkombination | Beschreibung |
| --- | --- |
| `SUPER + L` | System sperren |
| `SUPER + escape` | System beenden |
| `SUPER + Shift + R` | Hyprland neu laden |
| `SUPER + Shift + S` | Monitor aus-/einschalten (System nicht in Standby) |
| `SUPER + Shift + L` | Zeitüberschreitung für Inaktivitätssperre wählen |
| `SUPER + ALT + W` | Keep Awake umschalten |

### System

| Tastenkombination | Beschreibung |
| --- | --- |
| `SUPER + Shift + /` | Hyprland Spickzettel |
| `SUPER + CTRL + /` | Kitty Spickzettel |
| `SUPER + F1` | Über ARGVUS öffnen |
| `SUPER + ALT + C` | Systemsteuerung öffnen |
| `SUPER + P` | Farbpicker |
| `SUPER + .` | Emoji-Picker |
| `SUPER + H` | Zwischenablage-Verlauf |
| `SUPER + Shift + H` | Zwischenablage-Verlauf löschen |

### Widgets

| Shortcut | Beschreibung |
| --- | --- |
| `SUPER + ,` | Benachrichtigungsleiste öffnen/schließen |
| `Middle mouse button (mouse:274)` | Benachrichtigungsleiste öffnen/schließen |
| `SUPER + Backspace` | Waybar oben umschalten |
| `SUPER + Shift + W` | Wetterstandort konfigurieren |
| `SUPER + ALT + Up Arrow` | Taskleiste nach oben verschieben |
| `SUPER + ALT + Down Arrow` | Taskleiste nach unten verschieben |

### Erscheinungsbild

| Shortcut | Beschreibung |
| --- | --- |
| `SUPER + Y` | Control Center Hintergrundbilder öffnen |
| `SUPER + Shift + T` | Theme-Auswahl öffnen |
| `SUPER + Shift + M` | Sticky/Spaced-Modus-Auswahl öffnen |
| `SUPER + F5` | Zwischen den ARGVUS Dark- und ARGVUS Light-Themes umschalten |
| `SUPER + F6` | Animationen umschalten |
| `SUPER + Shift + B` | Helligkeitsauswahl und Nachtlicht-Umschalter öffnen |

### Größenänderungsmodus (nach SUPER + R)

Diese Shortcuts funktionieren nur, während der Größenänderungsmodus aktiv ist. `Esc` oder `Enter` verlassen den Modus.

| Tastenkürzel | Beschreibung |
| --- | --- |
| `Right Arrow` | Größe ändern |
| `Left Arrow` | Größe ändern |
| `Up Arrow` | Größe ändern |
| `Down Arrow` | Größe ändern |
| `Shift + Right Arrow` | Fenster verschieben |
| `Shift + Left Arrow` | Fenster verschieben |
| `Shift + Up Arrow` | Fenster verschieben |
| `Shift + Down Arrow` | Fenster verschieben |
| `escape` | Größenänderungsmodus beenden |
| `Enter` | Größenänderungsmodus beenden |

Siehe [Windows und Layout](/docs/argvus-hyprland/windows-and-layout/) für das Verhalten von schwebenden Fenstern und Arbeitsbereichen] und [Control Center](/docs/components/argvus-control-center/) für den Einstellungs-Workflow].

## Nachtlicht

**SUPER + Shift + B** hält die `appearance.brightness`-Aktion im kanonischen Tastenbelegungsmanifest. Sein Rofi-Helligkeitsmenü bietet auch Night Light an, wenn Hyprsunset verfügbar ist. Konfigurieren Sie die Temperatur (1000–20000 K) und die lokalen Start-/Endzeiten in **Control Center > Desktop & Eingabe > Displays > Night Light**. Die Schnellaktion verwendet die gemeinsam genutzte CLI und lädt Hyprland nicht neu, noch ändert sie generiertes Lua.  

Mit dem optionalen Paket argvus-ai installiert, öffnet SUPER + A das Menü der KI-Agenten. Die Tastenbelegung respektiert app.ai-Benutzerüberschreibungen und verschwindet nach der Deinstallation des Pakets und einem Neustart des Compositors. Bis zum Neustart ist die geschützte Aktion inaktiv.


Das optionale argvus-ai-Paket besitzt /usr/share/argvus/ai/hyprland.lua. Hyprland lädt es sicher, bevor Benutzerüberschreibungen erfolgen; das Entfernen des Moduls entfernt dessen Bindung beim Neuladen. Das Hyprland-Paket stellt einen Pacman-Hook bereit, der nach der Modulinstallation/-aktualisierung/-entfernung nur den Zeitstempel der Systemkonfiguration aktualisiert und so das native automatische Neuladen auslöst. Wenn das automatische Neuladen deaktiviert ist oder eine separate Benutzer-Root-Konfiguration verwendet wird, laden Sie diese Konfiguration explizit neu. Der Control Center-Katalog enthält app.ai mit denselben Standardtasten und lokalisiertem Label; die Bindung bleibt ohne das optionale Modul inaktiv.

## Pakete Terminal

Diese Tasten gelten innerhalb von **Control Center > System Administration > Packages**, und nicht global für Hyprland. `F8` öffnet das Transaktionsterminal erneut, `Esc` blendet es aus, ohne den Prozess zu stoppen, `Shift+PageUp/PageDown` scrollt die Historie, `Shift+End` kehrt zur Live-Ausgabe zurück und `Ctrl+C` unterbricht das fokussierte Kind. Das installierte Spickzettel enthält die gleichen Tasten.

In Packages fokussiert `/` die oberste **Suchleiste**. `Enter` führt dort Suchabfragen für Official/AUR-Installationen aus; Listen für Entfernen und Aktualisieren filtern während der Eingabe. `Down` bewegt sich zu den Ergebnissen, `Up` springt beim ersten Ergebnis zurück zur Suche, und `Esc` behält in der Suche die Abfrage und kehrt zur Liste zurück. Enter bei einem Ergebnis führt die Aktion des Pakets aus.
