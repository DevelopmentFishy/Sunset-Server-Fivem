QBCore.Functions.CreateUseableItem("recipe_collection", function(source, item)

    local _source = source
    TriggerClientEvent("eco_crafting:openNui", _source, "recipe_collection")
end)

QBCore.Functions.CreateUseableItem("labor_enhancer", function(source, item)

    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)

    if addLabor(xPlayer, 1000) then

        interface.server.notify(_source, Lang:t('labor_added'), 'success')
        xPlayer.Functions.RemoveItem('labor_enhancer', 1)
    else

        interface.server.notify(_source, Lang:t('not_possible'), 'error')
    end
end)

QBCore.Functions.CreateUseableItem("weaponry_enhancer", function(source, item)

    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)

    if addProficiency(xPlayer, 'weaponry', 1000) then

        interface.server.notify(_source, Lang:t('proficiency_added'), 'success')
        xPlayer.Functions.RemoveItem('weaponry_enhancer', 1)
    else

        interface.server.notify(_source, Lang:t('not_possible'), 'error')
    end
end)

QBCore.Functions.CreateUseableItem("portable_chemist", function(source, item)

    workstationAddRequest(source, item.name,
            {
                workstation = 'chemist',
                animation = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                    flag = 16
                },
                fx = {
                    dict = 'scr_bike_adversary',
                    name = 'scr_adversary_weap_glow',
                    offset = vector3(0, 0, 0.9),
                    loopedAtCoord = { 0.0, 0.0, 0.0, 1.0 },
                    loopedColour = { 1.0, 2.0, 2.0 },
                },
                object = {
                    model = 'bkr_prop_coke_table01a',
                    placeOnGround = false,
                    --offset = vector3(0, 0, 0)
                },
                actionDistance = 1.5,
                --requiredAcePermission = 'vip_silver',
            }
    )
end)

QBCore.Functions.CreateUseableItem("portable_chemist_drugs", function(source, item)

    workstationAddRequest(source, item.name,
            {
                workstation = 'chemist',
                animation = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                    flag = 16
                },
                fx = {
                    dict = 'scr_bike_adversary',
                    name = 'scr_adversary_weap_glow',
                    offset = vector3(0, 0, 0.9),
                    loopedAtCoord = { 0.0, 0.0, 0.0, 1.0 },
                    loopedColour = { 1.0, 2.0, 2.0 },
                },
                object = {
                    model = 'bkr_prop_coke_table01a',
                    placeOnGround = false,
                    --offset = vector3(0, 0, 0)
                },
                special = 'drugs',
                excluding = { 'police', 'sheriff', 'ambulance' },
                actionDistance = 1.5,
                --requiredAcePermission = 'vip_gold',
            }
    )
end)

QBCore.Functions.CreateUseableItem("portable_cooking_fireplace", function(source, item)

    workstationAddRequest(source, item.name,
            {
                workstation = 'cooking',
                animation = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                    flag = 16
                },
                fx = {
                    dict = 'core',
                    name = 'ent_amb_int_fireplace_sml',
                    offset = vector3(0, 0, 0.0),
                    loopedAtCoord = { 0.0, 0.0, 0.0, 3.0 },
                    loopedColour = { 1.0, 3.0, 0.0 },
                },
                object = {
                    model = 'h4_prop_h4_firepit_rocks_01a',
                    placeOnGround = false,
                    --offset = vector3(0, 0, -0.2)
                },
                special = 'campfire',
                actionDistance = 2.0,
            }
    )
end)

-- EXPORTS SAMPLE
-- exports['eco_crafting']:addLabor(xPlayer or _source, amount)
-- exports['eco_crafting']:removeLabor(xPlayer or _source, amount)

-- exports['eco_crafting']:addProficiency(xPlayer or _source, 'cooking', amount)
-- exports['eco_crafting']:removeProficiency(xPlayer or _source, 'weaponry', amount)

-- exports['eco_crafting']:getLabor(xPlayer or _source)
-- exports['eco_crafting']:getProficiency(xPlayer or _source)

-- exports['eco_crafting']:addPortableWorkstation(workstationData, usableItemName, ownerId)
-- exports['eco_crafting']:removePortableWorkstation(workstationId, requesterId)
-- exports['eco_crafting']:getPortableWorkstations()