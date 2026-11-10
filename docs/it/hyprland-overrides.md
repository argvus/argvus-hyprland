---
title: Sovrascritture di Hyprland
description: Personalizza la configurazione di ARGVUS Hyprland senza modificare i file confezionati.
---
ARGVUS supporta due modi diversi per personalizzare Hyprland. Non devono essere confusi:

- `~/.config/hypr/hyprland.lua` è una configurazione utente completa. Quando è valida e non è il modello stock di Hyprland, `argvus start` avvia Hyprland con questo file invece della configurazione inclusa.
- `~/.config/argvus/data/hypr/` contiene sovrascritture incrementali di ARGVUS. La configurazione inclusa rimane la base e carica questi frammenti alla fine.

Per la maggior parte delle personalizzazioni, utilizza le sovrascritture incrementali di ARGVUS. Esse mantengono disponibili i valori predefiniti di ARGVUS, lo stato generato e l'integrazione della sessione attraverso gli aggiornamenti del pacchetto.

## File di sovrascrittura supportati

Crea la directory prima di aggiungere un frammento:

```sh
mkdir -p ~/.config/argvus/data/hypr
```
La configurazione pacchettizzata carica questi file in quest'ordine quando esistono:

```text
~/.config/argvus/data/hypr/monitors.lua
~/.config/argvus/data/hypr/rules.lua
~/.config/argvus/data/hypr/bindings.lua
~/.config/argvus/data/hypr/user.lua
```
Usa i file per responsabilità:

- `monitors.lua` — dichiarazioni aggiuntive o di sostituzione del monitor.
- `rules.lua` — regole di finestra e layer.
- `bindings.lua` — combinazioni di tasti aggiuntive o azioni personalizzate.
- `user.lua` — variabili d'ambiente e altre configurazioni Lua che non rientrano nelle categorie precedenti.

Un frammento con un errore Lua non interrompe il resto della configurazione. Hyprland salta quel file, segnala `ARGVUS: ignoring invalid user override` con il suo percorso e l'errore, e carica comunque i frammenti rimanenti. Controlla un frammento con `luac -p` prima di ricaricare.

Non modificare `/usr/share/argvus/hyprland/config/hyprland.lua`. È di proprietà del pacchetto e può essere sostituito da un aggiornamento.

## Sovrascritture dell'ambiente

Usa `user.lua` per i valori dell'ambiente della sessione:

```lua
-- ~/.config/argvus/data/hypr/user.lua
hl.env("MY_VARIABLE", "1")
```
I cambiamenti dell'ambiente influenzano le applicazioni avviate dalla sessione. Effettua il logout e il login di nuovo quando il valore deve essere ereditato dall'intera sessione; un semplice reload del compositor non è sufficiente per le applicazioni già avviate.

ARGVUS possiede `XDG_CONFIG_DIRS` e lo ricostruisce ad ogni reload di Hyprland, inclusi i reload causati dai cambiamenti di tema. Ogni directory di configurazione di ARGVUS appare una sola volta, e le voci ereditate dalla sessione vengono mantenute dopo di essa senza ripetizioni, quindi il valore rimane limitato. Le sessioni avviate da versioni precedenti possono ancora avere voci duplicate; se Kitty, `argvus terminal` o `argvus --control-center` falliscono con `Out of buffer space calling sprintf`, effettua il logout e il login di nuovo per iniziare con un ambiente pulito.

## Aggiungere un collegamento da tastiera

Usa `bindings.lua` per un nuovo collegamento che non fa parte del manifesto dei collegamenti da tastiera di ARGVUS:

```lua
-- ~/.config/argvus/data/hypr/bindings.lua
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty"))
```
Usa gli helper dispatcher Lua di ARGVUS per le azioni del compositore:

```lua
-- Focus the next window with a custom shortcut.
hl.bind("SUPER + CTRL + Tab", hl.dsp.group.next())
```
La combinazione viene valutata insieme alla configurazione pacchettizzata. Controlla la presenza di conflitti con le scorciatoie esistenti prima di scegliere una combinazione. Conserva le opzioni appropriate quando definisci combinazioni speciali, per esempio:

```lua
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)
```
Il Centro di Controllo è il modo preferito per modificare o disabilitare un collegamento ARGVUS esistente:

```sh
argvus control-center keybindings
```
Quelle modifiche sono archiviate in modo canonico sotto `/keyboard_shortcuts` e materializzate in `~/.config/argvus/data/generated/hypr/keybindings.lua`. Un binding creato manualmente in `bindings.lua` non viene aggiunto al manifesto del Control Center e non è gestito dalla sua azione di ripristino.

## Configurazione completa nativa di Hyprland

`~/.config/hypr/hyprland.lua` non è un file overlay. Se lo crei, `argvus start` lo verifica e lo utilizza come configurazione completa di Hyprland:

```sh
mkdir -p ~/.config/hypr
cp /usr/share/argvus/hyprland/config/hyprland.lua ~/.config/hypr/hyprland.lua
```
Questo approccio offre il controllo completo, ma il file copiato diventa tua responsabilità. Può diventare obsoleto man mano che ARGVUS cambia, e un file personalizzato che omette il loader ARGVUS o la gestione dello stato generato può perdere l'integrazione con ARGVUS. Preferisci i file frammento sopra indicati a meno che tu non abbia intenzionalmente bisogno di una sostituzione completa.

Il file Hyprland di default contenente `AUTOGENERATED HYPRLAND CONFIG` è ignorato da `argvus start`, quindi la sua presenza non sostituisce la configurazione ARGVUS. Un file utente personalizzato viene selezionato solo dopo la validazione; se la validazione fallisce, il launcher ricade sul file incluso nel pacchetto.

## Applicare e risolvere i problemi

Dopo aver modificato un frammento Lua, ricarica la configurazione della sessione:

```sh
argvus sessionctl reload
```
Valida un file Lua completo prima di accedere di nuovo:

```sh
luac -p ~/.config/hypr/hyprland.lua
Hyprland --verify-config --config ~/.config/hypr/hyprland.lua
```
Se la configurazione dell'utente viene rifiutata durante l'avvio, ispezionare:

```sh
grep -E "Hyprland Lua config|failed validation|using user Lua|fallback" \
  ~/.local/state/argvus/session.log
```
Le sorgenti e gli helper confezionati si trovano sotto `/usr/share/argvus/hyprland/`. I file generati sotto `~/.config/argvus/data/generated/` sono stati derivati; modifica l'impostazione proprietaria o il frammento di override invece di modificare direttamente l'output generato.

Vedi [Scorciatoie da tastiera](/docs/argvus-hyprland/keyboard-shortcuts/) per il flusso di lavoro del Centro di Controllo e [posizioni dei file](/docs/reference/file-locations/) per il riferimento completo del percorso di configurazione.

La potenza di rendering delle ombre è limitata a 1–4 (default 4) prima di chiamare Hyprland, comprese le proiezioni di effetti legacy. Questo previene che valori accettati dalle release più vecchie di ARGVUS blocchino l'avvio su Hyprland 0.57.
