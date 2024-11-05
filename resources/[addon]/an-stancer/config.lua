return {
    shared = {
        Qbcore = true -- if Qb set to true, false for ESX
    },
    utils = {
        drawtext = function (text, type)
            if type == "show" then
                lib.showTextUI(text)
            else
                lib.hideTextUI()
            end
        end,
        Notify = function (msg, type, duration)
            lib.notify({
                description = msg,
                type = type,
                duration = duration
            })
        end
    },
    client = {
        FixedCamera = true,
        StanceLocations = {
            {
                coords = vec3(-885.02, -785.84, 15.33),
                size = 3.0,
                debug = false,
                job = "mechanic",
                drawtext = {
                    inveh = "Druk E om de stancer te openen",
                    outveh = "Je moet in een voertuig zitten!"
                }

            }
        },
        progressbar = "ox" --- qb / ox / refine-radialbar
    },
    server = {
        Mysql = "oxmysql"
    }
}
