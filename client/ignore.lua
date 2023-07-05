-- removes events and challenge notfications
CreateThread(function()
    local DisableEvents = Config.DisableEvents
    while true do
        Wait(10)
        local size = GetNumberOfEvents(0)   
        if size > 0 then
            for i = 0, size - 1 do
                local eventAtIndex = GetEventAtIndex(0, i)
                if DisableEvents[eventAtIndex] then 
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