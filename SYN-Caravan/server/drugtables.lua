local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("weedtable", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('SYN-Caravan:Createtable', src)
    end
end)

QBCore.Functions.CreateUseableItem("methtable", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('SYN-Caravan:Createtable', src)
    end
end)

QBCore.Functions.CreateUseableItem("coketable", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('SYN-Caravan:Createtable', src)
    end
end)

QBCore.Functions.CreateUseableItem("heriontable", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('SYN-Caravan:Createtable', src)
    end
end)

RegisterNetEvent('SYN-Caravan:server:removeIngred', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.RemoveItem('weedleaf', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weedleaf"], "remove")
    end
end)

RegisterNetEvent('SYN-Caravan:server:addWeedBaggy', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.AddItem('weed_ogkush', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_ogkush"], "add")
    end
end)
