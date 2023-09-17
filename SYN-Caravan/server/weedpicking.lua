local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('pickedUpCannabis')
AddEventHandler('pickedUpCannabis', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local hasReceivedSeed = math.random(1, 5) == 1

    if Player.Functions.AddItem("weedleaf", 4) then -- Add Random Amount Each Time
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weedleaf"], "add")

        if hasReceivedSeed then
            Player.Functions.AddItem(Config.WeedSeeds, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WeedSeeds], "add")
        end
    end
end)
