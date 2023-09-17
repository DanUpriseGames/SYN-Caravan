local QBCore = exports['qb-core']:GetCoreObject()

-- Target to Enter Caravan
Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.Vehicle, {
        options = {
            {
                type = "client",
                event = "SYN-Caravan:client:OpenMenu",
                icon = "far fa-eye",
                label = "Enter Caravan",
                targeticon = "far fa-eye",
            }
        },
        distance = Config.Distance,
    })
end)

-- Target to Leave Caravan
Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("caravan_exit", vector3(-368.22, -237.1, 29.65), 1.3, 1.3, {
        name = "caravan_exit",
        heading = 187.13,
        debugPoly = false,
        minZ = 25.651517868042,
        maxZ = 35.029516220092,
    }, {
        options = {
            {  
            event = "instance:teleportBackAndShow",
            icon = "far fa-eye",
            label = "Leave Caravan",
            },
        },
        distance = Config.Distance,
    })
end)

-- Target to Leave Caravan
Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("caravan_clothing", vector3(-372.76, -236.69, 29.65), 1.3, 1.3, {
        name = "caravan_clothing",
        heading = 90.95,
        debugPoly = true,
        minZ = 25.651517868042,
        maxZ = 35.029516220092,
    }, {
        options = {
            {  
            event = "instance:teleportBackAndShow",
            icon = "far fa-eye",  
            label = "Enter Wardroabe",
            },
        },
        distance = Config.Distance,
    })
end)

-- Target to Leave Caravan
Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("caravan_storage", vector3(-370.98, -237.19, 29.65), 1.1, 1.1, {
        name = "caravan_storage",
        heading = 187.13,
        debugPoly = true,
        minZ = 25.651517868042,
        maxZ = 35.029516220092,
    }, {
        options = {
            {  
            event = "SYN-Caravan:Storage",
            icon = "far fa-eye",
            label = "Enter Storage",
            },
        },
        distance = Config.Distance,
    })
end)

Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.Weedplants, {
        options = {
            {
                type = "server",
                event = "pickedUpCannabis",
                icon = "far fa-eye",
                label = "Harvest Buds",
                targeticon = "far fa-eye",
            }
        },
        distance = Config.Distance,
    })
end)

-- Weed Tables
Citizen.CreateThread(function()
    Wait(200)
    local models = {
        Config.WeedTables,
    }

    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                num = 1,
                type = "client",
                event = "SYN-Caravan:MakeWeedBaggy",
                icon = 'fas fa-cannabis',
                label = 'Lets Cook!',
            },
            {
                num = 2,
                type = "client",
                event = "SYN-Caravan:DeleteTable",
                icon = 'fas fa-hand',
                label = 'Pickup Table',
            },
        },
        distance = Config.Distance,
    })
end)

