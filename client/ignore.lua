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
    end
end)

--Fixes the issue where you can't move or interact with anything after pressing space for the abilities
CreateThread(function()
    --Citizen.InvokeNative(0xAD7B70F7230C5A12) --this native clears all apps
    while true do        
        if IsControlJustPressed(0, 0xAC4BD4F1) or IsDisabledControlJustPressed(0, 0xAC4BD4F1) then
            exitMenu = false
            while not exitMenu do 
                if not IsControlPressed(0, 0xAC4BD4F1) and not IsDisabledControlJustPressed(0, 0xAC4BD4F1) then
                    Citizen.InvokeNative(0xAD7B70F7230C5A12)
                    exitMenu = true
                end
                Wait(1)
            end
        end
        
        if IsControlPressed(0,0x1F6D95E5) or IsDisabledControlJustPressed(0,0x1F6D95E5) then
            if IsControlPressed(0, 0x77E56FB3 ) or IsDisabledControlJustPressed(0, 0x77E56FB3 ) then
                exitMenu = false
                while not exitMenu do 
                    if not IsControlPressed(0, 0x1F6D95E5) and not IsDisabledControlJustPressed(0, 0x1F6D95E5) then
                        
                        Citizen.InvokeNative(0xAD7B70F7230C5A12)
                        exitMenu = true
                    end
                    Wait(1)
                end
            end
        end
        Wait(1)
    end
 end)

