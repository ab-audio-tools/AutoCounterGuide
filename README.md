# REAPER Counter Guide Script 🎚️⏱️

Uno script Lua per REAPER che genera automaticamente una traccia di guida con conteggi vocali e annunci di sezione, perfetto per sessioni di registrazione dal vivo, produzione musicale e post-produzione audio.

![Esempio di traccia COUNTER GUIDE in REAPER](https://via.placeholder.com/800x400.png?text=COUNTER+GUIDE+Track+Example) 
*(Sostituisci con un'immagine reale del tuo script in azione)*

## 🌟 Funzionalità principali

- **Creazione automatica** della traccia "COUNTER GUIDE" (o riutilizzo se esiste)
- **Analisi intelligente** delle regioni nella time selection
- **Sistema di conteggio avanzato**:
  - Annuncio della prossima sezione al 4° battito prima della fine
  - Conteggio "two, three, four" nei 3 battiti successivi
- **Pre-count speciale** (6 battiti) quando la prossima sezione è "Intro"
- **Pulizia automatica** degli item esistenti nella time selection
- **Console di debug** con informazioni dettagliate sull'esecuzione

## 🛠️ Requisiti tecnici

- REAPER versione 6.x o 7.x
- Permessi di scrittura nella cartella degli script di REAPER
- File audio dei conteggi in formato WAV (16/24-bit, 44.1/48kHz consigliati)

## 📥 Installazione passo-passo

1. **Scarica lo script**:
   - [Clicca qui per scaricare counter_guide.lua](https://example.com/download) *(sostituisci con link reale)*
   - Oppure copia il codice sorgente in un file con estensione `.lua`

2. **Posiziona lo script**:
    - Windows: C:\Users[Tuonome]\AppData\Roaming\REAPER\Scripts
    - MacOS: ~/Library/Application Support/REAPER/Scripts/
    - Linux: ~/.config/REAPER/Scripts/
    
3. **Crea la struttura delle cartelle**:
    - Apri il terminale ed esegui questo comando:
` mkdir -p "REAPER/Scripts/Cockos/Counter_Script/" `

    - Importa la cartella CounterSample



 ## ⌨️ Assegnazione Scorciatoia (Opzionale)

Per assegnare una scorciatoia da tastiera:

1. Apri REAPER
2. Vai su `Actions > Show Action List`
3. Cerca "Counter Guide"
4. Clicca su "Add" per assegnare un tasto di scelta rapida

## 🎛️ Utilizzo Base

1. **Prepara il progetto**:
   - Organizza con regioni (**N.B. non marker**) nominate (es. "Verse 1", "Chorus", "Bridge")

2. **Seleziona intervallo**:
   - Evidenzia l'area temporale che copre le regioni interessate

3. **Esegui lo script**:
   - Dal menu: `Actions > Scripts > Counter Guide`
   - Oppure usa la scorciatoia assegnata

4. **Risultato**:
   - Nuova traccia "COUNTER GUIDE" con:
     - Annunci delle sezioni
     - Conteggi ritmici pre-transizione

## 🎚️ Flussi Avanzati

### Per Sessioni di Registrazione
```markdown
1. Crea regioni per ogni take
2. Esegui lo script per riferimenti vocali
3. Disabilita traccia durante l'export finale