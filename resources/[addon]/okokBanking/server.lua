local QBCore = exports["qb-core"]:GetCoreObject()

local Webhook = ''

function interp(s, tab)
	return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end

function AddMoney(society, amount)
	local done = false

	MySQL.query('UPDATE okokbanking_societies SET value = value + @value WHERE society = @society OR society = @society2', {
		['@value'] = amount,
		['@society'] = 'society_'..string.gsub(society, "society_", ""),
		['@society2'] = string.gsub(society, "society_", ""),
	}, function(changed)
		done = true
	end)

	while not done do
		Citizen.Wait(1)
	end

	return true
end

function RemoveMoney(society, amount)
	local done = false

	MySQL.query('UPDATE okokbanking_societies SET value = value - @value WHERE society = @society OR society = @society2', {
		['@value'] = amount,
		['@society'] = 'society_'..string.gsub(society, "society_", ""),
		['@society2'] = string.gsub(society, "society_", ""),
	}, function(changed)
		done = true
	end)

	while not done do
		Citizen.Wait(1)
	end

	return true
end

function GetAccount(society)
	local done = false
	local money = 0

	MySQL.query('SELECT value FROM okokbanking_societies WHERE society = @society OR society = @society2', {
		['@society'] = 'society_'..string.gsub(society, "society_", ""),
		['@society2'] = string.gsub(society, "society_", "")
	}, function(result)
		local db = result[1]
		done = true
		if db.value ~= nil then
			money = tonumber(db.value)
		end
	end)

	while not done do
		Citizen.Wait(1)
	end

	return money
end

if Config.UseCashAsItem then
	QBCore.Functions.CreateCallback("okokBanking:GetPlayerInfo", function(source, cb)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local itemCash = xPlayer.Functions.GetItemByName("cash")
		local itemCashAmount = 0
		if itemCash then
			itemCashAmount = itemCash.amount
		end
		MySQL.query('SELECT * FROM players WHERE citizenid = @identifier', {
			['@identifier'] = xPlayer.PlayerData.citizenid
		}, function(result)
			local db = result[1]
			local data = {
				playerName = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname,
				playerBankMoney = xPlayer.PlayerData.money.bank,
				playerIBAN = xPlayer.PlayerData.charinfo.account,
				walletMoney = itemCashAmount,
				sex = xPlayer.PlayerData.charinfo.gender,
				isBoss = xPlayer.PlayerData.job.isboss,
				isBossGang = xPlayer.PlayerData.gang.isboss
			}
			
			cb(data)
		end)
	end)
else
	QBCore.Functions.CreateCallback("okokBanking:GetPlayerInfo", function(source, cb)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		MySQL.query('SELECT * FROM players WHERE citizenid = @identifier', {
			['@identifier'] = xPlayer.PlayerData.citizenid
		}, function(result)
			local db = result[1]
			local data = {
				playerName = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname,
				playerBankMoney = xPlayer.PlayerData.money.bank,
				playerIBAN = xPlayer.PlayerData.charinfo.account,
				walletMoney = xPlayer.PlayerData.money.cash,
				sex = xPlayer.PlayerData.charinfo.gender,
				isBoss = xPlayer.PlayerData.job.isboss,
				isBossGang = xPlayer.PlayerData.gang.isboss
			}
			
			cb(data)
		end)
	end)
end

QBCore.Functions.CreateCallback("okokBanking:IsIBanUsed", function(source, cb, iban)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	
	MySQL.query('SELECT * FROM players WHERE JSON_EXTRACT(charinfo, "$.account") = @iban', {
		['@iban'] = iban
	}, function(result)
		local db = result[1]

		if db ~= nil then
			cb(db, true, xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname)
		else
			if Config.UseQBManagement then
				MySQL.query('SELECT * FROM management_funds WHERE iban = @iban', {
					['@iban'] = iban
				}, function(result2)
					local db2 = result2[1]
					local dbdata
					if db2 ~= nil then
						dbdata = {
							iban = db2.iban,
							value = db2.amount,
							society_name = db2.job_name,
							society = db2.job_name
						}
					end
					
					cb(dbdata, false)
				end)
			else
				MySQL.query('SELECT * FROM okokbanking_societies WHERE iban = @iban', {
					['@iban'] = iban
				}, function(result2)
					local db2 = result2[1]
					
					cb(db2, false)
				end)
			end
		end
	end)
end)

QBCore.Functions.CreateCallback("okokBanking:GetPIN", function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	
	MySQL.query('SELECT pincode FROM players WHERE citizenid = @identifier', {
		['@identifier'] = xPlayer.PlayerData.citizenid,
	}, function(result)
		local pin = result[1]

		cb(pin.pincode)
	end)
end)

QBCore.Functions.CreateCallback("okokBanking:SocietyInfo", function(source, cb, society, iban)
	if Config.UseQBManagement then
		MySQL.query('SELECT * FROM management_funds WHERE job_name = @job_name', {
			['@job_name'] = society,
		}, function(result)
			local db = result[1]
			local aa
			if db ~= nil then
				if db.iban ~= nil then
					aa = {
						value = db.amount,
						society_name = db.job_name,
						society = db.job_name,
						iban = db.iban
					}
				else
					MySQL.query('UPDATE management_funds SET iban = @iban WHERE job_name = @job_name', {
						['@iban'] = string.gsub(iban:upper(), " ", ""),
						['@job_name'] = society,
					}, function(result2)
						local db2 = result2[1]
						if db2 ~= nil then
							aa = {
								value = db2.amount,
								society_name = db2.job_name,
								society = db2.job_name,
								iban = db2.iban
							}
						end
					end)
				end
			end
			cb(aa)
		end)
	else
		MySQL.query('SELECT * FROM okokbanking_societies WHERE society = @society', {
			['@society'] = society
		}, function(result)
			local db = result[1]
			cb(db)
		end)
	end
end)

RegisterServerEvent("okokBanking:CreateSocietyAccount")
AddEventHandler("okokBanking:CreateSocietyAccount", function(society, society_name, value, iban)
	if Config.UseQBManagement then
		MySQL.query('SELECT * FROM management_funds WHERE job_name = @job_name', {
			['@job_name'] = society,
		}, function(result)
			local db = result[1]
			if db == nil then
				MySQL.query('INSERT INTO management_funds (job_name, amount, iban) VALUES (@job_name, @amount, @iban)', {
					['@job_name'] = society,
					['@amount'] = value,
					['@iban'] = string.gsub(iban:upper(), "%s+", ""),
				}, function (result)
				end)
			end
		end)
	else
		MySQL.query('INSERT INTO okokbanking_societies (society, society_name, value, iban) VALUES (@society, @society_name, @value, @iban)', {
			['@society'] = society,
			['@society_name'] = society_name,
			['@value'] = value,
			['@iban'] = string.gsub(iban:upper(), "%s+", ""),
		}, function (result)
		end)
	end
end)

RegisterServerEvent("okokBanking:SetIBAN")
AddEventHandler("okokBanking:SetIBAN", function(iban)
	local xPlayer = QBCore.Functions.GetPlayer(source)

	xPlayer.Functions.ChangeIban(iban)
end)

QBCore.Functions.CreateCallback("okokBanking:HasCreditCard", function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer ~= nil then
		local item = xPlayer.Functions.GetItemByName(Config.CreditCardItem)
		if item ~= nil then
			cb(item.amount >= 1)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)

RegisterServerEvent("okokBanking:DepositMoney")
AddEventHandler("okokBanking:DepositMoney", function(amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.cash
	local itemCash = xPlayer.Functions.GetItemByName("cash")
	local playerMoneyCash = 0
	if itemCash ~= nil then
		playerMoneyCash = itemCash.amount
	end

	if amount <= playerMoney and not Config.UseCashAsItem or amount <= playerMoneyCash and Config.UseCashAsItem then
		if Config.UseCashAsItem then
			xPlayer.Functions.RemoveItem('cash', amount)
		else
			xPlayer.Functions.RemoveMoney('cash', amount)
		end
		xPlayer.Functions.AddMoney('bank', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)
		local itemCashUpdated = xPlayer.Functions.GetItemByName("cash")
		local playerMoneyCashUpdated = 0
		if itemCashUpdated ~= nil then
			playerMoneyCashUpdated = itemCashUpdated.amount
		end
		TriggerEvent('okokBanking:AddDepositTransaction', amount, _source)
		if Config.UseCashAsItem then
			TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, playerMoneyCashUpdated)
		else
		TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		end
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('deposited').title, interp(_L('deposited').text, {s1 = amount}), _L('deposited').time, _L('deposited').type)
		else
			TriggerClientEvent('QBCore:Notify',  _source, interp(_L('deposited').text, {s1 = amount}), _L('deposited').type)
		end
		DepositMoneyWebhook({sender_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, value = GroupDigits(amount)})
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('no_money_pocket').title, _L('no_money_pocket').text, _L('no_money_pocket').time, _L('no_money_pocket').type)
		else
			TriggerClientEvent('QBCore:Notify',  _source, _L('no_money_pocket').text, _L('no_money_pocket').type)
		end
	end
end)

RegisterServerEvent("okokBanking:WithdrawMoney")
AddEventHandler("okokBanking:WithdrawMoney", function(amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.bank
	local playerMoneyCash = xPlayer.Functions.GetItemByName("cash")
	local playerMoneyCashAmount = 0
	if playerMoneyCash then
		playerMoneyCashAmount = playerMoneyCash.amount
	end

	if amount <= playerMoney and not Config.UseCashAsItem or amount <= playerMoneyCash and Config.UseCashAsItem then
		if Config.UseCashAsItem then
			xPlayer.Functions.AddItem('cash', amount)
		else
		 	xPlayer.Functions.AddMoney('cash', amount)
		end
		xPlayer.Functions.RemoveMoney('bank', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)
		local playerMoneyCash = xPlayer.Functions.GetItemByName("cash")
		local playerMoneyCashAmount = 0
		if playerMoneyCash then
			playerMoneyCashAmount = playerMoneyCash.amount
		end

		TriggerEvent('okokBanking:AddWithdrawTransaction', amount, _source)
		if Config.UseCashAsItem then
			TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, playerMoneyCashAmount)
		else
			TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		end
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('withdrawn').title, interp(_L('withdrawn').text, {s1 = amount}), _L('withdrawn').time, _L('withdrawn').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, interp(_L('withdrawn').text, {s1 = amount}), _L('withdrawn').type)
		end
		WithdrawMoneyWebhook({receiver_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, value = GroupDigits(amount)})
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('no_money_bank').title, _L('no_money_bank').text, _L('no_money_bank').time, _L('no_money_bank').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L('no_money_bank').text, _L('no_money_bank').type)
		end
	end
end)

RegisterServerEvent("okokBanking:TransferMoney")
AddEventHandler("okokBanking:TransferMoney", function(amount, ibanNumber, targetIdentifier, acc, targetName)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(targetIdentifier)
	local xPlayers = QBCore.Functions.GetPlayers()
	local playerMoney = xPlayer.PlayerData.money.bank
	local itemCash = xPlayer.Functions.GetItemByName("cash")
	local PlayerCashMoney = 0
	if itemCash ~= nil then
		PlayerCashMoney = itemCash.amount
	end
	ibanNumber = ibanNumber:upper()

	if xPlayer.PlayerData.citizenid ~= targetIdentifier then
		if amount <= playerMoney or amount <= PlayerCashMoney then
			if xTarget ~= nil then
				xPlayer.Functions.RemoveMoney('bank', amount)
				xTarget.Functions.AddMoney('bank', amount)
				xPlayer = QBCore.Functions.GetPlayer(_source)

				for i=1, #xPlayers, 1 do
					local xForPlayer = QBCore.Functions.GetPlayer(xPlayers[i])

					if xForPlayer.PlayerData.citizenid == targetIdentifier then
						if Config.UseCashAsItem then
							TriggerClientEvent('okokBanking:updateTransactions', xPlayers[i], xTarget.PlayerData.money.bank, PlayerCashMoney)
						else
							TriggerClientEvent('okokBanking:updateTransactions', xPlayers[i], xTarget.PlayerData.money.bank, xTarget.PlayerData.money.cash)
						end
						if Config.okokNotify then
							TriggerClientEvent('okokNotify:Alert', xPlayers[i], _L('received_from').title, interp(_L('received_from').text, {s1 = amount, s2 = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname}), _L('received_from').time, _L('received_from').type)
						else
							TriggerClientEvent('QBCore:Notify', xPlayers[i], interp(_L('received_from').text, {s1 = amount, s2 = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname}), _L('received_from').type)
						end
					end
				end

				TriggerEvent('okokBanking:AddTransferTransaction', amount, xTarget, _source)
				if Config.UseCashAsItem then
					TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, PlayerCashMoney)
				else
					TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
				end
				if Config.okokNotify then
					TriggerClientEvent('okokNotify:Alert', _source, _L('transferred_to').title, interp(_L('transferred_to').text, {s1 = amount, s2 = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname}), _L('transferred_to').time, _L('transferred_to').type)
				else
					TriggerClientEvent('QBCore:Notify', _source, interp(_L('transferred_to').text, {s1 = amount, s2 = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname}), _L('transferred_to').type)
				end
				TransferMoneyWebhook({sender_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, receiver_name = xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname, value = amount})
			elseif xTarget == nil then
				local playerAccount = json.decode(acc)
				playerAccount.bank = playerAccount.bank + amount
				playerAccount = json.encode(playerAccount)
				xPlayer.Functions.RemoveMoney('bank', amount)
				xPlayer = QBCore.Functions.GetPlayer(_source)
				TriggerEvent('okokBanking:AddTransferTransaction', amount, 1, _source, targetName, targetIdentifier)
				if Config.UseCashAsItem then
					TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, PlayerCashMoney)
				else
					TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
				end
				if Config.okokNotify then
					TriggerClientEvent('okokNotify:Alert', _source, _L('transferred_to').title, interp(_L('transferred_to').text, {s1 = amount, s2 = tName}), _L('transferred_to').time, _L('transferred_to').type)

				else
					TriggerClientEvent('QBCore:Notify', _source, interp(_L('transferred_to').text, {s1 = amount, s2 = tName}), _L('transferred_to').type)
				end
				TransferMoneyWebhook({sender_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, receiver_name = tName..' (Offline User)', value = amount})

				MySQL.query('UPDATE players SET money = @playerAccount WHERE citizenid = @target', {
					['@playerAccount'] = playerAccount,
					['@target'] = targetIdentifier
				}, function(changed)
				end)
			end
		else
			if Config.okokNotify then
				TriggerClientEvent('okokNotify:Alert', _source, _L('no_money_bank').title, _L('no_money_bank').text, _L('no_money_bank').time, _L('no_money_bank').type)
			else
				TriggerClientEvent('QBCore:Notify', _source, _L('no_money_bank').text, _L('no_money_bank').type)
			end
		end
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('not_send_yourself').title, _L('not_send_yourself').text, _L('not_send_yourself').time, _L('not_send_yourself').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L('not_send_yourself').text, _L('not_send_yourself').type)
		end
	end
end)

RegisterServerEvent("okokBanking:DepositMoneyToSociety")
AddEventHandler("okokBanking:DepositMoneyToSociety", function(amount, society, societyName)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.cash
	local itemCash = xPlayer.Functions.GetItemByName("cash")
	local playerMoneyCash = 0
	if itemCash ~= nil then
		playerMoneyCash = itemCash.amount
	end

	if amount <= playerMoney and not Config.UseCashAsItem or amount <= playerMoneyCash and Config.UseCashAsItem then
		if Config.UseQBManagement then
			exports['qb-management']:AddMoneyOkokBanking(society, amount)
		else
			MySQL.query('UPDATE okokbanking_societies SET value = value + @value WHERE society = @society AND society_name = @society_name', {
				['@value'] = amount,
				['@society'] = society,
				['@society_name'] = societyName,
			}, function(changed)
			end)
		end

		if Config.UseCashAsItem then
			xPlayer.Functions.RemoveItem('cash', amount)
		else
			xPlayer.Functions.RemoveMoney('cash', amount)
		end
		xPlayer = QBCore.Functions.GetPlayer(_source)
		local itemCashUpdated = xPlayer.Functions.GetItemByName("cash")
		local playerMoneyCashUpdated = 0
		if itemCashUpdated ~= nil then
			playerMoneyCashUpdated = itemCashUpdated.amount
		end
		TriggerEvent('okokBanking:AddDepositTransactionToSociety', amount, _source, society, societyName)
		if Config.UseCashAsItem then
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, playerMoneyCashUpdated)
		else
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
		end
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('deposited_to').title, interp(_L('deposited_to').text, {s1 = amount, s2 = societyName}), _L('deposited_to').time, _L('deposited_to').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, interp(_L('deposited_to').text, {s1 = amount, s2 = societyName}), _L('deposited_to').type)
		end
		TransferMoneyWebhook({sender_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, receiver_name = societyName..' ('..society..')', value = amount})
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('no_money_pocket').title, _L('no_money_pocket').text, _L('no_money_pocket').time, _L('no_money_pocket').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L('no_money_pocket').text, _L('no_money_pocket').type)
		end
	end
end)

RegisterServerEvent("okokBanking:WithdrawMoneyToSociety")
AddEventHandler("okokBanking:WithdrawMoneyToSociety", function(amount, society, societyName, societyMoney)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local db
	local hasChecked = false

	if Config.UseQBManagement then
		MySQL.Async.fetchAll('SELECT * FROM management_funds WHERE job_name = @job_name', {
			['@job_name'] = society,
		}, function(result)
			db = result[1]
			hasChecked = true
			db.value = db.amount
		end)
	else
		MySQL.query('SELECT * FROM okokbanking_societies WHERE society = @society', {
			['@society'] = society
		}, function(result)
			db = result[1]
			hasChecked = true
		end)
	end

	if not Config.UseQBManagement then
		MySQL.query('UPDATE okokbanking_societies SET is_withdrawing = 1 WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
		end)
	end

	while not hasChecked do 
		Citizen.Wait(100)
	end
	
	if amount <= db.value then
		if db.is_withdrawing == 1 then
			if Config.okokNotify then
				TriggerClientEvent('okokNotify:Alert', _source, _L('someone_withdrawing').title, _L('someone_withdrawing').text, _L('someone_withdrawing').time, _L('someone_withdrawing').type)
			else
				TriggerClientEvent('QBCore:Notify', _source, _L('someone_withdrawing').text, _L('someone_withdrawing').type)
			end
		else
			if Config.UseQBManagement then
				exports['qb-management']:RemoveMoneyOkokBanking(society, amount)
			else
				MySQL.query('UPDATE okokbanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
					['@value'] = amount,
					['@society'] = society,
					['@society_name'] = societyName,
				}, function(changed)
				end)
			end
			
			if Config.UseCashAsItem then
				xPlayer.Functions.AddItem('cash', amount)
			else
				xPlayer.Functions.AddMoney('cash', amount)
			end
			xPlayer = QBCore.Functions.GetPlayer(_source)
			local itemCash = xPlayer.Functions.GetItemByName("cash")
			local PlayerCashMoney = 0
			if itemCash ~= nil then
				PlayerCashMoney = itemCash.amount
			end
			TriggerEvent('okokBanking:AddWithdrawTransactionToSociety', amount, _source, society, societyName)
			if Config.UseCashAsItem then
				TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, PlayerCashMoney)
			else
				TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
			end
			if Config.okokNotify then
				TriggerClientEvent('okokNotify:Alert', _source, _L('you_have_withdrawn').title, interp(_L('you_have_withdrawn').text, {s1 = amount, s2 = societyName}), _L('you_have_withdrawn').time, _L('you_have_withdrawn').type)
			else
				TriggerClientEvent('QBCore:Notify', _source, interp(_L('you_have_withdrawn').text, {s1 = amount, s2 = societyName}), _L('you_have_withdrawn').type)
			end
			TransferMoneyWebhook({sender_name = societyName..' ('..society..')', receiver_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, value = amount})
		end
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('society_no_money').title, _L('society_no_money').text, _L('society_no_money').time, _L('society_no_money').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L('society_no_money').text, _L('society_no_money').type)
		end
	end

	if not Config.UseQBManagement then
		MySQL.query('UPDATE okokbanking_societies SET is_withdrawing = 0 WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
		end)
	end
end)

RegisterServerEvent("okokBanking:TransferMoneyToSociety")
AddEventHandler("okokBanking:TransferMoneyToSociety", function(amount, ibanNumber, societyName, society)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.bank

	if amount <= playerMoney then
		if Config.UseQBManagement then
			exports['qb-management']:TransferMoneyOkokBanking(society, amount, ibanNumber)
		else
			MySQL.query('UPDATE okokbanking_societies SET value = value + @value WHERE iban = @iban', {
				['@value'] = amount,
				['@iban'] = ibanNumber
			}, function(changed)
			end)
		end

		xPlayer.Functions.RemoveMoney('bank', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)
		local itemCash = xPlayer.Functions.GetItemByName("cash")
		local playerCashMoney = 0
		if itemCash ~= nil then
			playerCashMoney = itemCash.amount
		end
		TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, _source, society, societyName)
		if Config.UseCashAsItem then
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, playerCashMoney)
			TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, playerCashMoney)
			TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.PlayerData.money.bank, playerCashMoney)
		else
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
			TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
			TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		end
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('transferred_to').title, interp(_L('transferred_to').text, {s1 = amount, s2 = societyName}), _L('transferred_to').time, _L('transferred_to').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, interp(_L('transferred_to').text, {s1 = amount, s2 = societyName}), _L('transferred_to').type)
		end
		TransferMoneyWebhook({sender_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, receiver_name = societyName..' ('..society..')', value = amount})
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('no_money_bank').title, _L('no_money_bank').text, _L('no_money_bank').time, _L('no_money_bank').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L('no_money_bank').text, _L('no_money_bank').type)
		end
	end
end)

function getSocietyInfo(society, iban)
	local done = false
	local societyInfo = nil
	if Config.UseQBManagement then
		MySQL.query('SELECT * FROM management_funds WHERE job_name = @job_name', {
			['@job_name'] = society,
		}, function(result)
			local db = result[1]
			local aa
			if db ~= nil then
				if db.iban ~= nil then
					aa = {
						value = db.amount,
						society_name = db.job_name,
						society = db.job_name,
						iban = db.iban
					}
				else
					MySQL.query('UPDATE management_funds SET iban = @iban WHERE job_name = @job_name', {
						['@iban'] = string.gsub(iban:upper(), " ", ""),
						['@job_name'] = society,
					}, function(result2)
						local db2 = result2[1]
						if db2 ~= nil then
							aa = {
								value = db2.amount,
								society_name = db2.job_name,
								society = db2.job_name,
								iban = db2.iban
							}
						end
					end)
				end
			end
			societyInfo = aa
			done = true
		end)
	else
		MySQL.query('SELECT * FROM okokbanking_societies WHERE society = @society', {
			['@society'] = society
		}, function(result)
			local db = result[1]
			societyInfo = db
			done = true
		end)
	end
	while not done do
		Citizen.Wait(100)
	end
	return societyInfo
end

RegisterServerEvent("okokBanking:TransferMoneyToSocietyFromSociety")
AddEventHandler("okokBanking:TransferMoneyToSocietyFromSociety", function(amount, ibanNumber, societyNameTarget, societyTarget, society, societyName, societyMoney)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local itemCash = xPlayer.Functions.GetItemByName("cash")
	local playerCashMoney = 0
	if itemCash ~= nil then
		playerCashMoney = itemCash.amount
	end
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(targetIdentifier)
	local xPlayers = QBCore.Functions.GetPlayers()

	local societyInfo = getSocietyInfo(society, ibanNumber)

	if amount <= societyInfo.value then
		if Config.UseQBManagement then
			exports['qb-management']:AddMoneyOkokBanking(societyTarget, amount)
			exports['qb-management']:RemoveMoneyOkokBanking(society, amount)
		else
			MySQL.query('UPDATE okokbanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
				['@value'] = amount,
				['@society'] = society,
				['@society_name'] = societyName,
			}, function(changed)
				MySQL.query('UPDATE okokbanking_societies SET value = value + @value WHERE society = @society AND society_name = @society_name', {
					['@value'] = amount,
					['@society'] = societyTarget,
					['@society_name'] = societyNameTarget,
				}, function(changed)
				end)
			end)
		end
		
		TriggerEvent('okokBanking:AddTransferTransactionFromSociety', amount, society, societyName, societyTarget, societyNameTarget)
		if Config.UseCashAsItem then
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, playerCashMoney)
		else
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
		end
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('transferred_to').title, interp(_L('transferred_to').text, {s1 = amount, s2 = societyNameTarget}), _L('transferred_to').time, _L('transferred_to').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, interp(_L('transferred_to').text, {s1 = amount, s2 = societyNameTarget}), _L('transferred_to').type)
		end
		TransferMoneyWebhook({sender_name = societyName..' ('..society..')', receiver_name = societyNameTarget..' ('..societyTarget..')', value = amount})
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('society_no_money').title, _L('society_no_money').text, _L('society_no_money').time, _L('society_no_money').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L('society_no_money').text, _L('society_no_money').type)
		end
	end
end)

RegisterServerEvent("okokBanking:TransferMoneyToPlayerFromSociety")
AddEventHandler("okokBanking:TransferMoneyToPlayerFromSociety", function(amount, ibanNumber, targetIdentifier, acc, targetName, society, societyName, societyMoney, toMyself)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local itemCash = xPlayer.Functions.GetItemByName("cash")
	local playerCashMoney = 0
	if itemCash ~= nil then
		playerCashMoney = itemCash.amount
	end
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(targetIdentifier)
	local itemCashTarget = xTarget.Functions.GetItemByName("cash")
	local playerCashMoneyTarget = 0
	if itemCashTarget ~= nil then
		playerCashMoneyTarget = itemCashTarget.amount
	end
	local xPlayers = QBCore.Functions.GetPlayers()

	if amount <= societyMoney then
		if Config.UseQBManagement then
			exports['qb-management']:RemoveMoneyOkokBanking(society, amount)
		else
			MySQL.query('UPDATE okokbanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
				['@value'] = amount,
				['@society'] = society,
				['@society_name'] = societyName,
			}, function(changed)
			end)
		end
		if xTarget ~= nil then
			xTarget.Functions.AddMoney('bank', amount)
			if not toMyself then
				for i=1, #xPlayers, 1 do
					local xForPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
					if xForPlayer.PlayerData.citizenid == targetIdentifier then
						if Config.UseCashAsItem then
							TriggerClientEvent('okokBanking:updateTransactions', xPlayers[i], xTarget.PlayerData.money.bank, playerCashMoneyTarget)
						else
							TriggerClientEvent('okokBanking:updateTransactions', xPlayers[i], xTarget.PlayerData.money.bank, xTarget.PlayerData.money.cash)
						end
						if Config.okokNotify then
							TriggerClientEvent('okokNotify:Alert', xPlayers[i], _L('received_from').title, interp(_L('received_from').text, {s1 = amount, s2 = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname}), _L('received_from').time, _L('received_from').type)
						else
							TriggerClientEvent('QBCore:Notify', xPlayers[i], interp(_L('received_from').text, {s1 = amount, s2 = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname}), _L('received_from').type)
						end
					end
				end
			end
			TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', amount, society, societyName, targetIdentifier, targetName)
			if Config.UseCashAsItem then
				TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, playerCashMoney)
			else
				TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
			end
			if Config.okokNotify then
				TriggerClientEvent('okokNotify:Alert', _source, _L('transferred_to').title, interp(_L('transferred_to').text, {s1 = amount, s2 = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname}), _L('transferred_to').time, _L('transferred_to').type)
			else
				TriggerClientEvent('QBCore:Notify', _source, interp(_L('transferred_to').text, {s1 = amount, s2 = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname}), _L('transferred_to').type)
			end
			TransferMoneyWebhook({sender_name = societyName..' ('..society..')', receiver_name = xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname, value = amount})
		elseif xTarget == nil then
			local playerAccount = json.decode(acc)
			playerAccount.bank = playerAccount.bank + amount
			playerAccount = json.encode(playerAccount)

			TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', amount, society, societyName, targetIdentifier, targetName)
			if Config.UseCashAsItem then
				TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, playerCashMoney)
			else
				TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
			end
			if Config.okokNotify then
				TriggerClientEvent('okokNotify:Alert', _source, _L('transferred_to').title, interp(_L('transferred_to').text, {s1 = amount, s2 = targetName }), _L('transferred_to').time, _L('transferred_to').type)
			else
				TriggerClientEvent('QBCore:Notify', _source, interp(_L('transferred_to').text, {s1 = amount, s2 = targetName }), _L('transferred_to').type)
			end
			TransferMoneyWebhook({sender_name = societyName..' ('..society..')', receiver_name = targetName..' (Offline User)', value = amount})

			MySQL.query('UPDATE players SET money = @playerAccount WHERE citizenid = @target', {
				['@playerAccount'] = playerAccount,
				['@target'] = targetIdentifier
			}, function(changed)

			end)
		end
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('society_no_money').title, _L('society_no_money').text, _L('society_no_money').time, _L('society_no_money').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L('society_no_money').text, _L('society_no_money').type)
		end
	end
end)

QBCore.Functions.CreateCallback("okokBanking:GetOverviewTransactions", function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local playerIdentifier = xPlayer.PlayerData.citizenid
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	MySQL.query('SELECT * FROM okokbanking_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
		['@identifier'] = playerIdentifier
	}, function(result)
		MySQL.query('SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `okokbanking_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY AND receiver_identifier = @identifier OR sender_identifier = @identifier', {
			['@identifier'] = playerIdentifier
		}, function(result2)
			for k, v in pairs(result2) do
				local type = v.type
				local receiver_identifier = v.receiver_identifier
				local sender_identifier = v.sender_identifier
				local value = tonumber(v.value)

				if v.day1 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day1_total = day1_total + value
							income = income + value
						elseif type == "withdraw" then
							day1_total = day1_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day1_total = day1_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day1_total = day1_total - value
							outcome = outcome - value
						end
					end
					
				elseif v.day2 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day2_total = day2_total + value
							income = income + value
						elseif type == "withdraw" then
							day2_total = day2_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day2_total = day2_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day2_total = day2_total - value
							outcome = outcome - value
						end
					end

				elseif v.day3 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day3_total = day3_total + value
							income = income + value
						elseif type == "withdraw" then
							day3_total = day3_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day3_total = day3_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day3_total = day3_total - value
							outcome = outcome - value
						end
					end

				elseif v.day4 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day4_total = day4_total + value
							income = income + value
						elseif type == "withdraw" then
							day4_total = day4_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day4_total = day4_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day4_total = day4_total - value
							outcome = outcome - value
						end
					end

				elseif v.day5 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day5_total = day5_total + value
							income = income + value
						elseif type == "withdraw" then
							day5_total = day5_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day5_total = day5_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day5_total = day5_total - value
							outcome = outcome - value
						end
					end

				elseif v.day6 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day6_total = day6_total + value
							income = income + value
						elseif type == "withdraw" then
							day6_total = day6_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day6_total = day6_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day6_total = day6_total - value
							outcome = outcome - value
						end
					end

				elseif v.day7 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day7_total = day7_total + value
							income = income + value
						elseif type == "withdraw" then
							day7_total = day7_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day7_total = day7_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day7_total = day7_total - value
							outcome = outcome - value
						end
					end

				end
			end

			totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

			table.remove(allDays)
			table.insert(allDays, day1_total)
			table.insert(allDays, day2_total)
			table.insert(allDays, day3_total)
			table.insert(allDays, day4_total)
			table.insert(allDays, day5_total)
			table.insert(allDays, day6_total)
			table.insert(allDays, day7_total)
			table.insert(allDays, income)
			table.insert(allDays, outcome)
			table.insert(allDays, totalIncome)

			cb(result, playerIdentifier, allDays)
		end)
	end)
end)

QBCore.Functions.CreateCallback("okokBanking:GetSocietyTransactions", function(source, cb, society)
	local playerIdentifier = society
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	MySQL.query('SELECT * FROM okokbanking_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
		['@identifier'] = society
	}, function(result)
		MySQL.query('SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `okokbanking_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY AND receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
			['@identifier'] = society
		}, function(result2)
			for k, v in pairs(result2) do
				local type = v.type
				local receiver_identifier = v.receiver_identifier
				local sender_identifier = v.sender_identifier
				local value = tonumber(v.value)

				if v.day1 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day1_total = day1_total + value
							income = income + value
						elseif type == "withdraw" then
							day1_total = day1_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day1_total = day1_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day1_total = day1_total - value
							outcome = outcome - value
						end
					end
					
				elseif v.day2 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day2_total = day2_total + value
							income = income + value
						elseif type == "withdraw" then
							day2_total = day2_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day2_total = day2_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day2_total = day2_total - value
							outcome = outcome - value
						end
					end

				elseif v.day3 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day3_total = day3_total + value
							income = income + value
						elseif type == "withdraw" then
							day3_total = day3_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day3_total = day3_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day3_total = day3_total - value
							outcome = outcome - value
						end
					end

				elseif v.day4 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day4_total = day4_total + value
							income = income + value
						elseif type == "withdraw" then
							day4_total = day4_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day4_total = day4_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day4_total = day4_total - value
							outcome = outcome - value
						end
					end

				elseif v.day5 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day5_total = day5_total + value
							income = income + value
						elseif type == "withdraw" then
							day5_total = day5_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day5_total = day5_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day5_total = day5_total - value
							outcome = outcome - value
						end
					end

				elseif v.day6 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day6_total = day6_total + value
							income = income + value
						elseif type == "withdraw" then
							day6_total = day6_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day6_total = day6_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day6_total = day6_total - value
							outcome = outcome - value
						end
					end

				elseif v.day7 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day7_total = day7_total + value
							income = income + value
						elseif type == "withdraw" then
							day7_total = day7_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day7_total = day7_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day7_total = day7_total - value
							outcome = outcome - value
						end
					end

				end
			end

			totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

			table.remove(allDays)
			table.insert(allDays, day1_total)
			table.insert(allDays, day2_total)
			table.insert(allDays, day3_total)
			table.insert(allDays, day4_total)
			table.insert(allDays, day5_total)
			table.insert(allDays, day6_total)
			table.insert(allDays, day7_total)
			table.insert(allDays, income)
			table.insert(allDays, outcome)
			table.insert(allDays, totalIncome)

			cb(result, playerIdentifier, allDays)
		end)
	end)
end)


RegisterServerEvent("okokBanking:AddDepositTransaction")
AddEventHandler("okokBanking:AddDepositTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = 'bank',
		['@receiver_name'] = 'Bank Account',
		['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddWithdrawTransaction")
AddEventHandler("okokBanking:AddWithdrawTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@receiver_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@sender_identifier'] = 'bank',
		['@sender_name'] = 'Bank Account',
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransaction")
AddEventHandler("okokBanking:AddTransferTransaction", function(amount, xTarget, source_, targetName, targetIdentifier)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)
	if targetName == nil then
		MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(xTarget.PlayerData.citizenid),
			['@receiver_name'] = tostring(xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname),
			['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
			['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	elseif targetName ~= nil and targetIdentifier ~= nil then
		MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(targetIdentifier),
			['@receiver_name'] = tostring(targetName),
			['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
			['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	end
end)

RegisterServerEvent("okokBanking:AddTransferTransactionToSociety")
AddEventHandler("okokBanking:AddTransferTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)
	MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = society,
		['@receiver_name'] = societyName,
		['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransactionFromSocietyToP")
AddEventHandler("okokBanking:AddTransferTransactionFromSocietyToP", function(amount, society, societyName, identifier, name)

	MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = identifier,
		['@receiver_name'] = name,
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransactionFromSociety")
AddEventHandler("okokBanking:AddTransferTransactionFromSociety", function(amount, society, societyName, societyTarget, societyNameTarget)
	
	MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = societyTarget,
		['@receiver_name'] = societyNameTarget,
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddDepositTransactionToSociety")
AddEventHandler("okokBanking:AddDepositTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = society,
		['@receiver_name'] = societyName,
		['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddWithdrawTransactionToSociety")
AddEventHandler("okokBanking:AddWithdrawTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.query('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@receiver_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:UpdateIbanDB")
AddEventHandler("okokBanking:UpdateIbanDB", function(iban, amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if amount <= xPlayer.PlayerData.money.bank then
		MySQL.query('SELECT charinfo FROM players WHERE citizenid = ?', {
			xPlayer.PlayerData.citizenid
		}, function(result)
			if not Config.CharInfoUpdate then
				local charinfo = json.decode(result)
			else
				local charinfo = json.decode(result[1].charinfo)
			end
			charinfo.account = iban
			local updated = json.encode(charinfo)
			MySQL.query('UPDATE players SET charinfo = ? WHERE citizenid = ?', {updated, xPlayer.PlayerData.citizenid})
		end)
		xPlayer.Functions.ChangeIban(iban)
		xPlayer.Functions.RemoveMoney('bank', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)
		local itemCash = xPlayer.Functions.GetItemByName("cash")
		local playerCashMoney = 0
		if itemCash ~= nil then
			playerCashMoney = itemCash.amount
		end
		if Config.UseCashAsItem then
			TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.PlayerData.money.bank, playerCashMoney)
		else
			TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		end
		TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, _source, "bank", "Bank (IBAN)")
		TriggerClientEvent('okokBanking:updateIban', _source, iban)
		TriggerClientEvent('okokBanking:updateIbanPinChange', _source)
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('iban_changed').title, interp(_L('iban_changed').text, {s1 = iban}), _L('iban_changed').time, _L('iban_changed').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, interp(_L('iban_changed').text, {s1 = iban}), _L('iban_changed').type)
		end
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('iban_no_money').title, interp(_L('iban_no_money').text, {s1 = amount}), _L('iban_no_money').time, _L('iban_no_money').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, interp(_L('iban_no_money').text, {s1 = amount}), _L('iban_no_money').type)
		end
	end
end)

RegisterServerEvent("okokBanking:UpdatePINDB")
AddEventHandler("okokBanking:UpdatePINDB", function(pin, amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if amount <= xPlayer.PlayerData.money.bank then
		MySQL.query('UPDATE players SET pincode = @pin WHERE citizenid = @identifier', {
			['@pin'] = pin,
			['@identifier'] = xPlayer.PlayerData.citizenid,
		}, function(changed)
		end)

		xPlayer.Functions.RemoveMoney('bank', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)
		local itemCash = xPlayer.Functions.GetItemByName("cash")
		local playerCashMoney = 0
		if itemCash ~= nil then
			playerCashMoney = itemCash.amount
		end
		if Config.UseCashAsItem then
			TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.PlayerData.money.bank, playerCashMoney)
		else
			TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		end
		TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, _source, "bank", "Bank (PIN)")
		TriggerClientEvent('okokBanking:updateIbanPinChange', _source)
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('pin_changed').title, interp(_L('pin_changed').text, {s1 = pin}), _L('pin_changed').time, _L('pin_changed').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L("pin_changed", {s1 = pin}), _L('pin_changed').type)
		end
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('pin_no_money').title, interp(_L('pin_no_money').text, {s1 = amount}), _L('pin_no_money').time, _L('pin_no_money').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, interp(_L('pin_no_money').text, {s1 = amount}), _L('pin_no_money').type)
		end
	end
end)

RegisterServerEvent("okokBanking:AddNewTransaction")
AddEventHandler("okokBanking:AddNewTransaction", function(receiver_name, receiver_identifier, sender_name, sender_identifier, amount, reason)
	MySQL.Async.insert('INSERT INTO okokbanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = receiver_identifier,
		['@receiver_name'] = receiver_name.." ("..reason..")",
		['@sender_identifier'] = sender_identifier,
		['@sender_name'] = sender_name.." ("..reason..")",
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:GiveCC")
AddEventHandler("okokBanking:GiveCC", function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.bank
	local itemCash = xPlayer.Functions.GetItemByName("cash")
	local playerCashMoney = 0
	if itemCash ~= nil then
		playerCashMoney = itemCash.amount
	end

	if Config.CreditCardPrice <= playerMoney then
		xPlayer.Functions.RemoveMoney('bank', Config.CreditCardPrice)
		xPlayer.Functions.AddItem(Config.CreditCardItem, 1)
		TriggerEvent('okokBanking:AddNewTransaction', 'Bank', 'bank', tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname), xPlayer.PlayerData.citizenid, Config.CreditCardPrice, 'Buy CC')
		if Config.UseCashAsItem then
			TriggerClientEvent('okokBanking:updateTransactions', source, xPlayer.PlayerData.money.bank, playerCashMoney)
		else
			TriggerClientEvent('okokBanking:updateTransactions', source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		end
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('bought_cc').title, interp(_L('bought_cc').text, {s1 = Config.CreditCardPrice}), _L('bought_cc').time, _L('bought_cc').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, interp(_L('bought_cc').text, {s1 = Config.CreditCardPrice}), _L('bought_cc').type)
		end
	else
		if Config.okokNotify then
			TriggerClientEvent('okokNotify:Alert', _source, _L('no_money_bank').title, _L('no_money_bank').text, _L('no_money_bank').time, _L('no_money_bank').type)
		else
			TriggerClientEvent('QBCore:Notify', _source, _L('no_money_bank').text, _L('no_money_bank').type)
		end
	end
end)

function GroupDigits(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

-------------------------- WEBHOOK

function TransferMoneyWebhook(data)
	local information = {
		{
			["color"] = Config.TransferWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Banking Logs',
			},
			["title"] = 'New Transaction',
			["description"] = '**Sender:** '..data.sender_name..'\n**Receiver:** '..data.receiver_name..'\n**Amount:** '..data.value..'€',

			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end

function WithdrawMoneyWebhook(data)
	local information = {
		{
			["color"] = Config.WithdrawWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Banking Logs',
			},
			["title"] = 'New Withdrawal',
			["description"] = '**Receiver:** '..data.receiver_name..'\n**Amount:** '..data.value..'€',

			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end

function DepositMoneyWebhook(data)
	local information = {
		{
			["color"] = Config.DepositWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Banking Logs',
			},
			["title"] = 'New Deposit',
			["description"] = '**Sender:** '..data.sender_name..'\n**Amount:** '..data.value..'€',

			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end