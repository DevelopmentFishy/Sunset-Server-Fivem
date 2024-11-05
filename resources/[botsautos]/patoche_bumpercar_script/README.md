# Update 29/03/2023

ESX USERS CONFIG: added an option to enable/disable the CanCarry check

Fix:
  Fix an issue where users can buy an bumpton without loose any money.

# Car Bumper script Installation

required at least server build 5904
required at least game build 2699
required onesync

Only work with ESX-LEGACY (tested on 1.6.5) and QBCore or it will run at standalone

The script have been enterly remake for more optimisation.
Auto Framework detection (ony ESX-Legacy and QBCore are supported, if you don't have it the script will use standalone version, thats mean you don't need to buy bumpon for the rent.)
A menu for change the entity set have been added.
A menu for buying bumpton have been make for framework ESX-Legacy and QBCore only ( We will not give any support if you have editing one of this framework, be sure to use the last update of these framework ).
Vehicles spawn server side, be sure to enable onesync to make it work.
When you rent a bumpercar a timer has been added on the bottom of the screen to see the time remaining of your session.
If you leave the vehicle before the end of the session the timer continue, thats mean if you rent a vehicle and leave an other player can take your place, the timer will be synced when the new player enter in the vehicle.
Add a stateBag for vehicle keys : 
  Entity(vehicle).state.ignoreLocks = true
  for qb-vehicleKeys this stateBag is used for blacklist the vehicle from the keys system.
  if you have another vehicle keys system you can use this stateBag to blacklist the vehicle.

The config file placed in the shared folder contains some usefull stuffs for server owner
for exemple: 
  Config.debug = true 
  Show multiple print to see where the script got an issue.

For ESX and QBCore users, the support of ox_inventories has been added.

You have an folder named locales for translate all the menu/notification.
To make a new translate simply create a new file inside the folder locales.
for exemple:
  inside the shared/config.lua change the Config.locale = "en" to Config.locale = "fr".
  Create a new file named fr.json inside the locales folder and copy the content of en.json.

## Items

- If you are using ESX just import the items.sql inside your database
- If you are using QBCore you need to go inside "qb-core/server/shared/items.lua" and add this line inside the file.
- Drop the bumpton.png inside your inventory ressource exemple : "qb-inventory\html\images\bumpton.png"

```
['bumpton'] 			 		 = {['name'] = 'bumpton', 						['label'] = 'Bumpton', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'bumpton.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,  ['description'] = 'A jeton to drive a Bumper Car, Bonk!'},
```


- If you use standalone version you don't need to add nothing.

## Additional Notes

Need further support? Join our [Discord](https://discord.com/invite/NvrTRdh)!
