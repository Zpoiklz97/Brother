local clothesAppear = true
local clothesSpeed = 1
local doneOnce = false

function onEvent(name, v1, v2)
	if name == 'Stage Lights' then
        setProperty('brotherlybg.visible', not getProperty('brotherlybg.visible'))
        setProperty('brotherlybgcurtains.visible', not getProperty('brotherlybgcurtains.visible'))
        setProperty('darkbg.visible', not getProperty('darkbg.visible'))
        setProperty('darkbgcurtains.visible', not getProperty('darkbgcurtains.visible'))
        setProperty('stagelight1.visible', not getProperty('stagelight1.visible'))
        setProperty('stagelight2.visible', not getProperty('stagelight2.visible'))
        removeLuaSprite('backgroundland', true)

        tooLate = true

        if not doneOnce then
            clothing = {'clothes', 'clothespoles'}

            for _, i in pairs(clothing) do
                doTweenX(i, i, getProperty(i..'.x') + 300, clothesSpeed, 'sineIn')
            end

            makeAnimatedLuaSprite('advance', 'advance', -36, -20)
            addAnimationByPrefix('advance', 'advance', 'advance', 12, true)
            setProperty('advance.antialiasing', false)
            setProperty('advance.angle', 270)
            
            addLuaSprite('advance', true)
            doTweenX('advanceX', 'advance.scale', 1, 0.2, 'linear')
            doTweenY('advanceY', 'advance.scale', 1, 0.2, 'linear')
            doTweenAngle('advanceA', 'advance', 360, 0.2, 'linear')
            runTimer('stay', 1)
        end

        doneOnce = true
    end
end

function onTimerCompleted(tag)
    if tag == 'stay' then
        removeLuaSprite('advance', false)
    end
end

function onTweenCompleted(tag)
    if tag == 'backgroundland' then
        removeLuaSprite('backgroundland', true)
    end
end

local fullCode = {'C', 'A', 'R'}
local curCode = 1
local finishCode = false
tooLate = false --no way Mr L reference!?!??!!?

function onUpdatePost()
    if not finishCode and not tooLate then
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..fullCode[curCode]) then
            --debugPrint(fullCode[curCode])
            if curCode ~= #fullCode then
                    curCode = curCode + 1
            else
                    curCode = 1
                    finishCode = true
                    clothesSpeed = 0.4
            end
        elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ANY') and not getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..fullCode[curCode]) then
            curCode = 1
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'clothes' and finishCode then
        playSound('advance', 1)
        cameraShake('camGame', 0.05, 1)
    end
end