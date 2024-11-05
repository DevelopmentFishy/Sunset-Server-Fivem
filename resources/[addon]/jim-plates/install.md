Thank you for your purchase <3 I hope you have fun with this script and that it brings jobs and RP to your server

If you need support I now have a discord available, it helps me keep track of issues and give better support.

https://discord.gg/xKgQZ6wZvS

-------------------------------------------------------------------------------------------------
# Info and Troubleshooting
This script was built around qb-garages and a recent version of qb-core
This script has also been tested with cd_garage and works as intended

The way this script works is that it essentially changes the owner(citizenID) of the vehicle in the player_vehicles database
The trunk and glovebox stashes are then renamed to match the new plate of the vehicle

Sometimes there are issues with other/older scripts
Setting Config.CharacterReq to true limits the plates to 8 characters and stops issues

This information is taken from my discord:

This is an awkward one and I hate to pass the blame.
When the plates are changed, they change in the database and then change the physical plates of the car.

If you have a plate with less than 8 letters on this can cause issues with other scripts as when scripts get plate info it sees it as: `__TEST__`

When needs to be done is an event needs to be added above the function that is being called and failing to get the correct plate:
```lua
function trim(value)
    if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end
```

Then in the event where it "most likely" says GetNumberPlateText(plate)
This needs to be changed to trim(GetNumberPlateText(plate))

This will then trim the spaces from the text it retrieves making it `TEST` instead of `__TEST__`

-------------------------------------------------------------------------------------------------

# Installation

## Inventory images

Add the item images to your inventory script

`[qb]` > `qb-inventory` > `html` > `images`

## Items.lua

Under the QBShared.Items = {
```lua
	["newplate"] = {["name"] = "newplate", ["label"] = "New Plate", ["weight"] = 200, ["type"] = "item", ["image"] = "plate.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
```
-------------------------------------------------------------------------------------------------

## Changelog

### v1.5
	- Fix checking for wrong script version
	- Fix not updating the vehicle mods in the database, breaking some garages when spawning later

### v1.4
	- Tidy up and minor fixes
	- Optimize script to use less memory
	- Added shared file
	- Added blacklisted phrases check
	- Added support for `ox_lib` input

### v1.3.9
	- Added `break` to fix server error when trying to find citizenid info

### v1.3.8
	- Minor update to help with debugging random issues with grabbing citizen id

### v1.3.7
	- Added support for `core_vehicles`
	- Update SQL events to `MySQL.update` cutting several database two database calls to one

### v1.3.6
	- Updated install.md
	- Fixed and updated locale
	- Don't allow changing parked cars with jim-parking as it breaks both scripts
	- Fix being unable to change plates of cars under 8 letters

### v1.3.5
    - Locale support thanks to Dafke

### v1.3.4
	- Spaces in the plate text should now be doable, for example UK plates styles `AA11 AAA`
	- Fix for errors when trying to remove the plate item

### v1.3.3
	- QBCore Item updates

### v1.3.2
	- Fix for the item being removed from every player that has one
	- Added Config option to stop plates being under 8 letters, keep plates 8 letters stops the issues with other scripts

### v1.3.1
	- Fix the vehicle properties being updated by everyone in the server at once and breaking it

### v1.3
	- Fix notifying every player of plate changes
	- Add QB-Log support for completed plate change

### v1.2
	- Add debug mode + Debug Messages
	- Fix the plates not updating correctly for other players

### v1.1
	- Refactor/Update code
	- Added install.md for changelog and item.lua info
	- Letters `whitelist` filter is now in the config
	- /setplate changes
		- Change `setplate` command in the config
		- Enable or disable the /command
	- Added `newplate` item
		- Config option to change if it requires a job role to be used
		- Config option to change if it is removed on change
	- Optimized loading of database info
