local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    exports['qb-target']:AddTargetModel("mw_sulfuric_barrel", {
        options = {
            {
                type = "client",
                event = "qb-zwavelzuur:pickSulfuric",
                icon = "fas fa-shield-virus",
                label = Lang:t("target.pickSulfuric"),
            },
        },
        distance = 4.0
    })
end)
