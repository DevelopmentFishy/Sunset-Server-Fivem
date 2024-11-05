Config = {
	Debug = false,
	Lan = "en", -- change the language

	Menu = "ox",	-- "qb" or "ox"
	Notify = "qb",	-- "qb" or "ox"

	JobRoles = {
		--["Job Name"] = Minimum Grade,
		--["police"] = 3,
		--["judge"] = 0,
		--["lawyer"] = 0,
		["mechanic"] = 1,
	},

	CoreVehicles = false, -- Enable to add support for core_vheicles so mods and milages dont get reset

	UseCommand = true, -- Set "true" if you want to use "/" commands.
	Command = "setplate", -- The default command for changing plates "/setplate".
	ComRequireJob = true, -- Set "true" if you want the command to require a job role

	CharacterReq = false, -- Set "true" if you have issues with other scripts not working correctly after
							-- This limits the plates to 8 letters as other/older scripts may not support less than 8
							-- For example some garage/vehiclekey scripts may break when spawning a car because its retrieving the licence wrong

	UseItem = true, -- Set "true" if you want to use the plate item.
	ItemRequireJob = false, -- Set "true" if you want the item to require a job role
	ItemRemoval = true, -- Set "true" if you want the plate item to be removed on use.

	Filter = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ", -- Allowed letters/numbers. Symbols don't work
													-- Don't touch unless you wan't to limit certain letters
	BlacklistPhrases = {
		"JIMATHY",
	},
}

Loc = {}
QBCore = exports['qb-core']:GetCoreObject()