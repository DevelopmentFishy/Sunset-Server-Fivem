-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local Players = {}

-- Handlers

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- Menus

RegisterNetEvent('r14-obj:client:musicplayer', function(data)
    local exists, volume, playing, paused = exports['xsound']:soundExists(data.objectId)
    local hdr = '⏸️ | Pause Music'

    if exists then 
        volume = math.floor(exports['xsound']:getVolume(data.objectId) * 1000)
        playing = exports['xsound']:isPlaying(data.objectId)
        paused = exports['xsound']:isPaused(data.objectId)
    end

    if paused then hdr = '▶️ | Resume Music' end

    if not Players[data.objectId] then 
        TriggerServerEvent('r14-obj:server:syncplayer', data.objectId, volume)
        Wait(100)
        while not Players[data.objectId] do
            Wait(10)
        end
    end    

    local musicMenu = {
        {
            header = ('📻 %s'):format(data.name),
            isMenuHeader = true,
        }
    }
    
    musicMenu[#musicMenu+1] = {
        header = '🎶 | Play a Song',
        params = {
            event = 'r14-obj:client:selectmusic',
            args = {
                objectId = data.objectId,
                coords = data.coords,
                name = data.name,
                volume = Players[data.objectId],
            }
        }
    }

    musicMenu[#musicMenu+1] = {
        header = hdr,
        params = {
            isServer = true,
            event = 'r14-obj:server:playpause',
            args = {
                objectId = data.objectId,
                coords = data.coords,
                name = data.name,
                paused = paused,
                playing = playing,
            }
        }
    }

    if Players[data.objectId] then
        volume = Players[data.objectId]
    end

    musicMenu[#musicMenu+1] = {
        header = ('🔊 | Use Volume Knob - %s%%'):format(math.floor(volume/10)),
        params = {
            event = 'r14-obj:client:selectvolume',
            args = {
                objectId = data.objectId,
                coords = data.coords,
                name = data.name,
                knob = true,
                exists = exists,
            }
        }
    }

    musicMenu[#musicMenu+1] = {
        header = '🔉 | Increase Volume',
        params = {
            isServer = true,
            event = 'r14-obj:server:changevolume',
            args = {
                objectId = data.objectId,
                coords = data.coords,
                name = data.name,
                increase = true,
                volume = Players[data.objectId],
                exists = exists,
            }
        }
    }

    musicMenu[#musicMenu+1] = {
        header = '🔈 | Decrease Volume',
        params = {
            isServer = true,
            event = 'r14-obj:server:changevolume',
            args = {
                objectId = data.objectId,
                coords = data.coords,
                name = data.name,
                volume = Players[data.objectId],
                exists = exists,
            }
        }
    }

    musicMenu[#musicMenu+1] = {
        header = ('❌ | Turn %s Off'):format(data.name),
        params = {
            isServer = true,
            event = 'r14-obj:server:stopmusic',
            args = {
                objectId = data.objectId,
                coords = data.coords,
                name = data.name,
                exists = exists,
            }
        }
    }

    musicMenu[#musicMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = 'qb-menu:client:closeMenu',
        }
    }

    print(json.encode(musicMenu))
    exports['qb-menu']:openMenu(musicMenu)
end)

-- Events

RegisterNetEvent('r14-obj:client:selectmusic', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Select Song',
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'song',
                text = 'YouTube URL'
            }
        }
    })
    if dialog then
        if not dialog.song then return end
        data.song = dialog.song
        TriggerServerEvent('r14-obj:server:playmusic', data)
    end
end)

RegisterNetEvent('r14-obj:client:selectvolume', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Set Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'volume',
                text = '0 - 100',
                set = true,
            }
        }
    })
    if dialog then
        if not dialog.volume then return end

        data.volume = dialog.volume * 10

        TriggerServerEvent('r14-obj:server:changevolume', data)
    end
end)

RegisterNetEvent('r14-obj:client:updateplayer', function(objectId, type, volume)
    if type == 'update' then Players[objectId] = volume end
    if type == 'destroy' then Players[objectId] = nil end
end)
