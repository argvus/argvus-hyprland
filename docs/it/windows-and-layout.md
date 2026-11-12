---
title: Finestre e layout
description: Comprendere spazi, bordi, modalità e spazio dei pannelli in ARGVUS.
---
ARGVUS utilizza Hyprland per la gestione delle finestre a piastrelle e flottanti. I controlli di layout visibili all'utente si trovano in tre pagine del Centro di Controllo: **Centro di Controllo → Aspetto → Barra delle applicazioni** (posizione, spazi e icone), **Centro di Controllo → Desktop e Input → Hyprland → Finestre → Spazi** e **Centro di Controllo → Desktop e Input → Hyprland → Bordi**.

## I concetti

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```
- **Spazi tra le finestre** sono lo spazio tra le finestre a piastrelle e il bordo esterno del layout a piastrelle.
- **Spaziatura della barra delle applicazioni o della shell** è il margine attorno alle superfici del desktop come la barra delle applicazioni e il pannello. Non è lo stesso valore di uno spazio tra le finestre.
- **Bordi** sono il contorno visibile disegnato attorno a una finestra. **Spessore del bordo** controlla la larghezza del bordo resa visibile dalla pagina di aspetto.
- **Rounding** fa parte della modalità visiva selezionata. Cambia la forma degli angoli della finestra piuttosto che spostare la finestra.
- **Riserva del pannello e margine visibile** sono questioni separate: un pannello può occupare o usare visivamente lo spazio mentre Hyprland continua a disporre le finestre secondo lo stato di spaziatura attivo.

## Modalità Sticky e Spaced

Le modalità di tema incluse forniscono due geometrie iniziali:

| Modalità | Comportamento della finestra | Trattamento della superficie |
| --- | --- | --- |
| Sticky | Spazio interno `2`, spazio esterno `0` per default | Quadrato, compatto e vicino al bordo dello schermo |
| Spaced | Spazio interno `10`, spazio esterno `18` per default | Arrotondato, con ombra e più spazioso; margine della barra delle applicazioni/shell per default `18` |

Questi sono valori predefiniti, non limiti. Le pagine Spazi finestra e Spazi barra delle applicazioni possono memorizzare indipendentemente gli spazi delle finestre e i margini della barra delle applicazioni. Cambiare tema o modalità può proiettare valori di layout effettivi diversi.

## Controlli del layout

Ogni controllo è indipendente e si trova sulla pagina elencata qui:

- **Barra delle applicazioni → Posizione** — posizione della barra delle applicazioni, in alto o in basso.
- **Barra delle applicazioni → Spazi** — margini della barra delle applicazioni in alto, a sinistra, a destra e in basso, ciascuno da `0` a `100`. Sticky imposta il margine inferiore a `2`; Spaced usa `18`.
- **Barra delle applicazioni → Icone** — se il gruppo di utilità della barra delle applicazioni utilizza un comportamento automatico o sempre espanso.
- **Hyprland → Finestre → Spazi** — gap interno e gap esterni in alto/sinistra/destra/basso, ciascuno da `0` a `100`.
- **Hyprland → Bordi** — bordi generali: abilita angoli arrotondati; quando abilitato, l'arrotondamento è selezionabile da `2` a `10`. Qui si imposta anche lo spessore del bordo, da `0` a `10`.
- **Hyprland → Bordi → Ombra** — l'ombra della finestra, disattivata per impostazione predefinita. Imposta l'intervallo, la potenza di rendering, angoli netti, offset e scala, e il suo colore segue l'accento del tema con alfa `99` a meno che non venga digitato un colore.

Questi valori vengono scritti nello stato di aspetto di ARGVUS, e `argvus-config` li proietta nei file generati da Hyprland che poi la sessione applica. Un margine della barra delle applicazioni cambia la posizione della superficie della shell; un gap esterno della finestra cambia l'area delle finestre affiancate. Possono produrre una distanza visiva simile, ma cambiare uno non cambia l'altro.

## Finestre e spazi di lavoro

Le finestre affiancate sono organizzate da Hyprland nello spazio di lavoro attivo. ARGVUS supporta anche finestre utilitarie flottanti; `SUPER + SHIFT + Space` passa la finestra in focus tra i layout affiancato e flottante. Il movimento degli spazi di lavoro e il focus delle finestre sono controllati dal manifesto dei tasti attivo; vedere [Scorciatoie da tastiera](/docs/argvus-hyprland/keyboard-shortcuts/).

La configurazione preconfezionata apre il Centro di Controllo, Snake e Disk Usage Analyzer come finestre galleggianti e centrate. Disk Usage Analyzer utilizza la stessa geometria iniziale `1399 × 920` del popup della memoria della barra delle applicazioni, applicata dalla sua regola di classe finestra all'apertura della finestra. ARGVUS Focus e ARGVUS Clock sono popup GTK layer-shell ancorati accanto alla barra delle applicazioni, quindi non sono finestre a mosaico e non utilizzano le regole delle finestre di Hyprland. La scheda della sveglia dell'orologio è una superficie layer separata (`argvus-clock-alarm`).

Il Pannello di Controllo utilizza una superficie layer a schermo intero mentre il suo modale è aperto. Le regole preconfezionate fanno galleggiare, centrare e fissare le finestre dell'agente Polkit, del portale GTK e di KDialog, in modo che i dialoghi avviati dal pannello rimangano sopra il modale e possano ricevere input.

`hyprpicker`, aperto con `SUPER + P`, non utilizza le animazioni di Hyprland. Questa eccezione riguarda solo il selettore di colori; le altre animazioni continuano a seguire le impostazioni globali.

### Posizionamento dello spazio di lavoro per browser e IDE

Nessuna regola per le finestre è definita di default su un'installazione fresca. Puoi aggiungere le tue regole di posizionamento dello spazio di lavoro per applicazione sotto `hyprland.window_rules` in `argvus-config`, per esempio:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```
Ogni regola ha un `workspace` da 1 a 10 e una lista `classes`. Le voci in `classes` sono espressioni regolari confrontate con la classe della finestra (sensibile alle maiuscole), per esempio `[Cc]ode.*` o `jetbrains-.*`. Sono accettate solo lettere, cifre e `._*+?-[]()|^$`. `argvus-config` scrive le regole in `generated/hypr/window-rules.lua`, che la configurazione di Hyprland carica. Per sostituire le regole senza cambiare quelle predefinite, aggiungi chiamate `hl.window_rule` a `rules.lua` nella tua directory dati ARGVUS; queste vengono caricate dopo le regole generate.

## Cosa cambiare prima

- Se le finestre sembrano affollate, aumenta lo spazio tra le finestre o usa la modalità Spaced.
- Se le finestre sembrano troppo lontane dal bordo dello schermo, riduci lo spazio esterno/della barra delle applicazioni o usa la modalità Sticky.
- Se la barra delle applicazioni appare disallineata dopo aver cambiato la sua posizione, ricontrolla la posizione della barra delle applicazioni e tutti e quattro i margini della barra delle applicazioni/shell insieme.
- Se le finestre si sovrappongono a un pannello visivo, verifica le impostazioni del layout del pannello e della barra delle applicazioni prima di modificare gli spazi tra le finestre.

Le modifiche vengono applicate tramite l'integrazione aspetto/sessione di ARGVUS. Usa l'azione di reset della pagina dove disponibile; non modificare direttamente i file generati di Hyprland.

## Correlati

- [Aspetto](/docs/user-guide/appearance/)
- [Temi](/docs/user-guide/appearance/)
- [Barra delle applicazioni](/docs/argvus-taskbar/taskbar/)
- [Pannello di controllo](/docs/argvus-control-panel/)

## Oscillazione delle finestre

Apri **Desktop & Input → Hyprland → Animazioni → Finestre** e usa i controlli per
**Oscillazione (Wobble)**. Cerca `wobble`, oppure apri direttamente la pagina:

```sh
argvus control-center hyprland animations windows
```
Il Wobble è disabilitato di default. I suoi valori predefiniti ARGVUS sono: rigidità `100`, smorzamento `10`, massa `1`, intensità `1` e risoluzione della mesh `8`. Rigidità e massa accettano `0.0001–1000`, smorzamento `0–1000`, intensità `0–2` e la mesh un numero intero `2–32`. Una risoluzione della mesh più alta aumenta il costo del rendering. Usa i tasti freccia per regolare i valori o Invio per digitarli. **Ripristina i valori predefiniti di Wobble** cambia il progetto; **Applica** salva tutte le modifiche di animazione in sospeso e ricarica Hyprland una volta, senza riavviare la sessione. Tornando nelle Animazioni si mantiene il progetto condiviso.

L'interruttore globale Animations sopprime il Wobble mantenendo le sue impostazioni individuali. I valori canonici risiedono sotto `effects.wobble_*` nello stato ARGVUS; `hypr/state.lua` è generato e non deve essere modificato manualmente.

Questo richiede Hyprland **0.57.0 o più recente**, imposto dalla dipendenza del pacchetto di `argvus-hyprland`. La versione 0.56 non è supportata per questa configurazione. Il massimo di intensità segue il [codice sorgente rilasciato 0.57.0 ](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp), che lo limita a `2`, anche se la documentazione più recente può elencare `3`.

## Modalità finestra globale

Apri **Pannello di Controllo → Desktop e Input → Hyprland → Finestre → Modalità** e seleziona **Finestre a Piastrelle (Predefinito)** o **Finestre Fluttuanti**. Lo stesso selettore è disponibile dall'icona della modalità finestra nel gruppo di utilità della barra delle applicazioni.

La preferenza si applica a ogni monitor e spazio di lavoro e viene ricordata dopo il logout. Floating converte le finestre delle applicazioni esistenti e le finestre appena aperte. Tile ripristina solo le finestre che questa politica ha convertito; le finestre di dialogo e altre finestre già flottanti rimangono flottanti. Una finestra fissata esplicitamente mentre Floating è attivo rimane anch'essa flottante per preservare la sua fissazione. Il layout a piastrelle viene ricalcolato; il suo esatto albero di divisione precedente non viene ripristinato.

`SUPER + SHIFT + Space` mantiene il suo normale comportamento per finestra in Tile. In Floating non ripristina una finestra in modalità tiling. Pannelli, barra delle applicazioni e notifiche sono superfici layer-shell e non sono influenzati. Lo schermo intero continua a usare il normale comportamento di Hyprland; la massimizzazione ARGVUS preserva i margini in Spaced.

La preferenza canonica è `/hyprland/window_mode` in `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. La sua proiezione generata è `data/generated/hypr/window-mode.lua`; non modificarla. Il registro di ripristino per finestra risiede sotto `$XDG_RUNTIME_DIR/argvus`, limitato all'istanza del compositore, e sopravvive ai ricaricamenti della configurazione. Non viene riutilizzato in una nuova sessione.

Se l'applicazione è in sospeso o fallisce, l'interfaccia distingue questo dalla preferenza salvata. Seleziona di nuovo l'opzione per riprovare. Senza un compositore, la preferenza viene salvata per il prossimo accesso.

## Pulsanti delle finestre e barra dell'applicazione

La modalità mobile aggiunge una barra del titolo ARGVUS con **Riduci a icona**, **Ingrandisci / Ripristina** e **Chiudi** alle normali finestre dell'applicazione. Fare doppio clic sulla barra del titolo alterna la massimizzazione. La decorazione aggiuntiva è nascosta in Tile e a schermo intero. Le applicazioni che disegnano i propri controlli possono visualizzare entrambe le barre; i controlli ARGVUS uniformi sono intenzionali.

Una seconda Waybar appare su ogni monitor, sul bordo opposto alla barra delle applicazioni principale. Elenca solo le finestre del workspace corrente di quel monitor, includendo anche le finestre ridotte a icona. Le schede di gruppo nascoste non creano voci extra. Le voci ridotte a icona mantengono la loro associazione originale con monitor/workspace. Clicca su una finestra inattiva per attivarla, su una finestra attiva per ridurla a icona, o su una finestra ridotta a icona per ripristinarla; il suo menu contestuale offre ripristina, riduci a icona, ingrandisci/ripristina e chiudi. Le icone delle applicazioni sconosciute ricadono su un simbolo di finestra. Attivare o ripristinare una voce preserva la posizione del cursore. La barra secondaria utilizza il CSS primario effettivo (colori, font, bordo e arrotondamento), con la sua altezza e i margini speculari sul bordo opposto.

`SUPER + Alt + Up` posiziona la barra principale in alto e la barra della finestra in basso. `SUPER + Alt + Down` fa il contrario. Ripetere una direzione lascia le posizioni invariate. Tile ha solo la barra principale. Tornare a Tile ripristina tutte le finestre minimizzate prima di rimuovere la barra della finestra e poi conserva la politica originale a piastrelle/galleggiante.

La minimizzazione utilizza lo spazio di lavoro riservato `special:argvus-minimized`. Non utilizzare manualmente quello spazio di lavoro. Il processo `argvus windows service` registra l'identità, lo spazio di lavoro/monitor originale, la geometria, lo stato a schermo intero/massimizzazione e lo stato di pinning in un registro runtime specifico per istanza del compositore sotto `$XDG_RUNTIME_DIR/argvus`. I record sopravvivono a un riavvio del servizio o a un ricaricamento della configurazione, ma non attraversano le sessioni del compositore. La chiusura di una finestra rimuove il suo record. Se un monitor scompare, il ripristino utilizza un'uscita disponibile. Una barra di recupero mancante o guasta impedisce nuove minimizzazioni; un ripristino fallito mantiene il record e la barra di recupero.

La sessione possiede `argvus-windows.service` e `argvus-window-bar.service`. Quest'ultimo mantiene il suo figlio Waybar inattivo in Tile. Il plugin hyprbars è incluso da `argvus-hyprland`, costruito per l'ABI Hyprland 0.57.0 su x86_64; non è compilato nella directory home dell'utente. Ricompila il plugin con un aggiornamento dell'ABI del compositore.Comandi: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` e `minimize|restore|activate|maximize|close ADDRESS`. Gli indirizzi delle finestre provengono dalla lista. `position top --persist` memorizza/proietta la preferenza senza riavviare la barra principale. I dettagli degli errori di configurazione e runtime vengono scritti nel registro; i fallimenti delle azioni visibili mostrano anche una notifica tradotta.

In **Spaziato + Fluttuante**, le finestre rispettano i margini esterni e le aree riservate da entrambe le barre. I confini includono il bordo e il titolo, che si trova all'interno dello stesso bordo della finestra. La massimizzazione tramite ARGVUS controlla riempie quest'area con margini; il ripristino recupera la geometria precedente, anche dopo il riavvio di un servizio. Lo schermo intero utilizza comunque l'intero output. Le finestre fluttuanti possono sovrapporsi; gli spazi interni nella disposizione a piastrelle non le separano.

`SUPER + Alt + Space` attiva o disattiva la modalità Tile/Fluttuante globale, utilizzando la stessa preferenza della barra delle applicazioni e del Centro di Controllo. Il comando equivalente è `argvus config window-mode toggle`. Le invocazioni concorrenti vengono serializzate; l'attivazione utilizza la preferenza salvata anche quando l'applicazione è in attesa. La scorciatoia può essere cambiata o disabilitata nelle Scorciatoie da tastiera; `SUPER + Shift + Space` mantiene la sua azione a finestra singola.
