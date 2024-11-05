--[[
    Here you have the configuration of stashes, you can modify it or even
    create your own! In case your inventory is not here, you can ask the
    creator to create a file following this example and add it!
]]

if Config.Inventory ~= 'qs-inventory' then
    return
end

function HousingStash(id, other, mlo)
    if mlo then -- For MLO stashes
        local others = {}
        others.maxweight = 50000000
        others.slots = 500
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'Housing_' .. id, others)
        TriggerEvent('inventory:client:SetCurrentStash', 'Housing_' .. id)
    else -- For IPL and Shell stashes
        local others = {}
        others.maxweight = other.weight
        others.slots = other.slots
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'Housing_' .. id, others)
        TriggerEvent('inventory:client:SetCurrentStash', 'Housing_' .. id)
    end
end

--[[
    Furniture stash system, choose your own weight and slots!
]]
ObjectStash = {
    [`apa_mp_h_str_sideboardl_06`] = { weight = 50000000, slots = 250 },
    [`apa_mp_h_str_sideboardm_03`] = { weight = 50000000, slots = 250 },
    [`apa_mp_h_str_sideboardl_09`] = { weight = 50000000, slots = 250 },
    [`ex_prop_ex_toolchest_01`] = { weight = 50000000, slots = 250 },
    [`gr_prop_gr_tool_chest_01a`] = { weight = 50000000, slots = 250 },
    [`gr_prop_gr_tool_draw_01a`] = { weight = 50000000, slots = 250 },
    [`gr_prop_gr_tool_draw_01b`] = { weight = 50000000, slots = 250 },
    [`gr_prop_gr_tool_draw_01d`] = { weight = 50000000, slots = 250 },
    [`apa_mp_h_bed_chestdrawer_02`] = { weight = 50000000, slots = 250 },
    [`apa_mp_h_str_sideboardl_14`] = { weight = 50000000, slots = 250 },
    [`apa_mp_h_str_sideboardl_13`] = { weight = 50000000, slots = 250 },
    [`apa_mp_h_str_sideboardm_02`] = { weight = 50000000, slots = 250 },
    [`apa_mp_h_str_sideboards_02`] = { weight = 50000000, slots = 250 },
    [`hei_heist_bed_chestdrawer_04`] = { weight = 50000000, slots = 250 },
    [`hei_heist_str_sideboardl_02`] = { weight = 50000000, slots = 250 },
    [`p_v_43_safe_s`] = { weight = 50000000, slots = 250 },
}
