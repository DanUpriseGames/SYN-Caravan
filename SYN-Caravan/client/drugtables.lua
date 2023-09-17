local QBCore = exports['qb-core']:GetCoreObject()

local deleteobj = false -- Declared here so it maintains its value

RegisterNetEvent('SYN-Caravan:Createtable')
AddEventHandler('SYN-Caravan:Createtable', function(spawnedObj)
    local ped = GetPlayerPed(PlayerId())
    local inveh = IsPedInAnyVehicle(ped)
    
    if not deleteobj and not inveh then
        FreezeEntityPosition(ped, true)
        TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
        Wait(300)
        FreezeEntityPosition(ped, false)
        local modelHash = Config.WeedTables 
        local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
        local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
        local forward = GetEntityForwardVector(PlayerPedId())
        local x, y, z = table.unpack(coords + forward * 0.5)
        local spawnedObj = CreateObject(modelHash, x, y, z, true, false, false)
        PlaceObjectOnGroundProperly(spawnedObj)
        SetEntityHeading(spawnedObj, heading)
        FreezeEntityPosition(spawnedObj, modelHash)
        deleteobj = true
    end
end)

RegisterNetEvent('SYN-Caravan:DeleteTable')
AddEventHandler('SYN-Caravan:DeleteTable', function()
    local ped = GetPlayerPed(PlayerId())
    if deleteobj then
        local obj = QBCore.Functions.GetClosestObject(spawnedObj)
        if DoesEntityExist(obj) and not IsEntityDead(obj) then
            TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
            Wait(500)
            DeleteObject(obj)
            QBCore.Functions.Notify('Picked Up Table!', 'success', 7500)
            deleteobj = false
            Wait(500)
            ClearPedTasks(ped)
        else
            QBCore.Functions.Notify('The object is not valid.', 'error')
        end
    end
end)

RegisterNetEvent("SYN-Caravan:MakeWeedBaggy")
AddEventHandler("SYN-Caravan:MakeWeedBaggy", function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
            exports['ps-ui']:Circle(function(success)
                if success then
                    MakeWeedBaggy()
                else
                    QBCore.Functions.Notify('Failed to complete minigame', 'error')
                end
            end, 2, 20)
        else
            QBCore.Functions.Notify("You don't have any ingredients bruh..", "error")
        end
    end, 'weedleaf')
end)

function MakeWeedBaggy()
    TriggerServerEvent('SYN-Caravan:server:removeIngred')
    QBCore.Functions.Progressbar('pickup', 'Making Some Of That Good Shit..', 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(4000)
    TriggerServerEvent('SYN-Caravan:server:addWeedBaggy')
    QBCore.Functions.Notify('You made some bomb as shit bruh', 'success')
end
