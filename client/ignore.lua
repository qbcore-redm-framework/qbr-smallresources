Citizen.CreateThread(function()
    while true do
        for _, sctyp in next, Config.BlacklistedScenarios['TYPES'] do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, Config.BlacklistedScenarios['GROUPS'] do
            SetScenarioGroupEnabled(scgrp, false)
        end
		Citizen.Wait(10000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local vehiclePool = GetGamePool('CVehicle')
		local pedPool = GetGamePool('CPed')
		local objectPool = GetGamePool('CObject')
        for k,v in pairs(vehiclePool) do
            if Config.BlacklistedVehicles[GetEntityModel(v)] then
				SetEntityAsMissionEntity(v, true, true)
                DeleteVehicle(v)
				SetEntityAsNoLongerNeeded(v)
            end
        end
		for k,v in pairs(pedPool) do
			SetPedDropsWeaponsWhenDead(v, false)
			if Config.BlacklistedPeds[GetEntityModel(v)] then
				SetEntityAsMissionEntity(v, true, true)
				DeletePed(v)
				SetEntityAsNoLongerNeeded(v)
			end
		end
		for k,v in pairs(objectPool) do
			if Config.BlacklistedObjects[GetEntityModel(v)] then
				SetEntityAsMissionEntity(v, true, true)
				DeleteObject(v)
				SetEntityAsNoLongerNeeded(v)
			end
		end
        Citizen.Wait(250)
    end
end)

-- removes events and challenge notfications
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local size = GetNumberOfEvents(0)   
        if size > 0 then
            for i = 0, size - 1 do
                local eventAtIndex = GetEventAtIndex(0, i)
                if eventAtIndex == GetHashKey("EVENT_CHALLENGE_GOAL_COMPLETE") or eventAtIndex == GetHashKey("EVENT_CHALLENGE_REWARD") or eventAtIndex == GetHashKey("EVENT_DAILY_CHALLENGE_STREAK_COMPLETED") then 
                    Citizen.InvokeNative(0x6035E8FBCA32AC5E)
                end
            end
        end
        --- Handsup Moved here to avoid multiple loops. 
        if IsControlJustPressed(0, 0x8CC9CD42) then -- x
            local playerPed = PlayerPedId()
            if not IsEntityDead(playerPed) and not Citizen.InvokeNative(0x9682F850056C9ADE, playerPed) then
                local animDict = "script_proc@robberies@homestead@lonnies_shack@deception"
                if not IsEntityPlayingAnim(playerPed, animDict, "hands_up_loop", 3) then
                    if not HasAnimDictLoaded(animDict) then
                        RequestAnimDict(animDict)

                        while not HasAnimDictLoaded(animDict) do
                            Citizen.Wait(0)
                        end
                    end

                    TaskPlayAnim(playerPed, animDict, "hands_up_loop", 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
                    RequestAnimDict(animDict)
                else
                    ClearPedSecondaryTask(playerPed)
                end
            end
        end
    end
end)