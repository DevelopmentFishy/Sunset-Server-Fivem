QBCORE INSTALL QUIDE

1. Download all dependencies!
    Dependencies:
    ox_lib | https://github.com/overextended/ox_lib
    es_extended / qb-core
    qtarget / qb-target
    memorygame | https://github.com/pushkart2/memorygame

2. Add Images to your inventory
    qb-inventory > html > images
    Paste images from folder images to qb-inventory > html > images 

3. Add Items to your inventory
    qb-core > shared.lua
    ["coke_box"] 		 	 	 	 = {["name"] = "coke_box",           			["label"] = "Box with Coke",	 		["weight"] = 2000, 		["type"] = "item", 		["image"] = "coke_box.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Be careful not to spill it on the ground"},
    ["trowel"] 		 	 	 	     = {["name"] = "trowel",           				["label"] = "Trowel", 					["weight"] = 250,		["type"] = "item", 		["image"] = "trowel.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Perfect for your garden or for Coca plant"},
    ["coke_leaf"] 		 	 	 	 = {["name"] = "coke_leaf",           			["label"] = "Coca leaves",	 		    ["weight"] = 15,		["type"] = "item", 		["image"] = "coca_leaf.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Leaf from amazing plant"},
    ["coke_access"] 			 	 = {["name"] = "coke_access", 				    ["label"] = "Access card", 			    ["weight"] = 50, 		["type"] = "item", 		["image"] = "coke_access.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Access Card for Coke Lab"},
    ["coke_raw"] 			 		 = {["name"] = "coke_raw", 					    ["label"] = "Raw Coke", 				["weight"] = 50,		["type"] = "item", 		["image"] = "coke_raw.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil, ["description"] = "Coke with some dirty particles"},
    ["coke_pure"] 			 		 = {["name"] = "coke_pure", 				    ["label"] = "Pure Coke", 				["weight"] = 70,		["type"] = "item", 		["image"] = "coke_pure.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil, ["description"] = "Coke without any dirty particles"},
    ["coke_figure"] 			 	 = {["name"] = "coke_figure", 				    ["label"] = "Action Figure", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "coke_figure.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Action Figure of the cartoon superhero Impotent Rage"},
    ["coke_figureempty"] 			 = {["name"] = "coke_figureempty", 			    ["label"] = "Action Figure", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "coke_figureempty.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Action Figure of the cartoon superhero Impotent Rage"},
    ["coke_figurebroken"] 			 = {["name"] = "coke_figurebroken", 			["label"] = "Pieces of Action Figure", 	["weight"] = 100, 		["type"] = "item", 		["image"] = "coke_figurebroken.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "You can throw this away or try to repair with glue"},
    ["meth_amoniak"] 			 	 = {["name"] = "meth_amoniak", 				    ["label"] = "Ammonia", 			        ["weight"] = 1000, 		["type"] = "item", 		["image"] = "meth_amoniak.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Warning! Dangerous Chemicals!"},
    ["meth_pipe"] 			 	     = {["name"] = "meth_pipe", 				    ["label"] = "Meth Pipe", 			    ["weight"] = 880, 		["type"] = "item", 		["image"] = "meth_pipe.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Enjoy your new crystal clear stuff!"},
    ["crack_pipe"] 			 	     = {["name"] = "crack_pipe", 				    ["label"] = "Crack Pipe", 			    ["weight"] = 550, 		["type"] = "item", 		["image"] = "crack_pipe.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Enjoy your Crack!"},
    ["syringe"] 			 	     = {["name"] = "syringe", 				        ["label"] = "Syringe", 			        ["weight"] = 300, 		["type"] = "item", 		["image"] = "syringe.png", 		        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Enjoy your new crystal clear stuff!"},
    ["meth_syringe"] 			 	 = {["name"] = "meth_syringe", 				    ["label"] = "Syringe", 			        ["weight"] = 320, 		["type"] = "item", 		["image"] = "meth_syringe.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Enjoy your new crystal clear stuff!"},
    ["heroin_syringe"] 			 	 = {["name"] = "heroin_syringe", 				["label"] = "Syringe", 			        ["weight"] = 320, 		["type"] = "item", 		["image"] = "heroin_syringe.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Enjoy your new crystal clear stuff!"},
    ["meth_sacid"] 			    	 = {["name"] = "meth_sacid", 				    ["label"] = "Sodium Benzoate Canister", ["weight"] = 5000, 		["type"] = "item", 		["image"] = "meth_sacid.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Warning! Dangerous Chemicals!"},
    ["meth_emptysacid"] 			 = {["name"] = "meth_emptysacid", 				["label"] = "Empty Canister", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "meth_emptysacid.png", 	    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Material: Plastic, Good for Sodium Benzoate"},
    ["meth_access"] 		 	 	 = {["name"] = "meth_access",           		["label"] = "Access Card", 		        ["weight"] = 50,		["type"] = "item", 		["image"] = "meth_access.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Access Card for Meth Lab"},
    ["meth_glass"] 		 	 	 	 = {["name"] = "meth_glass",           			["label"] = "Tray with meth",           ["weight"] = 1000,		["type"] = "item", 		["image"] = "meth_glass.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Needs to be smashed with hammer"},
    ["meth_sharp"] 		 	 	 	 = {["name"] = "meth_sharp",           			["label"] = "Tray with smashed meth", 	["weight"] = 1000,		["type"] = "item", 		["image"] = "meth_sharp.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Can be packed"},
    ["meth_bag"] 		 	 	 	 = {["name"] = "meth_bag",           			["label"] = "Meth Bag", 				["weight"] = 1000,		["type"] = "item", 		["image"] = "meth_bag.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Plastic bag with magic stuff!"},
    ["weed_package"] 		 	 	 = {["name"] = "weed_package",           		["label"] = "Weed Bag", 			    ["weight"] = 500,		["type"] = "item", 		["image"] = "weed_package.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Plastic bag with magic stuff!"},
    ["weed_access"] 		 	 	 = {["name"] = "weed_access",           		["label"] = "Access Card", 		        ["weight"] = 50,		["type"] = "item", 		["image"] = "weed_access.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Access Card for Weed Lab"},
    ["weed_bud"] 		 	 	 	 = {["name"] = "weed_bud",           			["label"] = "Weed Bud",	 		        ["weight"] = 40, 		["type"] = "item", 		["image"] = "weed_bud.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Needs to be clean at the table"},
    ["weed_blunt"] 		 	 	 	 = {["name"] = "weed_blunt",           			["label"] = "Blunt",	 		        ["weight"] = 90, 		["type"] = "item", 		["image"] = "weed_blunt.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Enjoy your weed!"},
    ["weed_wrap"] 		 	 	 	 = {["name"] = "weed_wrap",           			["label"] = "Blunt Wraps",	 		    ["weight"] = 75, 		["type"] = "item", 		["image"] = "weed_wrap.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Get Weed Bag and roll blunt!"},
    ["weed_papers"] 		 	 	 = {["name"] = "weed_papers",           		["label"] = "Weed Papers",	 		    ["weight"] = 15, 		["type"] = "item", 		["image"] = "weed_papers.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Get Weed Bag and roll joint!"},
    ["weed_joint"] 		 	 	 	 = {["name"] = "weed_joint",           			["label"] = "Joint",	 		        ["weight"] = 50, 		["type"] = "item", 		["image"] = "weed_joint.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Enjoy your weed!"},
    ["weed_budclean"] 			 	 = {["name"] = "weed_budclean", 				["label"] = "Weed Bud", 			    ["weight"] = 35, 		["type"] = "item", 		["image"] = "weed_budclean.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "You can pack this at the table"},
    ["plastic_bag"] 			     = {["name"] = "plastic_bag", 				    ["label"] = "Plastic Bag", 			    ["weight"] = 8, 		["type"] = "item", 		["image"] = "plastic_bag.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "You can pack a lot of stuff here!"},
    ["scissors"] 		        	 = {["name"] = "scissors", 				        ["label"] = "Scissors", 			    ["weight"] = 40, 		["type"] = "item", 		["image"] = "scissors.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "To help you with collecting"},
    ["ecstasy1"] 			         = {["name"] = "ecstasy1", 				        ["label"] = "Ectasy", 			        ["weight"] = 10, 		["type"] = "item", 		["image"] = "ecstasy1.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["ecstasy2"] 			         = {["name"] = "ecstasy2", 				        ["label"] = "Ectasy", 			        ["weight"] = 10, 		["type"] = "item", 		["image"] = "ecstasy2.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["ecstasy3"] 			         = {["name"] = "ecstasy3", 				        ["label"] = "Ectasy", 			        ["weight"] = 10, 		["type"] = "item", 		["image"] = "ecstasy3.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["ecstasy4"] 			         = {["name"] = "ecstasy4", 				        ["label"] = "Ectasy", 			        ["weight"] = 10, 		["type"] = "item", 		["image"] = "ecstasy4.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["ecstasy5"] 			         = {["name"] = "ecstasy5", 				        ["label"] = "Ectasy", 			        ["weight"] = 10, 		["type"] = "item", 		["image"] = "ecstasy5.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["lsd1"] 			             = {["name"] = "lsd1", 				            ["label"] = "LSD", 			            ["weight"] = 10, 		["type"] = "item", 		["image"] = "lsd1.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["lsd2"] 			             = {["name"] = "lsd2", 				            ["label"] = "LSD", 			            ["weight"] = 10, 		["type"] = "item", 		["image"] = "lsd2.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["lsd3"] 			             = {["name"] = "lsd3", 				            ["label"] = "LSD", 			            ["weight"] = 10, 		["type"] = "item", 		["image"] = "lsd3.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["lsd4"] 		 	 	 	     = {["name"] = "lsd4",           		     	["label"] = "LSD",	 		            ["weight"] = 10, 		["type"] = "item", 		["image"] = "lsd4.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["lsd5"] 		 	 	 	     = {["name"] = "lsd5",           				["label"] = "LSD", 					    ["weight"] = 10,		["type"] = "item", 		["image"] = "lsd5.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["magicmushroom"] 		 	 	 = {["name"] = "magicmushroom",           		["label"] = "Magic Mushroom",	 		["weight"] = 30,		["type"] = "item", 		["image"] = "magicmushroom.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["peyote"] 			 	         = {["name"] = "peyote", 				        ["label"] = "Peyote", 			        ["weight"] = 30, 		["type"] = "item", 		["image"] = "peyote.png", 			    ["unique"] = false,  	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["xanaxpack"] 			 		 = {["name"] = "xanaxpack", 					["label"] = "Xanax Pack", 				["weight"] = 130,		["type"] = "item", 		["image"] = "xanaxpack.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["xanaxplate"] 		 	 	 	 = {["name"] = "xanaxplate",           			["label"] = "Xanax Plate",	 		    ["weight"] = 30, 		["type"] = "item", 		["image"] = "xanaxplate.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["xanaxpill"] 		 	 	 	 = {["name"] = "xanaxpill",           			["label"] = "Xanax Pill", 				["weight"] = 2,		    ["type"] = "item", 		["image"] = "xanaxpill.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["glue"] 		 	 	         = {["name"] = "glue",           			    ["label"] = "Glue",	 		            ["weight"] = 30,		["type"] = "item", 		["image"] = "glue.png", 			    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Good for repairing things!"},
    ["hammer"] 			        	 = {["name"] = "hammer", 				        ["label"] = "Hammer", 			        ["weight"] = 500, 		["type"] = "item", 		["image"] = "hammer.png", 			    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Good for smashing things!"},
    ["poppyplant"] 			         = {["name"] = "poppyplant", 				    ["label"] = "Poppy Plant", 			    ["weight"] = 30, 		["type"] = "item", 		["image"] = "poppyplant.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Very nice plant!"},
    ["heroin"] 			             = {["name"] = "heroin", 				        ["label"] = "Heroin", 			        ["weight"] = 30, 		["type"] = "item", 		["image"] = "heroin.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["crack"] 			             = {["name"] = "crack", 				        ["label"] = "Crack", 			        ["weight"] = 30, 		["type"] = "item", 		["image"] = "crack.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Explore a new universe!"},
    ["baking_soda"] 			     = {["name"] = "baking_soda", 				    ["label"] = "Baking Soda", 			    ["weight"] = 30, 		["type"] = "item", 		["image"] = "baking_soda.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Baking Bad!"},

4. Remove this teleport in qb-smallresources
    Can be found in config.lua line 122 - 134 (Config.Teleports)
    Remove this code:

    --Coke Processing Enter/Exit
    [2] = {
        [1] = {
            coords = vector4(909.49, -1589.22, 30.51, 92.24),
            ["AllowVehicle"] = false,
            drawText = '[E] Enter Coke Processing'
        },
        [2] = {
            coords = vector4(1088.81, -3187.57, -38.99, 181.7),
            ["AllowVehicle"] = false,
            drawText = '[E] Leave'
        },
    },

5. add ensure drc_drugs into your server.cfg (make sure to start it after ox_lib and your target system!)

6. Enjoy your new drugs script from DRC SCRIPTS!