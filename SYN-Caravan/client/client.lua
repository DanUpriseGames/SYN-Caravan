local QBCore = exports['qb-core']:GetCoreObject()

local originalCoords = nil
local inInstance = false

-- Event to Teleport and Hide
RegisterNetEvent('instance:teleportAndHide')
AddEventHandler('instance:teleportAndHide', function()
    if not inInstance then
        Citizen.Wait(1000)
        local playerPed = GetPlayerPed(-1)
        originalCoords = GetEntityCoords(playerPed)
        SetEntityCoords(playerPed, -368.16, -237.06, 29.65, 359.03, true, true, true, true)
        for _, id in ipairs(GetActivePlayers()) do
            if id ~= PlayerId() then
                local ped = GetPlayerPed(id)
                SetEntityLocallyInvisible(ped)
                SetEntityNoCollisionEntity(playerPed, ped, true)
            end
        end
        TriggerServerEvent('enterPersonalInstance')
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'houses_door_open', 0.1)
        TriggerEvent('QBCore:Notify', 'You have entered the RV', 'success')
        inInstance = true
        openHouseAnim()
    end
end)

-- Event to Teleport out
RegisterNetEvent('instance:teleportBackAndShow')
AddEventHandler('instance:teleportBackAndShow', function()
    if inInstance then
        print("Attempting to teleport back...")
        if originalCoords then
            TriggerServerEvent('leavePersonalInstance') -- Trigger the event first   
            TriggerEvent('QBCore:Notify', 'You have left the RV', 'success')
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)

            openHouseAnim()
            DoScreenFadeOut(500)

            Wait(1000)

            DoScreenFadeIn(1000)

            TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)

            SetEntityCoords(GetPlayerPed(-1), originalCoords.x, originalCoords.y, originalCoords.z)
        end
        for _, id in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(id)
            SetEntityLocallyVisible(ped)
        end
        inInstance = false -- Reset the flag
    end
end)

function openHouseAnim()
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(5)
        end
    end
end

local hasCreatedRVShell = false

RegisterNetEvent('createRVShell')
AddEventHandler('createRVShell', function()
    if not hasCreatedRVShell then
        local newCoords = vector3(-366.8, -235.13, 28.54)
        local journeyShellHash = GetHashKey("shell_trailer")
        local journeyShell = CreateObject(journeyShellHash, newCoords.x, newCoords.y, newCoords.z, false, false, false)

        Citizen.Wait(500)
        FreezeEntityPosition(journeyShell, true)

        hasCreatedRVShell = true
    end
end)


-- Event to Register Multiple Events Into One
RegisterNetEvent('enterCaravan')
AddEventHandler('enterCaravan', function()
    for _, event in ipairs({"createRVShell", "instance:teleportAndHide"}) do
        TriggerEvent(event)
    end
end)

-- Menu for When Entering Caravan
RegisterNetEvent('SYN-Caravan:client:OpenMenu', function()
    local bossMenu = {
        {
            header = "Suspicious Caravan",
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        },
        {
            header = "Enter Caravan",
            txt = "Come Inside!",
            icon = "fas fa-cannabis",
            params = {
                event = "enterCaravan",
            }
        },
        {
            header = "Knock on Door",
            txt = "Is anyone home?",
            icon = "fa-solid fa-list",
            params = {
                event = "instance:teleportAndHide",
            }
        }
    }
    
    exports['qb-menu']:openMenu(bossMenu)
end)

RegisterCommand("getvehicleinfo", function()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    if vehicle and distance < 5.0 then  -- Assuming you want to get info for vehicles within 5 meters
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerServerEvent("getVehicleInfo:fetch", plate)
    else
        print("No vehicle found nearby.")
    end
end, false)

RegisterNetEvent("getVehicleInfo:display")
AddEventHandler("getVehicleInfo:display", function(data)
    if data then
        print("Vehicle Information:")
        print("Plate: " .. tostring(data.plate))
        print("Citizen ID: " .. tostring(data.citizenid))
    else
        print("No information found for this vehicle.")
    end
end)

