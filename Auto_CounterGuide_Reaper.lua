function main()
  -- Verifica se esiste una time selection
  local start_time, end_time = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)
  if start_time == end_time then
    reaper.ShowMessageBox("Seleziona un intervallo di tempo prima di eseguire lo script.", "Errore", 0)
    return
  end
  
  -- Ottieni informazioni sul tempo del progetto in modo corretto
  local tempo = reaper.Master_GetTempo()
  local beat_length = 60 / tempo
  reaper.ShowConsoleMsg("BPM: " .. tempo .. ", Lunghezza battito: " .. beat_length .. " secondi\n")
  
  -- Trova o crea la traccia "COUNTER GUIDE"
  local counter_track = nil
  local track_found = false
  
  for i = 0, reaper.CountTracks(0) - 1 do
    local track = reaper.GetTrack(0, i)
    local _, track_name = reaper.GetTrackName(track)
    if track_name == "COUNTER GUIDE" then
      counter_track = track
      track_found = true
      break
    end
  end
  
  if not track_found then
    -- La traccia non esiste, creala
    reaper.InsertTrackAtIndex(reaper.CountTracks(0), true)
    counter_track = reaper.GetTrack(0, reaper.CountTracks(0) - 1)
    reaper.GetSetMediaTrackInfo_String(counter_track, "P_NAME", "COUNTER GUIDE", true)
  end
  
  -- Cancella eventuali item esistenti nella time selection sulla traccia COUNTER GUIDE
  local item_count = reaper.GetTrackNumMediaItems(counter_track)
  for i = item_count - 1, 0, -1 do
    local item = reaper.GetTrackMediaItem(counter_track, i)
    local item_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    local item_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    local item_end = item_pos + item_len
    
    -- Se l'item si sovrappone all'intervallo di tempo, cancellalo
    if (item_pos >= start_time and item_pos < end_time) or
       (item_end > start_time and item_end <= end_time) or
       (item_pos <= start_time and item_end >= end_time) then
      reaper.DeleteTrackMediaItem(counter_track, item)
    end
  end
  
  -- Ottieni tutte le regioni nel progetto che si sovrappongono alla time selection
  local regions = {}
  local marker_count = reaper.CountProjectMarkers(0)
  
  for i = 0, marker_count - 1 do
    local retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers3(0, i)
    if retval and isrgn == true then
      -- Verifica se la regione si sovrappone alla time selection
      if (pos < end_time and rgnend > start_time) then
        table.insert(regions, {
          name = name or "Unnamed", -- Assicurati che name non sia nil
          start_time = pos,
          end_time = rgnend,
          index = markrgnindexnumber
        })
        reaper.ShowConsoleMsg("Regione trovata: " .. (name or "Unnamed") .. " da " .. pos .. " a " .. rgnend .. "\n")
      end
    end
  end
  
  -- Ordina le regioni per posizione di inizio
  table.sort(regions, function(a, b) return a.start_time < b.start_time end)
  
  -- Mostra le regioni ordinate
  reaper.ShowConsoleMsg("Regioni ordinate per analisi:\n")
  for i, region in ipairs(regions) do
    reaper.ShowConsoleMsg(i .. ": " .. region.name .. " da " .. region.start_time .. " a " .. region.end_time .. "\n")
  end
  
  -- Per ogni regione, calcola gli ultimi 4 battiti e inserisci gli audio guide
  for i, region in ipairs(regions) do
    -- Salta l'ultima regione nella selezione
    if i == #regions then
      reaper.ShowConsoleMsg("Regione " .. region.name .. " è l'ultima regione, salto il conteggio\n")
      goto continue
    end
    
    local region_end = region.end_time
    local next_region_name = ""
    
    -- Trova il nome della prossima regione
    if i < #regions then
      next_region_name = regions[i+1].name
      reaper.ShowConsoleMsg("Prossima regione per " .. region.name .. " è " .. next_region_name .. "\n")
    end
    
    -- Calcola i battiti prima della fine della regione
    reaper.ShowConsoleMsg("Calcolo battiti per la regione " .. region.name .. ":\n")
    
    -- Determina il numero esatto di battiti nella regione
    local region_length = region.end_time - region.start_time
    local beats_in_region = region_length / beat_length
    reaper.ShowConsoleMsg("Lunghezza regione: " .. region_length .. " secondi, contiene circa " .. beats_in_region .. " battiti\n")
    
    -- Verifica se siamo nel pre-count (la prossima sezione è "Intro")
    local is_precount = string.lower(next_region_name) == "intro"
    local beats_to_process = 4  -- Default 4 battiti
    
    if is_precount then
      beats_to_process = 6  -- 6 battiti per pre-count
      reaper.ShowConsoleMsg("Pre-count rilevato! Utilizzerò 6 battiti\n")
    end
    
    -- Assicurati che ci siano abbastanza battiti nella regione
    beats_to_process = math.min(beats_to_process, math.floor(beats_in_region))
    reaper.ShowConsoleMsg("Elaborerò " .. beats_to_process .. " battiti per questa regione\n")
    
    -- Calcola la posizione esatta di ogni battito
    for beat = beats_to_process, 1, -1 do
      -- Calcola il tempo esatto in base al BPM
      local beat_time = region_end - (beat * beat_length)
      reaper.ShowConsoleMsg("  Beat " .. beat .. " calcolato a " .. beat_time .. " secondi\n")
      
      -- Controlla che il beat sia effettivamente all'interno della regione
      if beat_time >= region.start_time then
        -- Gestione speciale per il pre-count
        if is_precount then
          if beat == 6 then
            -- Primo beat: "intro"
            local clean_name = "intro"
            reaper.ShowConsoleMsg("  Inserisco audio per sezione: " .. clean_name .. " a " .. beat_time .. "\n")
            insertAudioItem(counter_track, beat_time, clean_name)
          elseif beat == 5 then
            -- Secondo beat: silenzio (non inserire nulla)
            reaper.ShowConsoleMsg("  Beat 5: silenzio (non inserisco audio)\n")
          elseif beat == 4 then
            -- Terzo beat: "one"
            reaper.ShowConsoleMsg("  Inserisco audio per conteggio: one a " .. beat_time .. "\n")
            insertAudioItem(counter_track, beat_time, "one")
          elseif beat == 3 then
            -- Quarto beat: "two"
            reaper.ShowConsoleMsg("  Inserisco audio per conteggio: two a " .. beat_time .. "\n")
            insertAudioItem(counter_track, beat_time, "two")
          elseif beat == 2 then
            -- Quinto beat: "three"
            reaper.ShowConsoleMsg("  Inserisco audio per conteggio: three a " .. beat_time .. "\n")
            insertAudioItem(counter_track, beat_time, "three")
          elseif beat == 1 then
            -- Sesto beat: "four"
            reaper.ShowConsoleMsg("  Inserisco audio per conteggio: four a " .. beat_time .. "\n")
            insertAudioItem(counter_track, beat_time, "four")
          end
        else
          -- Comportamento normale (non pre-count)
          if beat == 4 and next_region_name ~= "" then
            -- Per il primo beat (4), annuncia la prossima sezione
            local clean_name = string.lower(next_region_name:gsub("%s+", ""))
            reaper.ShowConsoleMsg("  Inserisco audio per sezione: " .. clean_name .. " a " .. beat_time .. "\n")
            insertAudioItem(counter_track, beat_time, clean_name)
          else
            -- Per gli altri beat, inserisci i numeri
            local count_name = ""
            if beat == 3 then 
              count_name = "two"
            elseif beat == 2 then 
              count_name = "three"
            elseif beat == 1 then 
              count_name = "four"
            end
            
            -- Verifica che count_name sia stato impostato correttamente
            if count_name ~= "" then
              reaper.ShowConsoleMsg("  Inserisco audio per conteggio: " .. count_name .. " a " .. beat_time .. "\n")
              insertAudioItem(counter_track, beat_time, count_name)
            else
              reaper.ShowConsoleMsg("  ERRORE: count_name non impostato per beat " .. beat .. "\n")
            end
          end
        end
      else
        reaper.ShowConsoleMsg("  Beat " .. beat .. " fuori dalla regione, salto\n")
      end
    end
    
    ::continue::
  end
  
  reaper.UpdateArrange()
  return true
end

-- Funzione per inserire un item audio nella traccia
function insertAudioItem(track, position, name)
  -- Evita errori se name è nil
  if name == nil then
    reaper.ShowConsoleMsg("ERRORE: nome file nil, salto inserimento\n")
    return nil
  end
  
  -- Percorso corretto come specificato
  local media_path = reaper.GetResourcePath() .. "/Scripts/Cockos/Counter_Script/CounterSamples/" .. name .. ".wav"
  
  reaper.ShowConsoleMsg("Cerco file: " .. media_path .. "\n")
  
  -- Verifica se il file esiste
  local file = io.open(media_path, "r")
  if not file then
    reaper.ShowConsoleMsg("FILE NON TROVATO: " .. media_path .. "\n")
    return nil
  else
    file:close()
    reaper.ShowConsoleMsg("File trovato: " .. media_path .. "\n")
  end
  
  -- Crea un nuovo item
  local item = reaper.AddMediaItemToTrack(track)
  reaper.SetMediaItemPosition(item, position, false)
  
  -- Aggiunge il file audio all'item
  local take = reaper.AddTakeToMediaItem(item)
  local pcm_source = reaper.PCM_Source_CreateFromFile(media_path)
  reaper.SetMediaItemTake_Source(take, pcm_source)
  
  -- Imposta la lunghezza dell'item in base alla lunghezza del file audio
  local source_length = reaper.GetMediaSourceLength(pcm_source)
  reaper.SetMediaItemLength(item, source_length, false)
  
  -- Rinomina il take
  reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", name, true)
  
  reaper.ShowConsoleMsg("Item audio inserito a " .. position .. " con nome " .. name .. "\n")
  
  return item
end

-- Esegui lo script
reaper.ClearConsole()
reaper.ShowConsoleMsg("=== Inizio esecuzione script Counter Guide ===\n")
reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

-- Esecuzione sicura con gestione degli errori
local ok, err = pcall(main)
if not ok then
  reaper.ShowConsoleMsg("ERRORE SCRIPT: " .. tostring(err) .. "\n")
  reaper.ShowMessageBox("Si è verificato un errore: " .. tostring(err), "Errore Script", 0)
end

reaper.Undo_EndBlock("Counter Guide Script", -1)
reaper.PreventUIRefresh(-1)
reaper.ShowConsoleMsg("=== Fine esecuzione script Counter Guide ===\n")