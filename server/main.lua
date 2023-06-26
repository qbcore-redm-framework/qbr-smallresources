exports['qbr-core']:AddCommand("id", "Check Your ID #", {}, false, function(source)
	TriggerClientEvent('QBCore:Notify', source, 9,  "ID: "..source, 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
end)

AddEventHandler("entityCreating", function(handle)
    local entityModel = GetEntityModel(handle)
	if not Config.BlacklistedModels[entityModel] then return end
    CancelEvent()
end)