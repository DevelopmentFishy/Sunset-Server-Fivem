local Translations = {
    --Professions:
    all = 'Recepten',
    chemist = 'Chemie',
    cooking = 'Cooken',
    weaponry = 'Wapen',
    handicraft = 'Craft',
    foundry = 'Foundry',
    workstation = 'Werkbank',
    stat_screen_btn = 'Statistieken',
    craft_screen_btn = 'Recepten',
    craft = 'Maken',
    search = 'Zoeken...',
    select_product = 'Selecteer een product',
    proficiency = 'CraftLevel',
    price = 'Prijs',
    chance = 'Kans',
    labor = 'WerkPunten',
    ingredients = 'ingrediënten',
    cancel = 'Annuleer',
    weight = 'Gewicht',
    cash = 'Cash',

    -- Ranks
    rank0 = '',
    rank1 = 'Novice', -- Begginer
    rank2 = 'Veteran', -- Novice
    rank3 = 'Expert', -- Hobbyist
    rank4 = 'Master', -- Apprentice
    rank5 = 'Authority', -- Initiate
    rank6 = 'Champion', -- Skilled
    rank7 = 'Adept', -- Adept
    rank8 = 'Herald', -- Craftsman
    rank9 = 'Virtuoso', -- Master
    rank10 = 'Celebrity', -- Genius
    rank11 = 'Famed', -- Prodigy

    -- Messages
    in_progress = 'Crafting %{v1} / %{v2} %{v3}',
    use_workstation = 'Gebruik %{v1} station: %{v2}',
    use_workstation_target = 'Gebruik %{v1} Tafel',
    not_in_the_workspace = 'Je bent te ver weg van een tafel!',
    missing_data = 'Niet genoeg materialen: Item / Hoeveeelheid',
    recipe_does_not_exist = 'Dit recept bestaat niet',
    go_to_a_workstation = 'You can\'t make this here. Look for a %{v1} station',
    only_special_workstation = 'This can only be made at a Special Workstation!',
    not_enough_money = 'Niet genoeg geld!',
    not_enough_materials = 'Niet genoeg materialen!',
    not_enough_labor = 'Niet genoeg werkpunten!',
    not_enough_proficiency = 'Je hebt het juiste level niet!',
    canceled = 'Laten we dit later verder maken...',
    in_loading = 'Laden... Probeer later opnieuw!',
    too_heavy = 'Het weegt te veel!',
    not_enough_space = 'Niet genoeg plaats!',
    cant_work = 'You can\'t browse at the moment!',
    item_remove_fail = 'OEPS er ging iets mis!...',
    production_rights_denied = 'Je kan dit product niet maken!',
    you_have_been_injured = 'Je kan in deze staat niet knutselen!',
    you_already_make_something = 'Je bent al bezig met craften...',
    no_hits = 'Geen antwoord... :(',
    improper_workplace = 'Ongepaste werkplek',
    labor_added = 'Werkpunten toegevoegd',
    proficiency_added = 'Level verhoogd',
    not_possible = 'Niet mogelijk',
    back = 'terug',
    order_by = 'Bestel bij:',
    damaged_while_making = '%{v1} Product is beschadigd geraakt tijdens maken',
    failed_due_to_a_chance = 'Failed due to a chance (chance: %{v1}%)',
    level_up = 'Je bent een level omhoog gegaan!',
    tips = {
        -- tip1 = 'Your labor point increases with 10 points every 5 minutes.(Even if offline)',
        -- tip2 = 'The spent labor point will increase your proficiency',
        tip3 = 'KLik op het groene vakje om het recept te zien',
        -- tip4 = 'Some items require a special workstation',
        -- tip5 = 'Did you run out of your labor points? There is an opportinity to increase it!',
        tip6 = 'Verhoog je level door simpele dingen te maken',
        -- tip7 = 'If you don\'t have a recipe book yet, you should consider to get one',
        -- tip8 = 'You can move the crafting window by dragging the header',
        -- tip9 = 'To find you desired recipe try using the search field'
    },

    -- LOG
    condition_check = 'Conditiecontrole:',
    remove_money = 'Betaal:',
    remove_ingredients = 'Verwijder items:',
    add_item = 'Voeg item toe:',
    add_item_fail = 'Item toevoegen gefaald',
    increase_labor = 'Verhoog werkpunten:',
    player_stat = 'Staat:',
    owner = 'Owner',

    --portable workstations
    removal = 'Removal: %{v1}',
    workstation_removal = 'Remove a workstation',
    workstation_placement = 'Workstation placement',
    workstation_cannot_be_removed = 'This workstation cannot be removed',
    portable_item_does_not_exist = 'Portable item does not exist',
    no_more_portable_workstation = 'You cannot create more workspaces',
    another_workstation_is_too_close = 'Another workplace is too close',
    in_a_restricted_area = 'Territory protection: try a little further away',
    restricted_area_visual_display = 'Restricted are display:',
    workplace_data_copied_to_clipboard = 'Workplace data copied to clipboard',
    workstation_placed = 'Workplace prepared',
    workstation_removed = 'You demolished the workplace',
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})