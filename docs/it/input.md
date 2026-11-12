---
title: Mouse e touchpad
description: Configura il comportamento del puntatore e del touchpad in ARGVUS.
---
Apri **Centro di Controllo → Locale e Regione → Mouse e Touchpad**, oppure esegui `argvus control-center input`.

## Topo

Quando viene rilevato un mouse, la pagina mostra:

- sensibilità da `-1.0` a `1.0`;
- profilo di accelerazione adattivo o fisso;
- fattore di scorrimento da `0.1` a `10.0`;
- scorrimento naturale;
- disposizione dei pulsanti per mancini.

Sensibilità, fattore di scorrimento e i toggle si applicano tramite Hyprland mentre la pagina è aperta, poi lo stato completo dell’input viene salvato. La pagina legge il valore attuale del compositore quando non esiste un file di input ARGVUS.

## Touchpad

Quando viene rilevato un touchpad, la pagina mostra scorrimento naturale, tocca per cliccare, tocca e trascina, clic con due dita e disattiva durante la digitazione. Queste opzioni sono mostrate come controlli utili solo quando la sessione in corso segnala un touchpad.

## Controlli dipendenti dall’hardware

I comandi avanzati del mouse supportati da `ratbag` sono mostrati solo per i dispositivi compatibili. ARGVUS non garantisce che ogni mouse supporti DPI, profili o modifiche di polling. Se un dispositivo non viene rilevato o il servizio opzionale del dispositivo non è disponibile, tali comandi non possono essere applicati da questa pagina.

## Persistenza e reset

Le impostazioni vengono memorizzate come stato utente e un frammento di input Hyprland generato viene rigenerato per la sessione. Utilizzare l'azione di reset della pagina quando presente; non modificare direttamente il frammento generato. Una impostazione può applicarsi solo al compositor attuale quando la sessione non può ricaricare lo stato del dispositivo rilevante.

Vedere [Centro di Controllo](/docs/components/argvus-control-center/) e [Dove configurare le cose](/docs/user-guide/where-to-configure/).
