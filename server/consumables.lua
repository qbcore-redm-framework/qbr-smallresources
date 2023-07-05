-- Drinks
for k in pairs(ConsumeablesDrink) do
    exports['qbr-core']:CreateUseableItem(k, function(source, item)
        local Player = exports['qbr-core']:GetPlayer(source)
        if Player.Functions.RemoveItem(item.name, 1, item.slot) then
            TriggerClientEvent("consumables:client:Drink", source, item.name)
        end
    end)
end

-- DrinkAlcohol
for k in pairs(ConsumeablesAlcohol) do
    exports['qbr-core']:CreateUseableItem(k, function(source, item)
        local Player = exports['qbr-core']:GetPlayer(source)
        TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
    end)
end

-- EAT
for k in pairs(ConsumeablesEat) do 
    exports['qbr-core']:CreateUseableItem(k, function(source, item)
        local Player = exports['qbr-core']:GetPlayer(source)
        if Player.Functions.RemoveItem(item.name, 1, item.slot) then
            TriggerClientEvent("consumables:client:Eat", source, item.name)
        end
    end)
end

-- OTHER

exports['qbr-core']:CreateUseableItem("cigarette", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("cigar", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("dual", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
    TriggerClientEvent("qb:Dual", source)
end)