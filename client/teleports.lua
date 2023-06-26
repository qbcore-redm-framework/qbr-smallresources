local function UseTeleport(coords)
    local ped = PlayerPedId()
    SetEntityCoords(ped, coords.xyz)
    SetEntityHeading(ped, coords.w)
end

CreateThread(function()
    for loc, data in pairs(Config.Teleports) do
        for k, v in pairs(data) do
            local newK = k == 1 and 2 or 1
            exports['qbr-core']:createPrompt("smallresources:teleport"..k, v.coords.xyz, 0xCEFD9220, v.text, {
                type = 'callback',
                event = UseTeleport,
                args = {data[newK].coords},
            })
        end
    end
end)