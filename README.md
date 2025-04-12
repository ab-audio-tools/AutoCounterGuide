# AutoCounterGuide REAPER Count-in Guide Script 🎚️⏱️

## 🇬🇧 English
**AutoCounterGuide** is a Lua script for REAPER that automatically generates a guide track with vocal counts and section announcements, perfect for live recording sessions, music production, audio post-production, and live backing tracks.

![Example of COUNTER GUIDE track in REAPER](cover.png)

## 🌟 Key Features

- **Automatic creation** of the "COUNTER GUIDE" track (or reuses it if it exists)
- **Smart analysis** of regions within the time selection
- **Advanced counting system**:
  - Next section announcement on the 4th beat before the end
  - "two, three, four" count on the following 3 beats
- **Special pre-count** (6 beats) when the next section is "Intro"
- **Automatic cleanup** of existing items in the time selection
- **Debug console** with detailed execution information

## 🛠️ Technical Requirements

- REAPER version 6.x or 7.x
- Write permissions in REAPER's scripts folder

## 📥 Step-by-Step Installation

1. **Download the script**:
   - Clone the repository: `git clone https://github.com/ab-audio-tools/AutoCounterGuide.git`
   - Alternatively download the source code
2. **Place the script**:
   - Windows: C:\Users\AppData\Roaming\REAPER\Scripts
   - MacOS: ~/Library/Application Support/REAPER/Scripts/
   - Linux: ~/.config/REAPER/Scripts/
    
3. **Create folder structure**:
   - Open terminal and run this command:
` mkdir -p "REAPER/Scripts/Cockos/Counter_Script/" `

   - Import the CounterSample folder

 ## ⌨️ Keyboard Shortcut Assignment (Optional)

To assign a keyboard shortcut:

1. Open REAPER
2. Go to `Actions > Show Action List`
3. Search for "Counter Guide"
4. Click "Add" to assign a hotkey

## 🎛️ Basic Usage

1. **Prepare your project**:
   - Organize with named regions (**NOTE: not markers**) (e.g., "VERSE", "CHORUS", "BRIDGE")
   >Region names must be in uppercase and without numbers

2. **Select time range**:
   - Highlight the time area covering the relevant regions

3. **Run the script**:
   - From menu: `Actions > Scripts > Counter Guide`
   - Or use your assigned shortcut

4. **Result**:
   - New "COUNTER GUIDE" track containing:
     - Section announcements
     - Pre-transition rhythmic counts

## 🐛 Troubleshooting


| Issue                      | Solution                      |
|----------------------------|-------------------------------|
| "File not found"           | Verify path and filenames     |
| Misaligned counts          | Check project BPM             |
| Lua errors                 | Update REAPER to latest version |
| Track not created          | Check write permissions       |


## 🤝 Contributions

Contributions are welcome! Here's how to help:

1. **Fork** the repository
2. **Create a branch**:  
   `git checkout -b feature/improvement`
3. **Commit your changes**:  
   `git commit -am 'Add new feature'`
4. **Push the branch**:  
   `git push origin feature/improvement`
5. **Create a Pull Request**

## 📜 License

**MIT License** - Use, modify and distribute freely

## 🇮🇹 Italiano
**AutoCounterGuide** è uno script Lua per REAPER che genera automaticamente una traccia di guida con conteggi vocali e annunci di sezione, perfetto per sessioni di registrazione dal vivo, produzione musicale, post-produzione audio e live backing tracks.

![Esempio di traccia COUNTER GUIDE in REAPER](cover.png)

## 🌟 Funzionalità principali

- **Creazione automatica** della traccia "COUNTER GUIDE" (o riutilizza, se esiste)
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

## 📥 Installazione passo-passo

1. **Scarica lo script**:
   - Clona la repository 'git clone https://github.com/ab-audio-tools/AutoCounterGuide.git'
  In alternativa scarica il source code
2. **Posiziona lo script**:
    - Windows: C:\Users\AppData\Roaming\REAPER\Scripts
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
   - Organizza con regioni (**N.B. non marker**) nominate (es. "VERSE", "CHORUS", "BRIDGE") 
  >I nomi delle regioni devono essere scritti in maiuscolo e senza nomi

2. **Seleziona intervallo**:
   - Evidenzia l'area temporale che copre le regioni interessate

3. **Esegui lo script**:
   - Dal menu: `Actions > Scripts > Counter Guide`
   - Oppure usa la scorciatoia assegnata

4. **Risultato**:
   - Nuova traccia "COUNTER GUIDE" con:
     - Annunci delle sezioni
     - Conteggi ritmici pre-transizione

## 🐛 Troubleshooting


| Problema                  | Soluzione                      |
|---------------------------|--------------------------------|
| "File non trovato"        | Verifica percorso e nomi file  |
| Conteggi non allineati    | Controlla il BPM del progetto  |
| Errori Lua                | Aggiorna REAPER all'ultima versione |
| Traccia non creata        | Controlla i permessi di scrittura |


## 🤝 Contributi

I contributi sono benvenuti! Ecco come aiutare:

1. **Forka** il repository
2. **Crea un branch**:  
   `git checkout -b feature/improvement`
3. **Fai commit** delle modifiche:  
   `git commit -am 'Aggiungi nuova funzionalità'`
4. **Pusha** il branch:  
   `git push origin feature/improvement`
5. **Crea una Pull Request**

## 📜 Licenza

**MIT License** - Usa, modifica e distribuisci liberamente
