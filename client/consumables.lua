local sharedItems = exports['qbr-core']:GetItems()
local isBusy = false

local function loadAnimDict(dict, anim)
    RequestAnimDict(dict) 
    while not HasAnimDictLoaded(dict) do Wait(0) end
    return dict
end

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    return model
end

local function doAnim(Amodel, bone, pX, pY, pZ, rX, rY, rZ, anim, Adict, duration)
    local ped = PlayerPedId()
    local model = loadModel(joaat(Amodel))
    object = CreateObject(model, GetEntityCoords(ped), true, false, false)
    AttachEntityToEntity(object, ped, GetEntityBoneIndexByName(ped, bone), pX, pY, pZ, rX, rY, rZ, false, true, true, true, 0, true)
    local dict = loadAnimDict(Adict)
    TaskPlayAnim(ped, dict, anim, 5.0, 5.0, duration, 1, false, false, false)
    SetModelAsNoLongerNeeded(model)
    RemoveAnimDict(dict)
end

local function AnimDetatch(sleep)
    Wait(sleep)
    if not object then return end
    DetachEntity(object, true, true)
    DeleteObject(object)
end

RegisterNetEvent("consumables:client:Drink", function(itemName)
    if isBusy then return end
    local ped = PlayerPedId()
    isBusy = not isBusy
    local sleep = 5000
    SetCurrentPedWeapon(ped, `weapon_unarmed`)
    Wait(100)
    if not IsPedOnMount(ped) and not IsPedInAnyVehicle(ped) then
        local object = nil
        doAnim("p_mugcoffee01x", "SKEL_R_FINGER12", 0.0, -0.05, 0.03, 0.0, 180.0, 180.0, 'action', 'mech_inventory@drinking@coffee', sleep)
    end
    exports['qbr-core']:Progressbar("drink_something", "Drinking..", sleep, false, true, {
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", sharedItems[itemName], "remove")
		exports['qbr-hud']:UpdateStatus({thirst = ConsumeablesDrink[itemName]})
    end)
    ClearPedTasks(ped)
    AnimDetatch (sleep)
    isBusy = not isBusy
end)

RegisterNetEvent("consumables:client:Smoke", function(itemName)
    if isBusy then return end
    local ped = PlayerPedId()
    isBusy = not isBusy
    local sleep = 10000
    SetCurrentPedWeapon(ped, `weapon_unarmed`)
    Wait(100)
    local cigar = nil
    if not IsPedOnMount(ped) and not IsPedInAnyVehicle(ped) then
        local item_model = nil
        local pX, pY, pZ, rX, rY, rZ = nil, nil, nil, nil, nil, nil
        if itemName == "cigar" then
            sleep = 20000
            item_model = "p_cigar01x"
            pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.0, 0.0, 00.0, 0.0
        else
            item_model = "p_cigarette_cs01x"
            pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.01, 0.0, 180.0, 90.0
        end
        doAnim(item_model, "SKEL_R_FINGER12", pX, pY, pZ, rX, rY, rZ, 'base', 'amb_wander@code_human_smoking_wander@cigar@male_a@base', sleep)
    end
    exports['qbr-core']:Progressbar("smoking", "Smoking..", sleep, false, true, {
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", sharedItems[itemName], "remove")
		exports['qbr-hud']:UpdateStatus({stress = math.random(-40, -20)})
    end)
    ClearPedTasks(ped)
    AnimDetatch (sleep)
    isBusy = not isBusy
end)

RegisterNetEvent("consumables:client:DrinkAlcohol", function(itemName)
    if isBusy then return end
    local ped = PlayerPedId()
    isBusy = not isBusy
    sleep = 5000
    SetCurrentPedWeapon(ped, `weapon_unarmed`)
    Wait(100)
    local bottle = nil
    if not IsPedOnMount(ped) and not IsPedInAnyVehicle(ped) then
        doAnim("s_inv_whiskey01x", "SKEL_R_FINGER12", 0.0, -0.05, 0.22, 0.0, 180.0, 180.0, 'base_trans_cheers_putaway', 'mp_mech_inventory@drinking@moonshine@drunk@male_a', sleep)
    end
    exports['qbr-core']:Progressbar("drink_alcohol", "Drinking liquor..", math.random(3000, 6000), false, true, {
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", sharedItems[itemName], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
		exports['qbr-hud']:UpdateStatus({thirst = ConsumeablesAlcohol[itemName]})
    end, function()
        exports['qbr-core']:Notify(9, "Cancelled..", 2000, 0, 'mp_lobby_textures', 'cross')
    end)
    Wait(sleep)
    if bottle ~= nil then
        DetachEntity(bottle, true, true)
        DeleteObject(bottle)
    end
    ClearPedTasks(ped)
    AnimDetatch(sleep)
    isBusy = not isBusy
end)

RegisterNetEvent("consumables:client:Eat", function(itemName)
    if isBusy then return end
    local ped = PlayerPedId()
    isBusy = not isBusy
    SetCurrentPedWeapon(ped, `weapon_unarmed`)
    Wait(100)
    if not IsPedOnMount(ped) and not IsPedInAnyVehicle(ped) then
        local dict = loadAnimDict('mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese')
        TaskPlayAnim(ped, dict, 'quick_right_hand', 5.0, 5.0, -1, 1, false, false, false)
    end
    exports['qbr-core']:Progressbar("eat_something", "Eating..", 5000, false, true, {
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", sharedItems[itemName], "remove")
		exports['qbr-hud']:UpdateStatus({stress = math.random(-4, -2), hunger = ConsumeablesEat[itemName]})
    end)
    ClearPedTasks(ped)
    isBusy = not isBusy
end)

RegisterNetEvent("qb:Dual", function()
    local player = PlayerPedId()
	Citizen.InvokeNative(0xB282DC6EBD803C75, player, `weapon_revolver_cattleman`, 500, true, 0)
	Citizen.InvokeNative(0x5E3BDDBCB83F3D84, player, `weapon_pistol_volcanic`, 500, true, 0, true, 1.0)
end)
