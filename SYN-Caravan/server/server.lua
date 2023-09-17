-- Import QBCore
local QBCore = exports['qb-core']:GetCoreObject()
local instanceMappings = {}
local vehicleInstanceMappings = {}

-- Event for Entering Into Own Instance
RegisterNetEvent('enterPersonalInstance')
AddEventHandler('enterPersonalInstance', function()
    local src = source
    local citizenID = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    local uniqueBucket = citizenID
    SetPlayerRoutingBucket(src, uniqueBucket)
    instanceMappings[src] = citizenID
    TriggerClientEvent('instance:teleportAndHide', src)
end)

-- Event for Entering Into Vehicle Instance
RegisterNetEvent('enterVehicleInstance')
AddEventHandler('enterVehicleInstance', function(plate)
    local src = source
    exports.oxmysql:fetch('SELECT * FROM player_vehicles WHERE plate = ?', { plate }, function(result)
        if result and #result > 0 then
            local uniqueBucket = plate .. '-' .. src
            SetPlayerRoutingBucket(src, uniqueBucket)
            vehicleInstanceMappings[src] = uniqueBucket
            TriggerClientEvent('instance:teleportAndHide', src)
        end
    end)
end)

-- Event for Exiting Out Of Instance
RegisterNetEvent('leavePersonalInstance')
AddEventHandler('leavePersonalInstance', function()
    local src = source
    local citizenID = instanceMappings[src]

    if citizenID then
        SetPlayerRoutingBucket(src, 0)
        instanceMappings[src] = nil
        TriggerClientEvent('instance:teleportBackAndShow', src)
    end
end)

-- Event for Exiting Out Of Vehicle Instance
RegisterNetEvent('leaveVehicleInstance')
AddEventHandler('leaveVehicleInstance', function()
    local src = source
    local uniqueBucket = vehicleInstanceMappings[src]

    if uniqueBucket then
        SetPlayerRoutingBucket(src, 0)
        vehicleInstanceMappings[src] = nil
        TriggerClientEvent('instance:teleportBackAndShow', src)
    end
end)

-- Command for Checking Current Instance
RegisterCommand('checkInstance', function(source, args)
    local src = source
    local citizenID = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    local uniqueBucket = citizenID
    local instanceID = GetPlayerRoutingBucket(src)

    if instanceID == uniqueBucket then
        TriggerClientEvent('chatMessage', src, '^2You are in your personal instance.')
    else
        TriggerClientEvent('chatMessage', src, '^1You are not in your personal instance.')
    end
end)