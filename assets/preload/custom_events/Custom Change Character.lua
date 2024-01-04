function onEvent(name, v1, v2)
	if name == 'Custom Change Character' then
        if difficultyName == 'Mario' then
            if v1 == 'M' then
                who = 'bf'
                playable = '-playable'
            else
                who = 'dad'
                playable = ''
            end
        else
            if v1 == 'M' then
                who = 'dad'
                playable = ''
            else
                who = 'bf'
                playable = '-playable'
            end
        end
        triggerEvent('Change Character', who, v2..playable)
        if difficultyName == 'Mario' then
            if v2 == 'marioREDUX' then
                setProperty('boyfriend.x', -84)
            elseif v2 == 'lazymario' then
                setProperty('boyfriend.x', -90)
            end
            setProperty('dad.x', -14)
        end
    end
end