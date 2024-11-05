# Dependencies 
- QBCore (latest)
- qb-target https://github.com/qbcore-framework/qb-target
- ps-ui https://github.com/Project-Sloth/ps-ui
- ps-dispatch https://github.com/Project-Sloth/ps-dispatch
- ox_lib https://overextended.github.io/docs/ox_lib/
- glow minigame https://github.com/christikat/glow_minigames

# Ps-Dispatch

* Add the following to client > alerts.lua
```lua
local function BankTrucks()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('banktrucks'),
        codeName = 'banktrucks',
        code = '10-90',
        icon = 'fas fa-truck-front',
        priority = 2,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        jobs = { 'leo', 'police', 'swat', 'bcso',}
    }

    TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
end
exports('BankTrucks', BankTrucks)
```

* Add the following to locales > en.json etc (depends on what language you use)
```lua
	"banktrucks": 'Fleeca Truck Robbery',
```

* Paste the following in ps-dispatch > shared > config.lua
```lua
    ['banktrucks'] = {
        radius = 0,
        sprite = 66,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false
    },
```
------------------------------------------------------------------------------------

* Add the images from the images file into your inventory html images
* Add the below lines into your qb-core>shared>item.lua at the bottom
```lua
['hacking-laptop'] 			     		 = {['name'] = 'hacking-laptop',				    		['label'] = 'Hacking Laptop',			   			['weight'] = 1500,    	['type'] = 'item',		['image'] = 'hacking-laptop.png',         			['unique'] = true,		['useable'] = true,	    ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = '',								['created'] = nil, 		['decay'] = 1.0 },
	['gps-device'] 			     		 = {['name'] = 'gps-device',				    		['label'] = 'Gps Device',			   			['weight'] = 1500,    	['type'] = 'item',		['image'] = 'gps-device.png',         			['unique'] = true,		['useable'] = true,	    ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = '',								['created'] = nil, 		['decay'] = 1.0 },
    
    	['kthermite'] 			 		 = {['name'] = 'kthermite',						['label'] = 'Thermite',					['weight'] = 500,    	['type'] = 'item',		['image'] = 'thermite.png',         		['unique'] = true,		['useable'] = true,	    ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = '',				['created'] = nil, 		['decay'] = 1.0 },

```

# Go to [qb] > qb-smallresources > server > logs.lua and  the following snippet in the local Webhooks

```lua
['banktrucks'] = 'put your discord channel webhook here',
```

* If you are unsure how to get a webhook this link can help you https://docs.gitlab.com/ee/user/project/integrations/discord_notifications.html