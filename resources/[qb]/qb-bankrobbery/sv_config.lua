Config = Config or {}

--- This function gets triggered whenever one or more PowerStations have been hit
--- @param hits array
--- @return nil
function Config.OnPoliceCameraHit(hits)
    TriggerClientEvent("police:client:SetCamera", -1, hits, false)
end

--- This is called whenever a bank robbery is started, after a hack is done or a card is used, in this function you can do extra stuff after it has started
--- @param bankId number | string
--- @return nil
function Config.OnRobberyStart(bankId)
    local bankName = type(bankId) == "number" and "bankrobbery" or bankId
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', bankName, true)
    if bankName ~= "bankrobbery" then return end
    TriggerEvent('qb-banking:server:SetBankClosed', bankId, true)
end

--- This is called whenever a bank robbery's timeout has ended
--- @param bankId string | number
--- @return nil
function Config.OnRobberyTimeoutEnd(bankId)
    local bankName = type(bankId) == "number" and "bankrobbery" or bankId
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', bankName, false)
    if bankName ~= "bankrobbery" then return end
    TriggerEvent('qb-banking:server:SetBankClosed', bankId, false)
end

--- This will be called once a blackout starts or ends
--- @param isBlackout boolean
--- @return nil
function Config.OnBlackout(isBlackout)
    if isBlackout then
        TriggerClientEvent("police:client:DisableAllCameras", -1)
    else
        TriggerClientEvent("police:client:EnableAllCameras", -1)
    end
end

-- Config.HitsNeeded = 13 -- The amount of powerstation needed to be hit to cause a blackout
-- Config.BlackoutTimer = 10 -- The amount of minutes a blackout will take until all power comes back

Config.RewardTypes = {
    [1] = {
        type = "item"
    },
    [2] = {
        type = "money"
    }
}

Config.LockerRewards = {
    ["tier1"] = {
        [1] = {item = "goldbar", minAmount = 5, maxAmount = 10},
    },
    ["tier2"] = {
        [1] = {item = "goldbar", minAmount = 5, maxAmount = 10},
        [2] = {item = "geldrol", minAmount = 5000, maxAmount = 10000},
    },
    ["tier3"] = {
        [1] = {item = "security_card_02", minAmount = 1, maxAmount = 1},
        [2] = {item = "snsblauwprint", minAmount = 1, maxAmount = 1},
        [3] = {item = "geldrol", minAmount = 20000, maxAmount = 30000},
    },
}
Config.LockerRewardsPaleto = {
    ["tier1"] = {
        [1] = {item = "goldbar", minAmount = 5, maxAmount = 10},
        [2] = {item = "geldrol", minAmount = 30000, maxAmount = 50000},
        [3] = {item = "hacking_laptop", minAmount = 1, maxAmount = 1},
    },
    ["tier2"] = {
        [1] = {item = "goldbar", minAmount = 5, maxAmount = 10},
        [2] = {item = "security_card_02", minAmount = 1, maxAmount = 1},
        [3] = {item = "laptop_red", minAmount = 1, maxAmount = 1},
    },
    ["tier3"] = {
        [1] = {item = "bpcombatpistol", minAmount = 1, maxAmount = 1},
        [2] = {item = "geldrol", minAmount = 20000, maxAmount = 30000},
        [3] = {item = "geldrol", minAmount = 20000, maxAmount = 30000},
    },
}

Config.LockerRewardsPacific = {
    ["tier1"] = {
        [1] = {item = "goldbar", minAmount = 5, maxAmount = 10},
        [2] = {item = "bpheavypistol", minAmount = 1, maxAmount = 1},
    },
    ["tier2"] = {
        [1] = {item = "goldbar", minAmount = 5, maxAmount = 10},
        [2] = {item = "bpcombatpistol", minAmount = 1, maxAmount = 1},
        [3] = {item = "security_card_02", minAmount = 1, maxAmount = 1},
    },
    ["tier3"] = {
        [1] = {item = "bptec9", minAmount = 1, maxAmount = 1},
        [2] = {item = "bpdeagle", minAmount = 1, maxAmount = 1},
        [3] = {item = "bpheavypistol", minAmount = 1, maxAmount = 1},
        [4] = {item = "bpcompactrifle", minAmount = 1, maxAmount = 1},
    },
}

Config.CameraHits = {
    [1] = {
        type = {"police", "bank"},
        stationsToHitPolice = {1, 2, 3, 4, 5, 6},
        stationsToHitBank = {1, 2, 11}
    },
    [2] = {
        type = {"police", "bank"},
        stationsToHitPolice = {1, 2, 3, 4, 5, 6},
        stationsToHitBank = {1, 2, 11}
    },
    [3] = {
        type = {"police", "bank"},
        stationsToHitPolice = {1, 2, 3, 4, 5, 6},
        stationsToHitBank = {4, 5, 6, 8}
    },
    [4] = {
        type = {"police", "bank"},
        stationsToHitPolice = {4, 5, 6},
        stationsToHitBank = {12, 13}
    },
    [5] = {
        type = {"police", "bank"},
        stationsToHitPolice = {4, 5, 6},
        stationsToHitBank = {12, 13}
    },
    [6] = {
        type = "police",
        stationsToHitPolice = {4, 5, 6}
    },
    [7] = {
        type = "police",
        stationsToHitPolice = 3
    },
    [8] = {
        type = "police",
        stationsToHitPolice = {4, 5, 6}
    },
    [9] = {
        type = "police",
        stationsToHitPolice = {7, 8}
    },
    [10] = {
        type = "police",
        stationsToHitPolice = {7, 8}
    },
    [11] = {
        type = "police",
        stationsToHitPolice = 9
    },
    [12] = {
        type = "police",
        stationsToHitPolice = 9
    },
    [13] = {
        type = "police",
        stationsToHitPolice = 9
    },
    [14] = {
        type = "police",
        stationsToHitPolice = {9, 10}
    },
    [15] = {
        type = "police",
        stationsToHitPolice = {7, 9, 10}
    },
    [16] = {
        type = "police",
        stationsToHitPolice = {7, 9, 10}
    },
    [17] = {
        type = "police",
        stationsToHitPolice = {9, 10}
    },
    [18] = {
        type = "police",
        stationsToHitPolice = 3
    },
    [19] = {
        type = "police",
        stationsToHitPolice = {{1, 2, 3}, {9, 10}}
    },
    [20] = {
        type = "police",
        stationsToHitPolice = 10
    },
    [21] = {
        type = "police",
        stationsToHitPolice = {1, 2, 11}
    },
    [22] = {
        type = "police",
        stationsToHitPolice = {1, 2, 11}
    },
    [23] = {
        type = "police",
        stationsToHitPolice = {4, 5, 6, 8}
    },
    [24] = {
        type = "police",
        stationsToHitPolice = {12, 13}
    },
    [25] = {
        type = "police",
        stationsToHitPolice = {12, 13}
    }
}
