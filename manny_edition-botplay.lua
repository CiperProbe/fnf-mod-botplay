local notesHitCount = 0
local lastUpdateTime = 0
local lastPostUpdateTime = 0
local UPDATE_INTERVAL = 0.1

function onCreate()
    setProperty('cpuControlled', true)
    setProperty('botplayTxt.visible', false)
    setProperty('ratingName', 'Sick')
    setRatingPercent(1.0)
    setProperty('accuracy', 100.0)
    setRatingFC('SFC')
    notesHitCount = 0
    lastUpdateTime = 0
    lastPostUpdateTime = 0
end

function onCreatePost()
    setProperty('cpuControlled', true)
    setProperty('botplayTxt.visible', false)
    updateScoreText()
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        return
    end
    
    notesHitCount = notesHitCount + 1
    
    addScore(350)
    addHits(1)
    
    if not getProperty('cpuControlled') then
        setProperty('cpuControlled', true)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'fixRating' then
        setProperty('totalNotesHit', notesHitCount)
        setProperty('totalNotesMissed', 0)
        setProperty('totalPlayed', notesHitCount)
    end
end

function noteMissPress(direction)
    addMisses(1)
    setProperty('songMisses', getProperty('songMisses') + 1)
    setProperty('cpuControlled', true)
end

function noteMiss(id, direction, noteType, isSustainNote)
    addMisses(1)
    setProperty('songMisses', getProperty('songMisses') + 1)
    setProperty('cpuControlled', true)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    setProperty('cpuControlled', true)
    return
end

function onUpdate(elapsed)
    lastUpdateTime = lastUpdateTime + elapsed
    
    if lastUpdateTime >= UPDATE_INTERVAL then
        setProperty('cpuControlled', true)
        setProperty('botplayTxt.visible', false)
        
        lastUpdateTime = 0
    end
end

function onUpdatePost(elapsed)
    lastPostUpdateTime = lastPostUpdateTime + elapsed
    
    if lastPostUpdateTime >= UPDATE_INTERVAL then
        local expectedTotal = notesHitCount * 1.0
        local currentTotal = getProperty('totalNotesHit')
        
        if currentTotal ~= expectedTotal and notesHitCount > 0 then
            setProperty('totalNotesHit', expectedTotal)
        end
        
        setProperty('totalNotesMissed', 0)
        setProperty('totalPlayed', notesHitCount)
        setProperty('ratingName', 'Sick')
        setRatingPercent(1.0)
        setProperty('accuracy', 100.0)
        setRatingFC('SFC')
        updateScoreText()
        
        lastPostUpdateTime = 0
    end
end


function onCountdownTick(counter)
    setProperty('cpuControlled', true)
end

function onCountdownStarted()
    setProperty('cpuControlled', true)
end

function onStartCountdown()
    setProperty('cpuControlled', true)
    return Function_Continue
end

function onEvent(name, value1, value2)
    setProperty('cpuControlled', true)
end

function onSongStart()
    setProperty('cpuControlled', true)
end

function onEndSong()
    setProperty('cpuControlled', true)
    return Function_Continue
end

function onDestroy()
    setProperty('cpuControlled', false)
    setProperty('botplayTxt.visible', false)
end

function onRecalculateRating()
    return Function_Continue
end

function onRatingUpdate()
end
