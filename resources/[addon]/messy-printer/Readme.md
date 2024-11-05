#INSTALLATION

#Drop messy-printer into your resources folder
#add ensure messy-printer to your server.cfg

#Add image to [qb]/qb-inventory/html/images 

#If using qb-inventory you don't need to add the printer_doc item
#If you're using any other inventory you must add it to qb-core/shared/items.lua

['printer_doc']            = {["name"] = 'printer_doc',            ["label"] = 'Printed Document',    ["weight"] = 1,    ["type"] = "item",    ["image"] = 'printerdoc.png',                ["unique"] = true,    ["useable"] = true,        ["shouldClose"] = true,        ["combinable"] = false,   ["description"] = "It's a document"},

#FOR OX_INVENTORY IT MUST BE ADDED LIKE THIS:
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
	
#Adjust CONFIG.LUA to suit your needs

#Join our Discord if you have any questions / need help! https://discord.gg/tg6g2hZgGg

#Enjoy!
