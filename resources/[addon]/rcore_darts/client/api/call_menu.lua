if CConfig.UsingOxMenu then
    local gametype, numbertoreach, gameMulti, bets = 1, CConfig.ValuesToHit[1], 1, false
    local startnumber                              = CConfig.Reach0Start[1]
    local index1, index2                           = 1, 1
    local gameTypeMulti                            = { _U("ALONE"), _U("TW_PLYS") }
    local posibleOnes                              = { _U("REACH_0"), _U("MX_NUM") }
    local fistTime                                 = false
    local coordsGetter                             = vector3(0, 0, 0)
    local menuOptions                              = {
        {
            label = _U("GM_INFO"),
            values = posibleOnes,
            defaultIndex = gametype,
            args = 'info'
        },
        {
            label = _U("MODE"),
            values = gameTypeMulti,
            defaultIndex = gameMulti,
            args = 'mode'
        },
        {
            label = _U("BETS_OPT"),
            checked = bets,
            args = 'bets'
        },
        {
            label = (_U("NUM_TO_REA")):format(numbertoreach),
            values = CConfig.ValuesToHit,
            defaultIndex = index1,
            args = 'num_to_reach'
        },
        {
            label = (_U("START_NUM")):format(startnumber),
            values = CConfig.Reach0Start,
            defaultIndex = index2,
            args = 'start_num'
        },
        {
            label = _U("CN_AND_ST"),
            args = { isConfirm = true },
        },
    }

    CreateThread(function()
        lib.hideMenu()
        function RegisterMenu()
            lib.registerMenu({
                id = 'gameselection',
                title = _U("CR_GAME"),
                position = 'top-right',
                options = menuOptions,
                onSideScroll = function(selected, scrollIndex, args)
                    if args == 'info' then
                        gametype = scrollIndex
                    elseif args == 'mode' then
                        gameMulti = scrollIndex
                        if gameMulti == 1 then
                            bets = false
                        end
                    elseif args == 'num_to_reach' then
                        index1 = scrollIndex
                        numbertoreach = CConfig.ValuesToHit[scrollIndex]
                    elseif args == 'start_num' then
                        index2 = scrollIndex
                        startnumber = CConfig.Reach0Start[scrollIndex]
                    end
                end,
                onCheck = function(selected, checked, args)
                    if args == 'bets' then
                        bets = not bets
                    end
                end,
                onClose = function(keyPressed)
                    DRTS.Variables.MenuOpened                = false
                    bets                                     = false
                    gametype, numbertoreach, gameMulti, bets = 1, CConfig.ValuesToHit[1], 1, false
                    startnumber                              = CConfig.Reach0Start[1]
                    index1, index2                           = 1, 1
                end,
            }, function(selected, scrollIndex, args)
                if args.isConfirm then
                    local PlyName = lib.inputDialog(_U("YOUR_NAME"), { _U("YOUR_NAME") })
                    if PlyName[1] and PlyName[1] ~= "" then
                        if bets and gameMulti == 2 then
                            local bet = lib.inputDialog(_U("YOUR_BET"), { _U("YOUR_BET") })
                            if tonumber(bet[1]) then
                                if not CheckBet(tonumber(bet[1])) then
                                    DRTS.Variables.MenuOpened                = false
                                    bets                                     = false
                                    gametype, numbertoreach, gameMulti, bets = 1, CConfig.ValuesToHit[1], 1, false
                                    startnumber                              = CConfig.Reach0Start[1]
                                    index1, index2                           = 1, 1
                                    lib.hideMenu()
                                    return
                                end
                                if gametype == 2 then
                                    TriggerServerEvent("rcore_darts:server:newGame", gametype, numbertoreach,
                                        { coords = coordsGetter, name = PlyName[1] }, false, false, false, false,
                                        gameMulti, bets,
                                        { tonumber(bet[1]) })
                                else
                                    TriggerServerEvent("rcore_darts:server:newGame", gametype, startnumber,
                                        { coords = coordsGetter, name = PlyName[1] }, false, false, false, false,
                                        gameMulti, bets,
                                        { tonumber(bet[1]) })
                                end
                                if gameMulti == 2 then
                                    Notify(_U("NEW_GAME_CR"))
                                end
                                DRTS.Variables.MenuOpened = false
                            else
                                Notify(_U("BET_MUST_BE_NUM"))
                            end
                        else
                            if gametype == 2 then
                                TriggerServerEvent("rcore_darts:server:newGame", gametype, numbertoreach,
                                    { coords = coordsGetter, name = PlyName[1] }, false, false, false, false,
                                    gameMulti, false)
                            else
                                TriggerServerEvent("rcore_darts:server:newGame", gametype, startnumber,
                                    { coords = coordsGetter, name = PlyName[1] }, false, false, false, false,
                                    gameMulti, false)
                            end
                            if gameMulti == 2 then
                                Notify(_U("NEW_GAME_CR"))
                            end
                            DRTS.Variables.MenuOpened = false
                        end
                    else
                        Notify(_U("VALID_NAME"))
                    end
                    bets                                     = false
                    gametype, numbertoreach, gameMulti, bets = 1, CConfig.ValuesToHit[1], 1, false
                    startnumber                              = CConfig.Reach0Start[1]
                    index1, index2                           = 1, 1
                    lib.hideMenu()
                end
                DRTS.Variables.MenuOpened                = false
                bets                                     = false
                gametype, numbertoreach, gameMulti, bets = 1, CConfig.ValuesToHit[1], 1, false
                startnumber                              = CConfig.Reach0Start[1]
                index1, index2                           = 1, 1
            end)
        end

        if Config.Framework == 'standalone' then
            menuOptions = {
                {
                    label = _U("GM_INFO"),
                    values = posibleOnes,
                    defaultIndex = gametype,
                    args = 'info'
                },
                {
                    label = _U("MODE"),
                    values = gameTypeMulti,
                    defaultIndex = gameMulti,
                    args = 'mode'
                },
                {
                    label = (_U("NUM_TO_REA")):format(numbertoreach),
                    values = CConfig.ValuesToHit,
                    defaultIndex = index1,
                    args = 'num_to_reach'
                },
                {
                    label = (_U("START_NUM")):format(startnumber),
                    values = CConfig.Reach0Start,
                    defaultIndex = index2,
                    args = 'start_num'
                },
                {
                    label = _U("CN_AND_ST"),
                    args = { isConfirm = true },
                },
            }
        end
        RegisterMenu()
    end)

    function CheckIfGameInCoordsExist(coords)
        for k, v in pairs(DRTS.Variables.AwaitingGames) do
            if v.coords == coords then
                return true
            end
        end
        return false
    end

    function OpenGameCreation(coords)
        coordsGetter = coords
        if CheckIfGameInCoordsExist(coords) then
            return Notify('')
        end
        if not DRTS.Variables.MenuOpened then
            DRTS.Variables.MenuOpened = true
            lib.showMenu('gameselection')
        end
    end
else
    local gametype, numbertoreach, gameMulti, bets = 1, CConfig.ValuesToHit[1], 1, false
    local startnumber                              = CConfig.Reach0Start[1]
    local index1, index2                           = 1, 1
    local gameTypeMulti                            = { _U("ALONE"), _U("TW_PLYS") }
    local posibleOnes                              = { _U("REACH_0"), _U("MX_NUM") }
    local fistTime                                 = false

    CreateThread(function()
        Citizen.Await(menuLoaded)
        WarMenu.CreateMenu('game_selection', _U("CR_GAME"), _U("OPT_GM"))
        WarMenu.CreateSubMenu('type_options', "game_selection", _U("SEL_GAMEMD"))
        WarMenu.CreateSubMenu('confirm', "game_selection", _U("CN_AND_ST"))
    end)

    function CheckIfGameInCoordsExist(coords)
        for k, v in pairs(DRTS.Variables.AwaitingGames) do
            if v.coords == coords then
                return true
            end
        end
        return false
    end

    function CheckBet(num)
        if not (num >= CConfig.Bets.min_bet) then
            Notify((_U('MIN_BET'):format(CConfig.Bets.min_bet)))
            return false
        elseif not (num <= CConfig.Bets.max_bet) then
            Notify((_U('MAX_BET'):format(CConfig.Bets.max_bet)))
            return false
        end
        return true
    end

    ---Open the game creation menu
    ---@param coords any
    function OpenGameCreation(coords)
        if CheckIfGameInCoordsExist(coords) then
            return Notify('')
        end
        CreateThread(function()
            WarMenu.CloseMenu()
            if WarMenu.IsAnyMenuOpened() then
                return
            end
            DRTS.Variables.MenuOpened = true
            WarMenu.OpenMenu('game_selection')

            while true do
                if WarMenu.Begin('game_selection') then
                    WarMenu.MenuButton(_U("GM_INFO"), 'type_options')
                    WarMenu.MenuButton(_U("CN_AND_ST"), 'confirm')


                    WarMenu.End()
                elseif WarMenu.Begin('type_options') then
                    local _, comboBoxIndex = WarMenu.ComboBox(_U("GAME_MODE"), posibleOnes, gametype)
                    if gametype ~= comboBoxIndex then
                        gametype = comboBoxIndex
                    end

                    local _, comboBoxIndex = WarMenu.ComboBox(_U("MODE"), gameTypeMulti, gameMulti)
                    if gameMulti ~= comboBoxIndex then
                        if comboBoxIndex == 1 then
                            bets = false
                        end
                        gameMulti = comboBoxIndex
                    end
                    if gameMulti == 2 then
                        if Config.Framework ~= Framework.Standalone then
                            if WarMenu.CheckBox(_U("BETS_OPT"), bets) then
                                bets = not bets
                            end
                        end
                    end
                    if gametype == 2 then
                        local _, comboBoxIndex = WarMenu.ComboBox((_U("NUM_TO_REA")):format(numbertoreach),
                            CConfig.ValuesToHit, index1)
                        if index1 ~= comboBoxIndex then
                            index1 = comboBoxIndex
                            numbertoreach = CConfig.ValuesToHit[comboBoxIndex]
                        end
                    else
                        local _, comboBoxIndex = WarMenu.ComboBox((_U("START_NUM")):format(startnumber),
                            CConfig.Reach0Start,
                            index2)
                        if index2 ~= comboBoxIndex then
                            index2 = comboBoxIndex
                            startnumber = CConfig.Reach0Start[comboBoxIndex]
                        end
                    end
                    WarMenu.End()
                elseif WarMenu.Begin("confirm") then
                    local PlyName = DisplayKeyboard(_U("YOUR_NAME"))
                    if not PlyName then
                        DRTS.Variables.MenuOpened = false
                        return WarMenu.CloseMenu()
                    end
                    if PlyName and PlyName ~= "" then
                        if bets then
                            local bet = DisplayKeyboard(_U("YOUR_BET"))
                            if tonumber(bet) then
                                if not CheckBet(tonumber(bet)) then
                                    DRTS.Variables.MenuOpened = false
                                    return WarMenu.CloseMenu()
                                end
                                if gametype == 2 then
                                    TriggerServerEvent("rcore_darts:server:newGame", gametype, numbertoreach,
                                        { coords = coords, name = PlyName }, false, false, false, false, gameMulti, bets,
                                        { tonumber(bet) })
                                else
                                    TriggerServerEvent("rcore_darts:server:newGame", gametype, startnumber,
                                        { coords = coords, name = PlyName }, false, false, false, false, gameMulti, bets,
                                        { tonumber(bet) })
                                end
                                if gameMulti == 2 then
                                    Notify(_U("NEW_GAME_CR"))
                                end
                                DRTS.Variables.MenuOpened = false
                            else
                                Notify(_U("BET_MUST_BE_NUM"))
                                DRTS.Variables.MenuOpened = false
                            end
                        else
                            if gametype == 2 then
                                TriggerServerEvent("rcore_darts:server:newGame", gametype, numbertoreach,
                                    { coords = coords, name = PlyName }, false, false, false, false, gameMulti, bets,
                                    { 0 })
                            else
                                TriggerServerEvent("rcore_darts:server:newGame", gametype, startnumber,
                                    { coords = coords, name = PlyName }, false, false, false, false, gameMulti, bets,
                                    { 0 })
                            end
                            if gameMulti == 2 then
                                Notify(_U("NEW_GAME_CR"))
                            end
                            DRTS.Variables.MenuOpened = false
                        end
                        return WarMenu.CloseMenu()
                    else
                        Notify(_U("VALID_NAME"))
                    end
                else
                    DRTS.Variables.MenuOpened = false
                    return
                end
                Wait(0)
            end
        end)
    end
end

function CheckBet(num)
    if not (num >= CConfig.Bets.min_bet) then
        Notify((_U('MIN_BET'):format(CConfig.Bets.min_bet)))
        return false
    elseif not (num <= CConfig.Bets.max_bet) then
        Notify((_U('MAX_BET'):format(CConfig.Bets.max_bet)))
        return false
    end
    return true
end
