-- AFK Kick Time Limit (in seconds)
local sid = GetPlayerServerId(PlayerId())
local IsLoggedIn, group

AddStateBagChangeHandler('isLoggedIn', ('player:%s'):format(sid), function(_, _, value)
    IsLoggedIn = value
    if group then return end
    exports['qbr-core']:TriggerCallback('qbr-afkkick:server:GetPermissions', function(UserGroup)
        group = next(UserGroup) and UserGroup or 'user'
    end)
end)

CreateThread(function()
    local prevPos, time
    local secondsUntilKick = 1800
    local timeMinutes = {
        ['900'] = 'minutes',
        ['600'] = 'minutes',
        ['300'] = 'minutes',
        ['150'] = 'minutes',
        ['60'] = 'minutes',
        ['30'] = 'seconds',
        ['20'] = 'seconds',
        ['10'] = 'seconds',
    }
	while true do
		Wait(10000)
        if IsLoggedIn then
            if group == "user" then
                local currentPos = GetEntityCoords(PlayerPedId())
                if prevPos then
                    if currentPos == prevPos then
                        if time then
                            if time > 0 then
                                local _type = timeMinutes[tostring(time)]
                                if _type == 'minutes' then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)
                                elseif _type == 'seconds' then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. time .. ' seconds!', 'error', 10000)
                                end
                                time -= 10
                            else
                                TriggerServerEvent("qbr-afkkick:server:KickForAFK")
                            end
                        else
                            time = secondsUntilKick
                        end
                    else
                        time = secondsUntilKick
                    end
                end
                prevPos = currentPos
            end
        end
    end
end)