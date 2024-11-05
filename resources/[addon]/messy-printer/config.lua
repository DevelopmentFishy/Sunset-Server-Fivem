Config = {}

Config.Inventory = 'qs' -- 'qb' = qb-inventory, 'qs' = qs-inventory
-- If using qb-inventory you don't need to add the printer_doc item
-- If you're using any other inventory you must add it to qb-core/shared/items.lua
--[[

['printer_doc']            = {["name"] = 'printer_doc',            ["label"] = 'Printed Document',    ["weight"] = 1,    ["type"] = "item",    ["image"] = 'printerdoc.png',                ["unique"] = true,    ["useable"] = true,        ["shouldClose"] = true,        ["combinable"] = false,   ["description"] = "It's a document"},

FOR OX_INVENTORY IT MUST BE ADDED LIKE THIS:
["printer_doc"] = {
		weight = 1,
		stack = false,
		close = true,
		consume = 0,
        label = "Printed Document",
		description = "Printed Document",
		client = {
			image = "printerdoc.png",
		},
		server = {
			export = 'messy-printer.printer_doc'
		},
	},

	ADD IMAGES TO QB-INVENTORY/HTML/IMAGES
	
	Join our Discord if you have any questions / need help! https://discord.gg/tg6g2hZgGg

    Add any printer model name or Hash you like to the list
]]--
Config.Printers = {-1025251070,
                "v_res_printer",
                "prop_printer_01",
                "prop_printer_02",
                "v_ret_gc_print",
                "v_med_cor_photocopy"
            }

--[[
    Cost per document printed
]]--
Config.CopyCost = 250

Config.PrintText = "Druk een document af"
Config.MenuHeaderText = "Maak copies"
Config.ErrorNotifyText = "Je kan dit niet printen..."
Config.ImgURLFieldText = "Afbeelding link"
Config.CopyQuantityText = "Nummer of copies"
Config.PrintSubmitText = "Print"
Config.NoFunds1 = 'Je hebt €'
Config.NoFunds2 = ' nodig om te printen...'

--[[
    If true will check that the image url comes from discord, If false it will still only allow images but the images can be from anywhere.
]]--
Config.DiscordOnly = true
