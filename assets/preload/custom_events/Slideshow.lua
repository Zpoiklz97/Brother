local screen = ''

function onEvent(name, v1, v2)
	if name == 'Slideshow' then
        removeLuaSprite(screen, true)
        if screen == 'audience' then
            removeLuaSprite('upper', true)
            removeLuaSprite('lower', true)
            cancelTween('charMoving')
            removeLuaSprite(char, true)
        end

        removeLuaSprite('nintendo', false)

        screen = v1

        --I HATE LAYERING IN PSYCH GRAAAAAAAAAAAAAAAAAAAAARH
        objectOrder = 1

        if version == '0.7.1' or version == '0.7.1h' then
            objectOrder = -1
        end

        setObjectOrder('brotherlybg', getObjectOrder('dadGroup') + objectOrder)
        setObjectOrder('boyfriendGroup', 100)
        setObjectOrder('dadGroup', 101)

        if screen == 'audience' then
            makeAnimatedLuaSprite('upper', 'screens/upperaudience', -61.95, -54)
            addAnimationByPrefix('upper', 'audience', 'audience', 3, true)
            playAnim('upper', 'audience')
            setProperty('upper.antialiasing', false)
            setObjectOrder('upper', 1)
            addLuaSprite('upper', false)

            makeAnimatedLuaSprite('lower', 'screens/loweraudience', -61.95, -54)
            addAnimationByPrefix('lower', 'audience', 'audience', 3, true)
            playAnim('lower', 'audience')
            setProperty('lower.antialiasing', false)
            setObjectOrder('lower', 3)
            addLuaSprite('lower', false)
        else
            makeLuaSprite(screen, 'screens/'..screen, -61.95, -54)
            setProperty(screen..'.antialiasing', false)
            setObjectOrder(screen, 1)
            addLuaSprite(screen, false)
        end

        creditsppl = {'antreys', 'kale', 'octigone', 'korn', 'hayden'}
        creditsrole = {'charter', 'artist', 'composer', 'coder', 'artist'}

        local charDest = -70
        local nameDest = -20
        local textDest = -10
        if screen == 'credits' then
            for i = 1, 5 do
                makeAnimatedLuaSprite('creditsPerson'..i, 'creditsppl/'..creditsppl[i], -61.95, -110 - (i*80))
                addAnimationByPrefix('creditsPerson'..i, 'walk', 'walk', 6, true)
                playAnim('creditsPerson'..i, 'walk')
                setProperty('creditsPerson'..i..'.antialiasing', false)
                setObjectOrder('creditsPerson'..i, getObjectOrder('brotherlybg') - i+1)
                addLuaSprite('creditsPerson'..i, false) 

                makeLuaSprite('creditsName'..i, 'creditsppl/'..creditsppl[i]..'text', -50 + (i*25), -60 - (i*80))
                setProperty('creditsName'..i..'.antialiasing', false)
                setObjectOrder('creditsName'..i, getObjectOrder('creditsPerson'..i) - i+1)
                addLuaSprite('creditsName'..i, false)

                makeLuaSprite('creditsText'..i, 'creditsppl/'..creditsrole[i], -50 + (i*25), -50 - (i*80))
                setProperty('creditsText'..i..'.antialiasing', false)
                setObjectOrder('creditsText'..i, getObjectOrder('creditsName'..i) - i+1)
                addLuaSprite('creditsText'..i, false)

                if i == 3 then
                    setProperty('creditsName3.x', -55)
                    setProperty('creditsText3.x', 12)
                    setProperty('creditsName3.y', -295)
                    setProperty('creditsText3.y', -295)
                    textDest = nameDest
                elseif i == 4 or i == 5 then
                    setProperty('creditsName'..i..'.x', -140 + (i*25))
                    setProperty('creditsText'..i..'.x', -140 + (i*25))
                end

                if i == 3 then
                    textDest = nameDest
                else
                    textDest = -10
                end

                runTimer('haydenFunkindies', 12.2)

                doTweenY('creditsCharMoving'..i, 'creditsPerson'..i, charDest + ((6-i)*80), 14, 'linear')
                doTweenY('creditsNameMoving'..i, 'creditsName'..i, nameDest + ((6-i)*80), 14, 'linear')
                doTweenY('creditsTextMoving'..i, 'creditsText'..i, textDest + ((6-i)*80), 14, 'linear')
            end
        end
    end
end

char = ''
lastchar = ''
charX = 0
charXOffset = 0
charYOffset = 0
charDestination = 0
charSpeed = 0
charMoving = false
charWalked = false

function onUpdate()
    if screen == 'audience' and not charMoving then
        removeLuaSprite(char, true)
        charMoving = true
        char = audiencechar()
        while char == lastchar do
            char = audiencechar()
        end
        lastchar = char
        makeAnimatedLuaSprite(char, 'audience/'..char, charX + charXOffset, -28 + getRandomInt(charYOffset-3, charYOffset+3))
        addAnimationByPrefix(char, 'walk', 'walk', 14, true)
        setProperty(char..'.antialiasing', false)
        setObjectOrder(char, 2)
        setProperty(char..'.flipX', charWalked)
        playAnim(char, 'walk')
        addLuaSprite(char, false)
        doTweenX('charMoving', char, charDestination + charXOffset, charSpeed, 'linear')
    end

    if getProperty('explode.animation.curAnim.finished') then
        removeLuaSprite('explode', false)
    end
end

function onTweenCompleted(tag)
    if tag == 'charMoving' then
        charMoving = false
    elseif tag == 'creditsCharMoving5' then
        for i = 1, 5 do
            removeLuaSprite('creditsMoving'..i, true)
        end
        makeLuaSprite('ty_octi', 'creditsppl/ty_octi', -30, -30)
        setProperty('ty_octi.antialiasing', false)
        addLuaSprite('ty_octi', false)
    end
end

function onTimerCompleted(tag)
    if tag == 'haydenFunkindies' then
        makeAnimatedLuaSprite('explode', 'explode', 24, -20)
        addAnimationByPrefix('explode', 'explode', 'explode', 12, false)
        playAnim('explode', 'explode')
        setProperty('explode.antialiasing', false)
        setObjectOrder('explode', getObjectOrder('creditsPerson5') + 1)
        addLuaSprite('explode', false)
    end
end

charNames = {
    {'bean', 'toad', 'goomba', 'greenyoshi', 'greenkoopatroopa'}, 
    {'popple', 'drtoad', 'minecartowner', 'blueyoshi', 'flyingbean'}, 
    {'starshadebros', 'sledgebros', 'captain', 'redyoshi', 'redkoopatroopa'}, 
    {'OhoOasis-beta', 'PyschoKamek', 'queenbean', 'pinkyoshi', 'rookiebowser'}, 
    {'olimar', 'goldbean', 'biker', 'goldtoad', 'goldyoshi'}}
charXOffsets = {
    {0, 0, 0, 0, 0}, 
    {0, 0, -24, 0, -10}, 
    {0, -24, 0, 0, 0}, 
    {-20, 0, -10, 0, -20}, 
    {-60, 0, 0, 0, 0}}
charYOffsets = {
    {0, 4, 4, -10, 0}, 
    {-20, 0, 0, -10, -16}, 
    {-36, -4, 0, -10, 0}, 
    {0, 0, -14, -10, -10}, 
    {-5, 0, -10, 0, -10}}
charSpeeds = {
    {5, 5, 5, 5, 5}, 
    {5, 5, 6, 5, 3}, 
    {3, 6, 6, 5, 5}, 
    {4, 5, 6, 5, 6}, 
    {6, 2, 1, 4, 4}}
charOdds = {80, 50, 30, 10, 3}
charWalkeds = {}
charChanceA = {}
charChanceB = {}

r = 0
who = 1
w = 0
oddsA = 1
oddsB = 0

function onCreatePost()
    for i = 1, #charNames do
        if i ~= 1 then
            oddsA = oddsA + charOdds[i-1]
        end
        oddsB = oddsB + charOdds[i]
        table.insert(charChanceA, oddsA)
        table.insert(charChanceB, oddsB)
    end

    for i = 1, #charNames do
        charWalkeds[i] = {}
        for j = 1, #charNames[i] do
            w = getRandomInt(1, 2)
            if w == 1 then
                charWalkeds[i][j] = true
            else
                charWalkeds[i][j] = false
            end
        end
    end
end

function audiencechar()
    charXOffset = 0
    charYOffset = 0
    who = 1
    r = getRandomInt(1, 173)

    for i = 1, #charNames do
        if r >= charChanceA[i] and r <= charChanceB[i] then
            who = getRandomInt(1, #charNames[i])
            if charNames[i][who] == lastchar then
                return charNames[i][who]
            end
            charXOffset = charXOffsets[i][who]
            charYOffset = charYOffsets[i][who]
            charSpeed = charSpeeds[i][who]
            charWalkeds[i][who] = not charWalkeds[i][who]
            charWalked = charWalkeds[i][who]
            if not charWalked then
                charX = -110
                charDestination = 110
            else
                charX = 110
                charDestination = -110
            end
            return charNames[i][who]
        end
    end
end