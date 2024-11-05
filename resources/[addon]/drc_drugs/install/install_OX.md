OX INSTALL QUIDE

1. Download all dependencies!
Dependencies:
	ox_lib | https://github.com/overextended/ox_lib
	es_extended / qb-core
	qtarget / qb-target
	memorygame | https://github.com/pushkart2/memorygame

2. Add Images to your inventory
	ox_inventory > web > build > images
	Paste images from folder images to ox_inventory > web > build > img

3. Add Items to your inventory
	ox_inventory > data> items.lua

	['trowel'] = {
		label = 'Trowel',
		description = "Perfect for your garden or for Coca plant",
		weight = 250,
		stack = true
	},

	['coke_leaf'] = {
		label = 'Coca Leaf',
		description = "Leaf from amazing plant",
		weight = 15,
		stack = true
	},

	['coke_access'] = {
		label = 'Access card',
		description = "Access Card for Coke Lab",
		weight = 50,
		stack = true
	},

	['coke_box'] = {
		label = 'Box with Coke',
		description = "Be careful not to spill it on the ground",
		weight = 2000,
		stack = true
	},

	['coke_raw'] = {
		label = 'Raw Coke',
		description = "Coke with some dirty particles",
		weight = 50,
		stack = true
	},

	['coke_pure'] = {
		label = 'Pure Coke',
		description = "Coke without any dirty particles",
		weight = 70,
		stack = true,
		close = true
	},

	['coke_figure'] = {
		label = 'Action Figure',
		description = "Action Figure of the cartoon superhero Impotent Rage",
		weight = 150,
		stack = true
	},

	['coke_figureempty'] = {
		label = 'Action Figure',
		description = "Action Figure of the cartoon superhero Impotent Rage",
		weight = 150,
		stack = true
	},

	['coke_figurebroken'] = {
		label = 'Pieces of Action Figure',
		description = "You can throw this away or try to repair with glue",
		weight = 100,
		stack = true
	},

	['meth_amoniak'] = {
		label = 'Ammonia',
		description = "Warning! Dangerous Chemicals!",
		weight = 1000,
		stack = true
	},

	['meth_pipe'] = {
		label = 'Meth Pipe',
		description = "Enjoy your new crystal clear stuff!",
		weight = 880,
		stack = true
	},

	['crack_pipe'] = {
		label = 'Crack Pipe',
		description = "Enjoy your Crack!",
		weight = 550,
		stack = true
	},

	['meth_syringe'] = {
		label = 'Syringe Meth',
		description = "Enjoy your new crystal clear stuff!",
		weight = 300,
		stack = true
	},

	['heroin_syringe'] = {
		label = 'Syringe Heroin',
		description = "Enjoy your new crystal clear stuff!",
		weight = 300,
		stack = true
	},

	['syringe'] = {
		label = 'Syringe',
		description = "Enjoy your new crystal clear stuff!",
		weight = 300,
		stack = true
	},

	['meth_sacid'] = {
		label = 'Sodium Benzoate Canister',
		description = "Warning! Dangerous Chemicals!",
		weight = 5000,
		stack = true
	},

	['meth_emptysacid'] = {
		label = 'Empty Canister',
		description = "Material: Plastic, Good for Sodium Benzoate",
		weight = 2000,
		stack = true
	},

	['meth_access'] = {
		label = 'Access card',
		description = "Access Card for Meth Lab",
		weight = 100,
		stack = true,
		close = true
	},

	['meth_glass'] = {
		label = 'Tray with meth',
		description = "Needs to be smashed with hammer",
		weight = 1000,
		stack = true
	},

	['meth_sharp'] = {
		label = 'Tray with smashed meth',
		description = "Can be packed",
		weight = 1000,
		stack = true
	},

	['meth_bag'] = {
		label = 'Meth bag',
		description = "Plastic bag with magic stuff!",
		weight = 1000,
		stack = true
	},

	['weed_package'] = {
		label = 'Weed Bag',
		description = "Plastic bag with magic stuff!",
		weight = 500,
		stack = true
	},

	['weed_access'] = {
		label = 'Access card',
		description = "Access Card for Weed Lab",
		weight = 100,
		stack = true
	},

	['weed_bud'] = {
		label = 'Weed Bud',
		description = "Needs to be clean at the table",
		weight = 40,
		stack = true
	},

	['weed_blunt'] = {
		label = 'Blunt',
		description = "Enjoy your weed!",
		weight = 90,
		stack = true,
		close = true
	},

	['weed_wrap'] = {
		label = 'Blunt wraps',
		description = "Get Weed Bag and roll blunt!",
		weight = 75,
		stack = true,
		close = true
	},

	['weed_papers'] = {
		label = 'Weed papers',
		description = "Get Weed Bag and roll joint!",
		weight = 15,
		stack = true,
		close = true
	},

	['weed_joint'] = {
		label = 'Joint',
		description = "Enjoy your weed!",
		weight = 50,
		stack = true,
		close = true
	},

	['weed_budclean'] = {
		label = 'Weed Bud',
		description = "You can pack this at the table",
		weight = 35,
		stack = true
	},

	['plastic_bag'] = {
		label = 'Plastic bag',
		description = "You can pack a lot of stuff here!",
		weight = 8,
		stack = true
	},

	['scissors'] = {
		label = 'Scissors',
		description = "To help you with collecting",
		weight = 40,
		stack = true
	},

	['ecstasy1'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['ecstasy2'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['ecstasy3'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['ecstasy4'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['ecstasy5'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd1'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd2'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd3'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd4'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd5'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['magicmushroom'] = {
		label = 'Mushroom',
		description = "Explore a new universe!",
		weight = 30,
		stack = true,
		close = true
	},

	['peyote'] = {
		label = 'Peyote',
		description = "Explore a new universe!",
		weight = 30,
		stack = true,
		close = true
	},

	['xanaxpack'] = {
		label = 'Pack of Xanax',
		description = "Needs to be open",
		weight = 130,
		stack = true,
		close = true
	},

	['xanaxplate'] = {
		label = 'Plate of Xanax',
		description = "Needs to be open",
		weight = 30,
		stack = true,
		close = true
	},

	['xanaxpill'] = {
		label = 'Xanax pill',
		description = "Explore a new universe!",
		weight = 2,
		stack = true,
		close = true
	},

    ['glue'] = {
		label = 'Glue',
		description = "Good for repairing things!",
		weight = 30,
		stack = true
	},

    ['hammer'] = {
		label = 'Hammer',
		description = "Good for smashing things!",
		weight = 500,
		stack = true
	},

	['poppyplant'] = {
		label = 'Poppy Plant',
		description = "Very nice plant!",
		weight = 30,
		stack = true
	},
	
	['heroin'] = {
		label = 'Heroin',
		description = "Explore a new universe!",
		weight = 30,
		stack = true
	},
	['crack'] = {
		label = 'Crack',
		description = "Explore a new universe!",
		weight = 30,
		stack = true
	},
	['baking_soda'] = {
		label = 'Baking Soda',
		description = "Baking Bad!",
		weight = 30,
		stack = true
	},

4. add ensure drc_drugs into your server.cfg (make sure to start it after ox_lib and your target system!)

5. Enjoy your new drugs script from DRC SCRIPTS!