local fireworks_objects = nil 
local function FireWorkObjectCreate(pcoords)
    fireworks_objects = CreateObject(GetHashKey("p_wickerbox01x"), pcoords.x, pcoords.y, pcoords.z-1.20, true, true, false)
    PlaceObjectOnGroundProperly(fireworks_objects)
end

local function FireWorksDo(prefixAssets,particleFx,pcoords,damageScale,expHeight,fireworksCount)
    RequestNamedPtfxAsset(GetHashKey(prefixAssets))
    while not HasNamedPtfxAssetLoaded(GetHashKey(prefixAssets)) do
        Wait(10)
    end
    UseParticleFxAsset(prefixAssets)
    local fireworks = StartParticleFxLoopedAtCoord(particleFx, pcoords, 0.0,0.0,0.0, 0.20, false, false, false, true)
    Citizen.InvokeNative(0x9DDC222D85D5AF2A, fireworks, 10.0)
    SetParticleFxLoopedAlpha(fireworks, 1.0)

    for x=0, fireworksCount,1 do
        local num = math.random(100,800)
        Citizen.InvokeNative(0x53BA259F3A67A99E, pcoords.x, pcoords.y, pcoords.z, 32, 0xF36AD9AC, 0.0, true, false, true) -- Sonido de salida
        Wait(100)
        Citizen.InvokeNative(0x53BA259F3A67A99E, pcoords.x, pcoords.y, pcoords.z+expHeight, damageScale, 0xF36AD9AC, 0.0, true, true, true) -- Sonido explosión
        Wait(num)
    end
    StopParticleFxLooped(fireworks, true)

    Citizen.InvokeNative(0x53BA259F3A67A99E, pcoords.x, pcoords.y, pcoords.z, 32, 0xF36AD9AC, 0.0, true, false, true) -- Sonido de salida
    Wait(100)
    Citizen.InvokeNative(0x53BA259F3A67A99E, pcoords.x, pcoords.y, pcoords.z+expHeight, damageScale, 0xF36AD9AC, 0.0, true, true, true) -- Sonido explosión

    Citizen.Wait(10000)
    DeleteObject(fireworks_objects)
end

RegisterNetEvent('qbr-consumable:client:fireworks',function(prefixAssets,particleFx,damageScale,expHeight,fireworksCount)
    local pcoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 7000, true, false, false, false)
    exports['qbr-core']:Progressbar("fireworks_fire", "Fireworks Plant", 7000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        FireWorkObjectCreate(pcoords)
        Wait(5000)
        FireWorksDo(prefixAssets,particleFx,pcoords,damageScale,expHeight,fireworksCount)
    end, function()
        exports['qbr-core']:Notify(9, "Cancelled..", 2000, 0, 'mp_lobby_textures', 'cross')
    end)
end)
