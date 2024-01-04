function onEvent(name, v1, v2)
	if name == 'Custom Play Animation' then
        if difficultyName == 'Mario' then
            if v2 == 'M' then
                who = 'bf'
            else
                who = 'dad'
            end
        else
            if v2 == 'M' then
                who = 'dad'
            else
                who = 'bf'
            end
        end
        triggerEvent('Play Animation', v1, who)

        if v1 == 'nintendo' then
            makeLuaSprite('nintendo', 'nintendologo', -62, -52)
            setProperty('nintendo.antialiasing', false)
            setProperty('nintendo.angle', 270)
            setObjectOrder('nintendo', getObjectOrder('stagelight1') - 1)
            setProperty('nintendo.visible', false)
            addLuaSprite('nintendo', true)
            doTweenX('nintendoSetX', 'nintendo.scale', 0.2, 0.001, 'linear')
            doTweenY('nintendoSetY', 'nintendo.scale', 0.2, 0.001, 'linear')
        end

        function onTweenCompleted(tag)
            if tag == 'nintendoSetX' then
                setProperty('nintendo.visible', true)
                doTweenX('nintendoShowX', 'nintendo.scale', 1, 0.3, 'linear')
                doTweenY('nintendoShowY', 'nintendo.scale', 1, 0.3, 'linear')
                doTweenAngle('nintendoA', 'nintendo', 360, 0.3, 'linear')
                runTimer('nintendo', 1)
            end
        end

        function onTimerCompleted(tag)
            if tag == 'nintendo' then
                removeLuaSprite('nintendo', false)
            end
        end
    end
end