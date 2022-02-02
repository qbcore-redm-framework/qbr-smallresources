local QBCore = exports['qbr-core']:GetCoreObject()

RegisterNetEvent('qbr-afkkick:server:KickForAFK', function()
    local src = source
	DropPlayer(src, 'You Have Been Kicked For Being AFK')
end)

QBCore.Functions.CreateCallback('qbr-afkkick:server:GetPermissions', function(source, cb)
    local src = source
    local group = QBCore.Functions.GetPermission(src)
    cb(group)
end)
