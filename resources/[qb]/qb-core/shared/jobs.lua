QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	unemployed = { label = 'Burger', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Freelancer', payment = 50 } } },
	bus = { label = 'BusChauffeur', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Chauffeur', payment = 50 } } },
	judge = { label = 'Rechter', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Rechter', payment = 50 } } },
	reporter = { label = 'Reporter', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Journalist', payment = 50 } } },
	trucker = { label = 'VrachtwagenChauffeur', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Chauffeur', payment = 50 } } },
	tow = { label = 'Takeldienst', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Chauffeur', payment = 50 } } },
	garbage = { label = 'Vuilnisman', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Ophaler', payment = 50 } } },
	vineyard = { label = 'Vineyard', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Picker', payment = 50 } } },
	hotdog = { label = 'Hotdog', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Sales', payment = 50 } } },
	security = { label = 'Security', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Security', payment = 50 } } },
	postop = { label = 'post-op', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Post Dienst', payment = 75 } } },
	bouwvakker = { label = 'bouw-vakker', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'De Bouw', payment = 75 } } },

	['casino'] = {
        label = 'Casino',
        defaultDuty = true,
        grades = {
            ['0'] = { name = 'Novice', payment = 50 },
            ['1'] = { name = 'Experienced', payment = 100 },
            ['2'] = { name = 'Boss', isboss = true, payment = 200 },
        },
    },


	lawyer = { 
		label = 'Advocaat', 
		defaultDuty = true, 
		offDutyPay = false, 
		grades = { 
			['0'] = { name = 'Counsel', payment = 700 },
			['1'] = { name = 'Associate', payment = 800 },
			['2'] = { name = 'Partner', isboss = true, payment = 900 },
			['3'] = { name = 'Vennoot', isboss = true, payment = 1000 }, 
		}, 
	},
	police = {
		label = 'Politie',
		type = 'leo',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['1'] = { name = 'Aspirant', payment = 500 },
			['2'] = { name = 'Agent', payment = 700 },
			['3'] = { name = 'Aspirant Inspecteur', payment = 750 },
			['4'] = { name = 'Inspecteur', payment = 800 },
			['5'] = { name = 'Aspirant Hoofdinspecteur', payment = 900 },
			['6'] = { name = 'Hoofdinspecteur', payment = 1000 },
			['7'] = { name = 'Aspirant commissaris', isboss = true, payment = 1100 },
			['8'] = { name = 'Commissaris', isboss = true, payment = 1100 },
			['9'] = { name = 'Hoofdcommissaris', isboss = true, payment = 1100 },
			['10'] = { name = 'Eerste Hoofdcommissaris', isboss = true, payment = 1100 },
		},
	},
	ambulance = {
		label = 'Ambulance',
		type = 'ems',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'OP in opleiding', payment = 600 },
			['1'] = { name = 'Ondersteunend Personeel', payment = 750 },
			['2'] = { name = 'Ambulance Verpleegkundige', payment = 850 },
			['3'] = { name = 'Ambulance Geneeskundige', payment = 1000 },
			['4'] = { name = 'Hoofd Geneeskunde', isboss = true, payment = 1100 },
		},
	},
	realestate = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Stagair', payment = 600 },
			['1'] = { name = 'Verkoper', payment = 650 },
			['2'] = { name = 'Hoofd Verkoper', payment = 700 },
			['3'] = { name = 'Ceo', payment = 750 },
			['4'] = { name = 'Manager', isboss = true, payment = 800 },
		},
	},
	taxi = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Driver', payment = 75 },
			['2'] = { name = 'Event Driver', payment = 100 },
			['3'] = { name = 'Sales', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	cardealer = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Stagair', payment = 600 },
			['1'] = { name = 'Verkoper', payment = 750 },
			['2'] = { name = 'Hoofdverkoper', payment = 850 },
			['3'] = { name = 'Partner', payment = 950 },
			['4'] = { name = 'Eigenaar', isboss = true, payment = 1000 },
		},
	},
	mechanic = {
		label = 'Fast Customs',
		type = 'mechanic',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Monteur in opleiding', payment = 600 },
			['1'] = { name = 'Monteur', payment = 800 },
			['2'] = { name = 'Hoofdmonteur', payment = 900 },
			['3'] = { name = 'Eigenaar', isboss = true, payment = 1000 },
		},
	},
	-- mechanic2 = {
	-- 	label = 'LS Customs',
	-- 	type = 'mechanic',
	-- 	defaultDuty = true,
	-- 	offDutyPay = false,
	-- 	grades = {
	-- 		['0'] = { name = 'Recruit', payment = 50 },
	-- 		['1'] = { name = 'Novice', payment = 75 },
	-- 		['2'] = { name = 'Experienced', payment = 100 },
	-- 		['3'] = { name = 'Advanced', payment = 125 },
	-- 		['4'] = { name = 'Manager', isboss = true, payment = 150 },
	-- 	},
	-- },
	-- mechanic3 = {
	-- 	label = 'LS Customs',
	-- 	type = 'mechanic',
	-- 	defaultDuty = true,
	-- 	offDutyPay = false,
	-- 	grades = {
	-- 		['0'] = { name = 'Recruit', payment = 50 },
	-- 		['1'] = { name = 'Novice', payment = 75 },
	-- 		['2'] = { name = 'Experienced', payment = 100 },
	-- 		['3'] = { name = 'Advanced', payment = 125 },
	-- 		['4'] = { name = 'Manager', isboss = true, payment = 150 },
	-- 	},
	-- },
	-- beeker = {
	-- 	label = 'Beeker\'s Garage',
	-- 	type = 'mechanic',
	-- 	defaultDuty = true,
	-- 	offDutyPay = false,
	-- 	grades = {
	-- 		['0'] = { name = 'Recruit', payment = 50 },
	-- 		['1'] = { name = 'Novice', payment = 75 },
	-- 		['2'] = { name = 'Experienced', payment = 100 },
	-- 		['3'] = { name = 'Advanced', payment = 125 },
	-- 		['4'] = { name = 'Manager', isboss = true, payment = 150 },
	-- 	},
	-- },
	['catcafe'] = {
		label = 'Cat Cafe',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Werknemer in opleiding', payment = 450 },
			['1'] = { name = 'Catcafe Werknemer', payment = 550 },
			['2'] = { name = 'Floor Manager', payment = 650 },
			['3'] = { name = 'Manager', payment = 750 },
			['4'] = { name = 'Ceo', isboss = true, payment = 900 },
        },
	},
    ["upnatoms"] = {
		label = "Up-N-Atoms Employee",
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Werknemer in opleiding",
                payment = 450
            },
			['1'] = {
                name = "Werknemer",
                payment = 550
            },
			['2'] = {
                name = "FloorManager",
                payment = 650
            },
			['3'] = {
                name = "Manager",
                payment = 750
            },
			['4'] = {
                name = "CEO",
				isboss = true,
                bankAuth = true,
                payment = 900
            },
        },
    },
	["wapendealer"] = {
		label = "wapen Verkoper",
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = {
                name = "Werknemer",
                payment = 100
            },
			['1'] = {
                name = "Eigenaar",
				isboss = true,
                payment = 100
            },
        },
    },
	bennys = {
		label = 'Benny\'s Original Motor Works',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
}
