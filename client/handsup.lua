local handsup = false
local animDict = "mech_busted@arrest"
local animTrans = "hands_up_transition"
local animLoop = "hands_up_loop"
local keyhash = 0x8CC9CD42 -- X

CreateThread(function()
    while true do
        Wait(5)
        if IsControlJustPressed(0, keyhash) then 
            HandsUp()
        end
    end
end)

function HandsUp()
    local ped = PlayerPedId()
    if not handsup then
        loadAnimDict(animDict)
        TaskPlayAnim(ped, animDict, animTrans, 3.0, -1, -1, 31, 0, false, false, false)
        while IsEntityPlayingAnim(ped, animDict, animTrans, 3) do
            Wait(5)
        end
        StopAnimTask(ped, animDict, animTrans, 1.0)
        TaskPlayAnim(ped, animDict, animLoop, 3.0, -1, -1, 31, 0, false, false, false)
        handsup = true
    else
        StopAnimTask(ped, animDict, animTrans, 1.0)
        StopAnimTask(ped, animDict, animLoop, 1.0)
        Wait(150)
        ClearPedTasks(ped)
        handsup = false
    end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(5)
	end
end
