-- removes events or create Event Triggers to Utilize instead needing to loop in each resource
local GameEvents = {
    [`EVENT_LOOT_COMPLETE`] = {name = 'Looted', size = 3},
    [`EVENT_INVENTORY_ITEM_PICKED_UP`] = {name = 'PickupItem', size = 5},
    [`EVENT_PED_WHISTLE`] = {name = 'Whistle', size = 2},
    [`EVENT_PLAYER_PROMPT_TRIGGERED`] = {name = 'PedPrompt', size = 10},
}

local function DataViewEvent(eventGroup, index, argStructSize)
    local buffer = string.rep("\0", argStructSize * 8)
    Citizen.InvokeNative(0x57EC5FA4D4D6AFCA, eventGroup, index, buffer, argStructSize)
    local data = {}
    data.ped = string.unpack("i4", buffer, 0)
    data.target = argStructSize > 1 and string.unpack("i4", buffer, 9)
    data.complete = argStructSize > 2 and string.unpack("i4", buffer, 17)
    return data
end

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
                elseif GameEvents[eventAtIndex] then
                    local current = GameEvents[eventAtIndex]
                    local data = DataViewEvent(0, i, current.size)
                    TriggerEvent('QBCore:Event:'..current.name, data)
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
