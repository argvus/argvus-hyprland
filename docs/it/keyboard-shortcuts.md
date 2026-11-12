---
title: Scorciatoie da tastiera
description: Trova le scorciatoie fornite dalla configurazione ARGVUS Hyprland.
---
Apri **Centro di Controllo → Desktop & Input → Scorciatoie da Tastiera**, oppure esegui `argvus control-center keybindings`.

## Cosa fa la pagina

**Tutte le Scorciatoie** cerca e raggruppa il manifesto dei tasti attivi. Puoi selezionare un collegamento, modificare la sua combinazione di tasti, acquisire una nuova combinazione, abilitare o disabilitare un collegamento configurabile e ripristinare tutte le scorciatoie dall'azione di ripristino della pagina. Una scorciatoia deve contenere un tasto non modificatore; l'editor normalizza nomi come Super/Win, Ctrl, Alt, Shift, frecce, tasti funzione e tasti multimediali. `SUPER + Y` apre **Centro di Controllo → Aspetto → Sfondi**.

Le modifiche ufficiali alle scorciatoie sono memorizzate in `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`, rappresentate da `/keyboard_shortcuts` nel modello logico; il frammento generato di Hyprland viene scritto sotto `~/.config/argvus/data/generated/hypr/`. Una scorciatoia disabilitata è rappresentata da `null`. I tasti sono chiavi di configurazione inglesi stabili, indipendenti dalla lingua selezionata: un ID del manifesto come `window.close` mappa su `close_window`, mentre `window.drag_mouse` mappa su `drag_window__floating_window_only`. La vecchia sezione `/hyprland/keybindings` e `keybindings.toml` sono solo per la migrazione. ARGVUS programma un ricaricamento della sessione solo quando il piano di proiezione segnala un cambiamento reale.

**Crea Scorciatoie** crea una scorciatoia da tastiera globale indipendentemente dal manifest pacchettizzato. Fornisci una descrizione, i tasti e un comando oppure un dispatcher Lua supportato (ad esempio `window.float` con argomenti JSON `{"action":"toggle"}`). **Crea** salva e applica la scorciatoia, quindi la seleziona in **Tutte le Scorciatoie → Scorciatoie Personalizzate**. Annulla o `Esc` scarta la bozza. La creazione e la cattura non eseguono il comando.

Le scorciatoie personalizzate possono essere modificate, abilitate/disabilitate e cancellate previa conferma. I conflitti con le scorciatoie abilitate nello stesso contesto richiedono conferma di sostituzione; le combinazioni protette non possono essere sostituite. Il ripristino dei valori predefiniti ufficiali conserva i record personalizzati. Se il ripristino dovesse entrare in conflitto con una scorciatoia personalizzata attiva, modificare o disabilitare prima quella scorciatoia personalizzata. Le definizioni personalizzate sono memorizzate sotto `/hyprland/custom_shortcuts` in `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. Lo `data/generated/hypr/custom-shortcuts.lua` generato viene caricato con il loader protetto esistente; le registrazioni invalide vengono registrate senza interrompere il resto della configurazione. I fallimenti nel salvataggio preservano la bozza; i fallimenti dell'applicazione segnalano che il record è stato salvato e può essere riprovato.

Esegui `argvus control-center shortcuts create` o `argvus control-center shortcuts list` per aprire una delle due pagine. Per submappe avanzate, associazioni dei tasti del mouse o flag, [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) rimane disponibile. Non modificare mai i frammenti generati.

## Riferimento attuale

Il manifesto di base e le cheatsheet installate si trovano sotto `/usr/share/argvus/hyprland/`. La sovrascrittura utente attiva non è un manifesto sostitutivo: modifica le voci selezionate nel Centro di Controllo. Ecco perché un elenco specifico per versione, copiato manualmente, può diventare obsoleto.

Alcune azioni integrate utili includono lo spostamento del focus e degli spazi di lavoro, l'attivazione/disattivazione delle finestre flottanti, screenshot e registrazione, apertura del launcher/terminale, cambiamento dell'aspetto, blocco della sessione, controllo dei media e ricaricamento di Hyprland. I collegamenti predefiniti sono elencati nella [tabella dei collegamenti predefiniti](#default-shortcut-table) qui sotto; la pagina del Centro di Controllo mostra i collegamenti così come sono attualmente configurati.

`SUPER + Shift + R` è il ricaricamento esplicito a runtime: ricarica Hyprland e riavvia la barra delle applicazioni ARGVUS, il Pannello di Controllo e i servizi di Widget Telemetry. I ricaricamenti guidati dalla configurazione rimangono condizionali e saltano il ricaricamento grafico quando lo stato canonico non è cambiato.

## Tabella dei collegamenti predefiniti

La tabella elenca i collegamenti del manifesto base (`/usr/share/argvus/hyprland/keybindings.json`) con i loro tasti predefiniti. Le tue modifiche nel Centro di Controllo sostituiscono i tasti mostrati qui per i collegamenti interessati, e i collegamenti disabilitati non vengono eseguiti.### Navigazione

| Scorciatoia | Descrizione |
| --- | --- |
| `SUPER + Left Arrow` | Focalizza la finestra affiancata per direzione |
| `SUPER + Right Arrow` | Focalizza la finestra affiancata per direzione |
| `SUPER + Up Arrow` | Focalizza la finestra affiancata per direzione |
| `SUPER + Down Arrow` | Focalizza la finestra affiancata per direzione |
| `SUPER + CTRL + Left Arrow` | Cicla il focus tra le finestre (affiancate e fluttuanti) |
| `SUPER + CTRL + Right Arrow` | Cicla il focus tra le finestre (affiancate e fluttuanti) |

### Spazi di lavoro

| Scorciatoia | Descrizione |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Spostamento tra le aree di lavoro |
| `CTRL + ALT + Left Arrow` | Spostamento tra le aree di lavoro |
| `Mouse extra button (mouse:276)` | Spostamento tra le aree di lavoro |
| `Mouse side button (mouse:275)` | Spostamento tra le aree di lavoro |
| `SUPER + 1` | Spazio di lavoro 1 |
| `SUPER + 2` | Spazio di lavoro 2 |
| `SUPER + 3` | Spazio di lavoro 3 |
| `SUPER + 4` | Spazio di lavoro 4 |
| `SUPER + 5` | Spazio di lavoro 5 |
| `SUPER + 6` | Spazio di lavoro 6 |
| `SUPER + 7` | Spazio di lavoro 7 |
| `SUPER + 8` | Spazio di lavoro 8 |
| `SUPER + 9` | Spazio di lavoro 9 |
| `SUPER + CTRL + 1` a `SUPER + CTRL + 9` | Apre il progetto in quella posizione di `argvus projects` |
| `SUPER + Shift + 1` | Sposta la finestra sul desktop 1 |
| `SUPER + Shift + 2` | Sposta la finestra sul desktop 2 |
| `SUPER + Shift + 3` | Sposta la finestra sul desktop 3 |
| `SUPER + Shift + 4` | Sposta la finestra sul desktop 4 |
| `SUPER + Shift + 5` | Sposta la finestra sul desktop 5 |
| `SUPER + Shift + 6` | Sposta la finestra sul desktop 6 |
| `SUPER + Shift + 7` | Sposta la finestra sul desktop 7 |
| `SUPER + Shift + 8` | Sposta la finestra sul desktop 8 |
| `SUPER + Shift + 9` | Sposta la finestra sul desktop 9 |

### Finestre

| Scorciatoia | Descrizione |
| --- | --- |
| `SUPER + S` | Ingrandisci finestra (alternanza) |
| `SUPER + Q` | Chiudi finestra |
| `SUPER + Shift + Space` | Abilita/Disabilita finestra flottante |
| `SUPER + F` | Finestra a schermo intero |
| `SUPER + E` | Alterna divisione verticale/orizzontale |
| `SUPER + W` | Raggruppa/Sciogli in schede |
| `SUPER + Tab` | Naviga tra le schede |
| `SUPER + Shift + Left Arrow` | Sposta finestra |
| `SUPER + Shift + Right Arrow` | Sposta finestra |
| `SUPER + Shift + Up Arrow` | Sposta finestra |
| `SUPER + Shift + Down Arrow` | Sposta finestra |
| `SUPER + Left mouse button (mouse:272)` | Trascina finestra (solo finestra flottante) |
| `SUPER + Right mouse button (mouse:273)` | Modalità ridimensionamento finestra (solo finestra flottante) |
| `SUPER + R` | Entra in modalità ridimensionamento finestra (solo finestra flottante) |

### Applicazioni

| Scorciatoia | Descrizione |
| --- | --- |
| `SUPER + Enter` | Terminale |
| `SUPER + [` | Blocco note del terminale (menu a discesa in un workspace speciale; premi di nuovo per nascondere) |
| `SUPER + Space` | Gestore file |
| `SUPER + CTRL + Space` | Monitor di sistema |
| `SUPER + Shift + D` | Menu dispositivi rimovibili |
| `SUPER + Shift + F` | ARGVUS Focus (sessioni Pomodoro e di concentrazione) |
| `SUPER + Shift + C` | ARGVUS Orologio (orologio, timer e sveglie) |
| `SUPER + D` | Avviatore di programmi |
| `SUPER + B` | Browser predefinito |
| `SUPER + C` | Calcolatrice |
| `SUPER + ALT + S` | Selettore host SSH (`argvus ssh`) |
| `SUPER + ALT + N` | Selettore snippet (`argvus snippets`) |
| `SUPER + ALT + G` | Selettore progetto, poi interfaccia git TUI (lazygit o gitui) nel progetto scelto (`argvus git`) |

### Media

| Scorciatoia | Descrizione |
| --- | --- |
| `XF86AudioRaiseVolume` | Alza volume |
| `Volume Down` | Abbassa volume |
| `Mute` | Muto |
| `Brightness Up` | Aumenta luminosità |
| `Brightness Down` | Diminuisci luminosità |
| `Play/Pause` | Riproduci/Pausa |
| `Next Track` | Traccia successiva |
| `Previous Track` | Traccia precedente |
| `Stop` | Ferma traccia |

### Screenshot e registrazione

| Scorciatoia | Descrizione |
| --- | --- |
| `Print` | Cattura area selezionata |
| `SUPER + Print` | Cattura finestra attiva |
| `SUPER + Shift + Print` | Cattura schermo intero |
| `SUPER + G` | Avvia/Pausa/Riprendi registrazione schermo |
| `SUPER + Shift + G` | Ferma e salva registrazione schermo |

### Sessione

| Scorciatoia | Descrizione |
| --- | --- |
| `SUPER + L` | Blocca sistema |
| `SUPER + escape` | Esci dal sistema |
| `SUPER + Shift + R` | Ricarica Hyprland |
| `SUPER + Shift + S` | Spegni/accendi monitor (non sospendere il sistema) |
| `SUPER + Shift + L` | Scegli timeout per blocco inattività |
| `SUPER + ALT + W` | Attiva/disattiva Mantieni Attivo |

### Sistema

| Scorciatoia | Descrizione |
| --- | --- |
| `SUPER + Shift + /` | Cheat sheet di Hyprland |
| `SUPER + CTRL + /` | Cheat sheet di Kitty |
| `SUPER + F1` | Apri Informazioni su ARGVUS |
| `SUPER + ALT + C` | Apri Centro di Controllo |
| `SUPER + P` | Selettore di Colori |
| `SUPER + .` | Selettore di Emoji |
| `SUPER + H` | Cronologia Appunti |
| `SUPER + Shift + H` | Cancella Cronologia Appunti |

### Widget

| Scorciatoia | Descrizione |
| --- | --- |
| `SUPER + ,` | Apri/Chiudi la barra laterale delle notifiche |
| `Middle mouse button (mouse:274)` | Apri/Chiudi la barra laterale delle notifiche |
| `SUPER + Backspace` | Attiva/disattiva Waybar sopra |
| `SUPER + Shift + W` | Configura la posizione del meteo |
| `SUPER + ALT + Up Arrow` | Sposta la barra delle applicazioni in alto |
| `SUPER + ALT + Down Arrow` | Sposta la barra delle applicazioni in basso |

### Aspetto

| Scorciatoia | Descrizione |
| --- | --- |
| `SUPER + Y` | Apri i wallpaper del Centro di Controllo |
| `SUPER + Shift + T` | Apri il selettore di temi |
| `SUPER + Shift + M` | Apri il selettore modalità Sticky/Spaced |
| `SUPER + F5` | Passa tra i temi ARGVUS Dark e ARGVUS Light |
| `SUPER + F6` | Attiva/disattiva le animazioni |
| `SUPER + Shift + B` | Apri il selettore di luminosità e l'attivazione della Luce Notturna |

### Modalità ridimensionamento (dopo SUPER + R)

Queste scorciatoie funzionano solo mentre la modalità di ridimensionamento è attiva. `Esc` o `Enter` esce dalla modalità.

| Scorciatoia | Descrizione |
| --- | --- |
| `Right Arrow` | Ridimensiona |
| `Left Arrow` | Ridimensiona |
| `Up Arrow` | Ridimensiona |
| `Down Arrow` | Ridimensiona |
| `Shift + Right Arrow` | Sposta finestra |
| `Shift + Left Arrow` | Sposta finestra |
| `Shift + Up Arrow` | Sposta finestra |
| `Shift + Down Arrow` | Sposta finestra |
| `escape` | Esci dalla modalità ridimensionamento |
| `Enter` | Esci dalla modalità ridimensionamento |


Vedi [Finestre e layout](/docs/argvus-hyprland/windows-and-layout/) per il comportamento flottante e della scrivania e [Centro di Controllo](/docs/components/argvus-control-center/) per il flusso delle impostazioni.

## Luce notturna

**SUPER + Shift + B** mantiene l'azione `appearance.brightness` nel manifesto delle associazioni di tasti canoniche. Il suo menu di luminosità Rofi offre anche Night Light quando Hyprsunset è disponibile. Configura la temperatura (1000–20000 K) e gli orari locali di inizio/fine in **Centro di Controllo > Desktop e Input > Schermi > Night Light**. L'azione rapida utilizza il CLI condiviso e non ricarica Hyprland né cambia il Lua generato.

Con il pacchetto opzionale argvus-ai installato, SUPER + A apre il menu degli agenti AI. L'associazione rispetta le sovrascritture degli utenti di app.ai e scompare dopo la rimozione del pacchetto e il ricaricamento del compositore. Fino al ricaricamento, l'azione protetta è inattiva.


Il pacchetto opzionale argvus-ai possiede /usr/share/argvus/ai/hyprland.lua. Hyprland lo carica in sicurezza prima delle modifiche dell'utente; rimuovendo il modulo si rimuove il suo bind al momento del ricaricamento. Il pacchetto Hyprland fornisce un hook di Pacman che tocca solo il timestamp della configurazione di sistema dopo l'installazione/aggiornamento/rimozione del modulo, attivando l'autoricarica nativa. Se l'autoricarica è disabilitata o viene utilizzata una configurazione root utente separata, ricaricare esplicitamente quella configurazione. Il catalogo del Centro di Controllo include app.ai con le stesse chiavi predefinite e etichetta localizzata; il binding rimane inattivo senza il modulo opzionale.

## Pacchetti terminale

Questi tasti si applicano all'interno di **Centro di Controllo > Amministrazione di Sistema > Pacchetti**, piuttosto che a Hyprland in generale. `F8` riapre il terminale di transazione, `Esc` lo nasconde senza interrompere il processo, `Shift+PageUp/PageDown` scorre la cronologia, `Shift+End` ritorna all'output in tempo reale e `Ctrl+C` interrompe il processo figlio focalizzato. Il foglio di riferimento installato include gli stessi tasti.

Nei Pacchetti, `/` mette a fuoco la barra di **Ricerca** in alto. `Enter` lì invia ricerche di installazione Official/AUR; le liste di rimozione e aggiornamento si filtrano mentre si digita. `Down` si sposta ai risultati, `Up` sul primo risultato ritorna alla Ricerca, e `Esc` nella Ricerca preserva la query e ritorna alla lista. Premi Invio su un risultato per eseguire l'azione del pacchetto.
