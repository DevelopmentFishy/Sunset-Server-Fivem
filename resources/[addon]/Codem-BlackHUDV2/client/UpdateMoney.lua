local lastCash = nil
local lastBlackMoney = nil
local lastBank = nil
function loadESXMoneyAndJob()
    local breakLoop = false
    while true do
        if frameworkObject ~= nil then
            if frameworkObject.GetPlayerData() then
                while frameworkObject.GetPlayerData().job == nil do
                    Citizen.Wait(0)
                end
                SendNUIMessage({
                    type = "update_job",
                    joblabel = frameworkObject.GetPlayerData().job.label,
                    grade_label = frameworkObject.GetPlayerData().job.grade_label
                })
                frameworkObject.TriggerServerCallback("codem-blvckhudv2:GetMoney", function(cash)
                    SendNUIMessage({
                        type = "update_money",
                        money = cash
                    })
                    lastCash = cash
                end, "cash")

                frameworkObject.TriggerServerCallback("codem-blvckhudv2:GetMoney", function(blackmoney)
                    SendNUIMessage({
                        type = "SetBlackMoney",
                        money = blackmoney
                    })
                    lastBlackMoney = blackmoney
                end, "black_money")      
                
                local gradeName = 'boss'
                if Config.BossGradeNames[frameworkObject.GetPlayerData().job.name] then
                    gradeName = Config.BossGradeNames[frameworkObject.GetPlayerData().job.name]
                end

                if frameworkObject.GetPlayerData().job.grade_name == gradeName then
                    frameworkObject.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
                        SendNUIMessage({
                            type = "SetBossMoney",
                            money = money
                        })
                        
                        SendNUIMessage({type = 'SetIsBoss', value = true})
                    end, frameworkObject.GetPlayerData().job.name)
                else
                    SendNUIMessage({type = 'SetIsBoss', value = false})
                end
                
                frameworkObject.TriggerServerCallback("codem-blvckhudv2:GetMoney", function(bank)
                    SendNUIMessage({
                        type = "update_bank",
                        money = bank
                    })
                    lastBank = bank
                    breakLoop = true
                end, "bank")
                if breakLoop then
                    return
                end 
            end
        end
        Citizen.Wait(0)
    end
end

Citizen.CreateThread(function()
    while not response do
        Citizen.Wait(0)
    end
    if Config.Framework == "esx" then
        Citizen.Wait(1000)
        loadESXMoneyAndJob()
    else
        Citizen.Wait(1000)
        local breakLoop = false
        while true do   
            Citizen.Wait(0)
            if frameworkObject ~= nil then
                local Player = frameworkObject.Functions.GetPlayerData()
                if Player then
                    if Player.job ~= nil then
                        SendNUIMessage({
                            type = "update_job",
                            joblabel = Player.job.label,
                            grade_label = Player.job.grade.name
                        })
                    end
                    if Player.money ~= nil then
                        SendNUIMessage({
                            type = "update_money",
                            money = Player.money.cash
                        })
                        lastCash = Player.money.cash
                        SendNUIMessage({
                            type = "update_bank",
                            money = Player.money.bank
                        })
                        lastBank = Player.money.bank

                        breakLoop = true
                    end
            
                    if breakLoop then
                        break
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(a, b, m)
    SendNUIMessage({
        type = "update_money",
        money = m
    })
    if Config.EnableWatermarkCash then
        TriggerEvent('codem-blvckhudv2:OnAddedMoney', m - lastCash, false, "cash")
        lastCash = m
    end
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(a, b, m)
        SendNUIMessage({
            type = "update_money",
            money = m
        })
    if Config.EnableWatermarkCash then
        TriggerEvent('codem-blvckhudv2:OnAddedMoney', (m - lastCash) * -1, true, "cash")
        lastCash = m
    end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    SendNUIMessage({
        type = "update_job",
        joblabel =job.label,
        grade_label = job.grade_label
    })
    local gradeName = 'boss'
    if Config.BossGradeNames[job.name] then
        gradeName = Config.BossGradeNames[job.name]
    end
    if job.grade_name == gradeName then
		frameworkObject.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            SendNUIMessage({
                type = "SetBossMoney",
                money = money
            })
            SendNUIMessage({type = 'SetIsBoss', value = true})
        end, job.name)
    else
        SendNUIMessage({type = 'SetIsBoss', value = false})
    end
end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
    local gradeName = 'boss'
    if Config.BossGradeNames[frameworkObject.GetPlayerData().job.name] then
        gradeName = Config.BossGradeNames[frameworkObject.GetPlayerData().job.name]
    end
	if frameworkObject.GetPlayerData().job and frameworkObject.GetPlayerData().job.grade_name == gradeName and 'society_' .. frameworkObject.GetPlayerData().job.name == society then
        SendNUIMessage({
            type = "SetBossMoney",
            money = money
        })
    end
end)

RegisterNetEvent("QBCore:Player:SetPlayerData")
AddEventHandler("QBCore:Player:SetPlayerData", function(data)
    SendNUIMessage({
        type = "update_money",
        money = data.money.cash

    })
    SendNUIMessage({
        type = "update_bank",
        money = data.money.bank
    })

    SendNUIMessage({
        type = "update_job",
        joblabel = data.job.label,
        grade_label = data.job.grade.name
    })
    if Config.EnableWatermarkCash then
        if lastCash ~= nil and lastCash ~= data.money.cash then
            if  data.money.cash > lastCash then
                TriggerEvent('codem-blvckhudv2:OnAddedMoney', data.money.cash - lastCash, false , "cash")
            else
                TriggerEvent('codem-blvckhudv2:OnAddedMoney', (data.money.cash - lastCash) * -1, true , "cash")
            end
            lastCash = data.money.cash
        end

    end
    if Config.EnableWatermarkBankMoney then
        if lastBank ~= nil  and lastBank ~= data.money.bank then
            if data.money.bank > lastBank then
                TriggerEvent('codem-blvckhudv2:OnAddedMoney', data.money.bank - lastBank, false, "bank")
            else
                TriggerEvent('codem-blvckhudv2:OnAddedMoney', (data.money.bank - lastBank)* -1, true, "bank")
            end
            lastBank = data.money.bank
        end
    end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    if account.name == "bank" then
        local money = account.money
        SendNUIMessage({
            type = "update_bank",
            money = money
        })
        if Config.EnableWatermarkBankMoney then
           if lastBank ~= nil  and lastBank ~= money then
                if money > lastBank then
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney',money - lastBank, false, "bank")
                else
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney', (money - lastBank) * -1, true, "bank")
                end
                lastBank = money
            end     
        end
    end

    if account.name == 'black_money' then
        local money = account.money
        SendNUIMessage({
            type = "SetBlackMoney",
            money = money
        })
        if Config.EnableWatermarkBlackMoney then
            if lastBlackMoney ~= nil  and lastBlackMoney ~= money then
                if money > lastBlackMoney then
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney', money - lastBlackMoney, false, "black_money")
                else
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney',  (money - lastBlackMoney ) * -1, true, "black_money")
                end
                lastBlackMoney = money
            end
        end
    end

    if account.name == 'money' then
        local money = account.money
        SendNUIMessage({
            type = "update_money",
            money = money
        })

        if Config.EnableWatermarkCash then
            if lastCash ~= nil  and lastCash ~= money then
                if money > lastCash then
                
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney',money - lastCash, false, "cash")
                else
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney',  (money - lastCash ) * -1, true, "cash")
                end
                lastCash = money
            end
        end
    end
end)