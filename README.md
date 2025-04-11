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

    **Oppure**
