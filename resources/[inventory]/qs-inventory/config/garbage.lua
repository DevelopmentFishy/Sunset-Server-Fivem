--[[
    Welcome to the Garbages setting!
    In this configuration you will find everything related
    to garbage cans and their items, since a random one will
    appear from the list that you will see below.

    Config.GarbageObjects is simply for target use, so if
    you don't use it, you can ignore it.
]]

Config.GarbageItems = {}

Config.GarbageObjects = {
    'prop_dumpster_02a',
    'prop_dumpster_4b',
    'prop_dumpster_4a',
    'prop_dumpster_3a',
    'prop_dumpster_02b',
    'prop_dumpster_01a'
}

Config.GarbageItemsForProp = {
    [joaat('prop_dumpster_02a')] = {
        label = 'Garbage',
        slots = 30,
        items = {
            [1] = {
                [1] = {
                    name = 'plastic_cup',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 2,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'stof',
                    amount = {
                        min = 3,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
            [2] = {
                [1] = {
                    name = 'plastic',
                    amount = {
                        min = 4,
                        max = 8
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'metalscrap',
                    amount = {
                        min = 2,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
            },
            [3] = {
                [1] = {
                    name = 'pillen',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 1,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
            },
            [4] = {
                [1] = {
                    name = 'gameconsole',
                    amount = {
                        min = 1,
                        max = 1
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'geldrol',
                    amount = {
                        min = 50,
                        max = 100
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
            },
            [5] = {
                [1] = {
                    name = 'burgerd',
                    amount = {
                        min = 1,
                        max = 10
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
            },
            [6] = {
                [1] = {
                    name = 'leegblik1',
                    amount = {
                        min = 1,
                        max = 10
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'geldrol',
                    amount = {
                        min = 50,
                        max = 100
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
            },
            [7] = {
                [1] = {
                    name = 'burnerphone',
                    amount = {
                        min = 1,
                        max = 1
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'bottle',
                    amount = {
                        min = 5,
                        max = 10
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
            },
            [8] = {
                [1] = {
                    name = 'burnerphone_wep',
                    amount = {
                        min = 1,
                        max = 1
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'lockpick',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
            },
        }
    },
    [joaat('prop_dumpster_4b')] = {
        label = 'Garbage',
        slots = 30,
        items = {
            [1] = {
                [1] = {
                    name = 'plastic_cup',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 2,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'stof',
                    amount = {
                        min = 3,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
            [2] = {
                [1] = {
                    name = 'pillen',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 1,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'koperdraad',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
        }
    },
    [joaat('prop_dumpster_4a')] = {
        label = 'Garbage',
        slots = 30,
        items = {
            [1] = {
                [1] = {
                    name = 'plastic_cup',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 2,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'stof',
                    amount = {
                        min = 3,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
            [2] = {
                [1] = {
                    name = 'pillen',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 1,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'koperdraad',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
        }
    },
    [joaat('prop_dumpster_3a')] = {
        label = 'Garbage',
        slots = 30,
        items = {
            [1] = {
                [1] = {
                    name = 'plastic_cup',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 2,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'stof',
                    amount = {
                        min = 3,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
            [2] = {
                [1] = {
                    name = 'pillen',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 1,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'koperdraad',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
        }
    },
    [joaat('prop_dumpster_02b')] = {
        label = 'Garbage',
        slots = 30,
        items = {
            [1] = {
                [1] = {
                    name = 'plastic_cup',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 2,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'stof',
                    amount = {
                        min = 3,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
            [2] = {
                [1] = {
                    name = 'pillen',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 1,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'koperdraad',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
        }
    },
    [joaat('prop_dumpster_01a')] = {
        label = 'Garbage',
        slots = 30,
        items = {
            [1] = {
                [1] = {
                    name = 'plastic_cup',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 2,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'stof',
                    amount = {
                        min = 3,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
            [2] = {
                [1] = {
                    name = 'pillen',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 1,
                },
                [2] = {
                    name = 'weed_skunk_seed',
                    amount = {
                        min = 1,
                        max = 5
                    },
                    info = {},
                    type = 'item',
                    slot = 2,
                },
                [3] = {
                    name = 'koperdraad',
                    amount = {
                        min = 1,
                        max = 2
                    },
                    info = {},
                    type = 'item',
                    slot = 3,
                },
            },
        }
    },
}
