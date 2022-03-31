exports['qbr-core']:AddCommand("id", "Check Your ID #", {}, false, function(source, args)
    TriggerClientEvent('QBCore:Notify', source,  "ID: "..source)
end)

exports['qbr-core']:CreateCallback('smallresources:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(exports['qbr-core']:GetQBPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)
