---
title: Hyprland überschreibt
description: Passen Sie die ARGVUS Hyprland-Konfiguration an, ohne gepackte Dateien zu bearbeiten.
---
ARGVUS unterstützt zwei verschiedene Möglichkeiten, Hyprland anzupassen. Sie dürfen nicht verwechselt werden:

- `~/.config/hypr/hyprland.lua` ist eine vollständige Benutzerkonfiguration. Wenn sie gültig ist und nicht die Standard-Hyprland-Vorlage ist, startet `argvus start` Hyprland mit dieser Datei anstelle der mitgelieferten Konfiguration.
- `~/.config/argvus/data/hypr/` enthält inkrementelle ARGVUS-Überschreibungen. Die mitgelieferte Konfiguration bleibt die Basis und lädt diese Fragmente am Ende.

Für die meisten Anpassungen sollten die inkrementellen ARGVUS-Überschreibungen verwendet werden. Sie behalten die ARGVUS-Standardeinstellungen, den generierten Zustand und die Sitzungsintegration auch nach Paket-Updates bei.

## Unterstützte Überschreibungsdateien

Erstellen Sie das Verzeichnis, bevor Sie ein Fragment hinzufügen:

```sh
mkdir -p ~/.config/argvus/data/hypr
```
Die gepackte Konfiguration lädt diese Dateien in dieser Reihenfolge, wenn sie vorhanden sind:

```text
~/.config/argvus/data/hypr/monitors.lua
~/.config/argvus/data/hypr/rules.lua
~/.config/argvus/data/hypr/bindings.lua
~/.config/argvus/data/hypr/user.lua
```
Verwenden Sie die Dateien nach Verantwortungsbereich:

- `monitors.lua` — zusätzliche oder Ersatz-Monitor-Deklarationen.
- `rules.lua` — Fenster- und Layer-Regeln.
- `bindings.lua` — zusätzliche Tastenkombinationen oder benutzerdefinierte Aktionen.
- `user.lua` — Umgebungsvariablen und andere Lua-Konfigurationen, die nicht in die vorherigen Kategorien passen.

Ein Fragment mit einem Lua-Fehler stoppt die restliche Konfiguration nicht. Hyprland überspringt diese Datei, meldet `ARGVUS: ignoring invalid user override` mit ihrem Pfad und dem Fehler und lädt trotzdem die verbleibenden Fragmente. Überprüfen Sie ein Fragment mit `luac -p`, bevor Sie neu laden.

Bearbeiten Sie `/usr/share/argvus/hyprland/config/hyprland.lua` nicht. Es wird vom Paket verwaltet und kann durch ein Update ersetzt werden.

## Umgebungsüberschreibungen

Verwenden Sie `user.lua` für Sitzungs-Umgebungswerte:

```lua
-- ~/.config/argvus/data/hypr/user.lua
hl.env("MY_VARIABLE", "1")
```
Änderungen der Umgebung wirken sich auf Anwendungen aus, die von der Sitzung gestartet wurden. Melden Sie sich ab und wieder an, wenn der Wert von der gesamten Sitzung übernommen werden muss; ein reines Neuladen des Compositors reicht für bereits gestartete Anwendungen nicht aus.

ARGVUS besitzt `XDG_CONFIG_DIRS` und baut es bei jedem Hyprland-Neuladen erneut auf, einschließlich Neuladungen, die durch Themenwechsel ausgelöst werden. Jedes ARGVUS-Konfigurationsverzeichnis erscheint einmal, und Einträge, die von der Sitzung übernommen werden, bleiben nach ihnen ohne Wiederholung erhalten, sodass der Wert begrenzt bleibt. Sitzungen, die von früheren Versionen gestartet wurden, könnten weiterhin die doppelten Einträge enthalten; wenn Kitty, `argvus terminal` oder `argvus --control-center` mit `Out of buffer space calling sprintf` fehlschlagen, melden Sie sich ab und wieder an, um mit einer sauberen Umgebung zu starten.

## Hinzufügen einer Tastenkombination

Verwenden Sie `bindings.lua` für eine neue Bindung, die nicht Teil des ARGVUS-Tastenkombinationsmanifests ist:

```lua
-- ~/.config/argvus/data/hypr/bindings.lua
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty"))
```
Verwenden Sie die ARGVUS Lua Dispatcher-Hilfen für Kompositoraktionen:

```lua
-- Focus the next window with a custom shortcut.
hl.bind("SUPER + CTRL + Tab", hl.dsp.group.next())
```
Die Bindung wird zusammen mit der gepackten Konfiguration ausgewertet. Überprüfen Sie auf Konflikte mit vorhandenen Tastenkombinationen, bevor Sie eine Kombination wählen. Bewahren Sie die entsprechenden Optionen beim Definieren spezieller Bindungen, zum Beispiel:

```lua
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)
```
Das Kontrollzentrum ist der bevorzugte Weg, um eine bestehende ARGVUS-Verknüpfung zu ändern oder zu deaktivieren:

```sh
argvus control-center keybindings
```
Diese Änderungen werden kanonisch unter `/keyboard_shortcuts` gespeichert und in `~/.config/argvus/data/generated/hypr/keybindings.lua` materialisiert. Eine manuell erstellte Bindung in `bindings.lua` wird nicht zum Control Center-Manifest hinzugefügt und wird nicht durch dessen Wiederherstellungsaktion verwaltet.

## Vollständige native Hyprland-Konfiguration

`~/.config/hypr/hyprland.lua` ist keine Overlay-Datei. Wenn Sie sie erstellen, validiert `argvus start` sie und verwendet sie als die vollständige Hyprland-Konfiguration:

```sh
mkdir -p ~/.config/hypr
cp /usr/share/argvus/hyprland/config/hyprland.lua ~/.config/hypr/hyprland.lua
```
Dieser Ansatz gibt volle Kontrolle, aber die kopierte Datei wird zu Ihrer Verantwortung. Sie kann veraltet werden, wenn sich ARGVUS ändert, und eine benutzerdefinierte Datei, die den ARGVUS-Loader oder die Handhabung des generierten Zustands weglässt, kann die ARGVUS-Integration verlieren. Bevorzugen Sie die oben genannten Fragmentdateien, es sei denn, Sie benötigen absichtlich einen vollständigen Ersatz.

Die Standard-Hyprland-Datei, die `AUTOGENERATED HYPRLAND CONFIG` enthält, wird von `argvus start` ignoriert, sodass ihre Anwesenheit die ARGVUS-Konfiguration nicht ersetzt. Eine angepasste Benutzerdatei wird erst nach der Validierung ausgewählt; schlägt die Validierung fehl, greift der Launcher auf die ausgelieferte Datei zurück.

## Anwenden und Fehler beheben

Nach der Änderung eines Lua-Fragments die Sitzungs-Konfiguration neu laden:

```sh
argvus sessionctl reload
```
Überprüfen Sie eine vollständige Lua-Datei, bevor Sie sich erneut anmelden:

```sh
luac -p ~/.config/hypr/hyprland.lua
Hyprland --verify-config --config ~/.config/hypr/hyprland.lua
```
Wenn die Benutzerkonfiguration beim Start abgelehnt wird, überprüfen Sie:

```sh
grep -E "Hyprland Lua config|failed validation|using user Lua|fallback" \
  ~/.local/state/argvus/session.log
```
Die gepackten Quellen und Hilfsdateien befinden sich unter `/usr/share/argvus/hyprland/`. Generierte Dateien unter `~/.config/argvus/data/generated/` sind abgeleiteter Zustand; bearbeiten Sie stattdessen die zugehörige Einstellung oder den Überschreibungsfragment, statt die generierten Ausgaben direkt zu ändern.

Siehe [Tastenkombinationen](/docs/argvus-hyprland/keyboard-shortcuts/) für den Control Center-Workflow und [Dateispeicherorte](/docs/reference/file-locations/) für das vollständige Referenzpfadkonfigurationsverzeichnis.

Die Leistung der Schattenwiedergabe wird vor dem Aufruf von Hyprland auf 1–4 (Standard 4) begrenzt, einschließlich Projektionen von Legacy-Effekten. Dies verhindert, dass von älteren ARGVUS-Versionen akzeptierte Werte den Start von Hyprland 0.57 blockieren.
