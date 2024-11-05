Config, Locales = {}, {}

Config.Locale = 'en' -- en / pt / gr / fr / de

Config.okokNotify = false -- true = okokNotify | false = QBCore Notify

Config.okokTextUI = false -- true = okokTextUI | false = QBCore DrawText

Config.UseOkOkBankingSounds = false -- true = Uses Sounds | false = No sounds

Config.UseTargetOnAtm = true -- Using qb-target and not TextUI to access to the atms

Config.UseTargetOnBank = true -- Using qb-target or q-target and not TextUI to access to the bank

Config.TargetBankDistance = 1.5 -- Distance to target a bank from qb-target ( To change the distance to ATM check line 61)

Config.DebugTargetZones = false -- Set to true only if you need to check the position of a zone

Config.UseCashAsItem = false -- Set to true if you have cash as item on qb-core

Config.IBANPrefix = "OK" -- IBAN prefix

Config.IBANNumbers = 6 -- How many characters the IBAN has by default

Config.CustomIBANMaxChars = 10 -- How many characters the IBAN can have when changing it to a custom one (on Settings tab)

Config.CustomIBANAllowLetters = true -- If the custom IBAN can have letters or only numbers (on Settings tab)

Config.IBANChangeCost = 5000 -- How much it costs to change the IBAN to a custom one (on Settings tab)

Config.PINChangeCost = 1000 -- How much it costs to change the PIN (on Settings tab)

Config.AnimTime = 2 -- Seconds (ATM animation)

Config.UseQBManagement = false -- If true it will use the management_funds table | If false the okokbanking_societies table

Config.RequireCreditCardForATM = false -- Set to true if you would like players to access the ATM with a card item | If false there is no item requirement

Config.CreditCardItem = "creditcard" -- Required item to access the ATM

Config.CreditCardPrice = 100 -- How much it costs to purchase a credit card

Config.Societies = { -- Which societies have bank accounts
	"police",
	"ambulance",
}

Config.ShowBankBlips = true -- True = show bank blips on the map | false = don't show blips

Config.BankLocations = { -- To get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
	{blip = 108, blipColor = 2, blipScale = 0.9, x = 150.266, y = -1040.203, z = 29.374, blipText = "Bank", BankDistance = 3, boxZone = {pos = vec3(149.07, -1041.02, 29.55), size = vec3(2.85, 0.30, 1.30), rotation = 70, maxZ = 30.9}},
	{blip = 108, blipColor = 2, blipScale = 0.9, x = -1212.980, y = -330.841, z = 37.787, blipText = "Bank", BankDistance = 3, boxZone = {pos = vec3(-1212.98, -331.53, 38.0), size = vec3(2.85, 0.40, 1.30), rotation = 117, maxZ = 39.25}},
	{blip = 108, blipColor = 2, blipScale = 0.9, x = -2962.582, y = 482.627, z = 15.703, blipText = "Bank", BankDistance = 3, boxZone = {pos = vec3(-2962.00, 482.20, 15.92), size = vec3(2.85, 0.40, 1.30), rotation = 178, maxZ = 17.1}},
	{blip = 108, blipColor = 2, blipScale = 0.9, x = -112.202, y = 6469.295, z = 31.626, blipText = "Bank", BankDistance = 3, boxZone = {pos = vec3(-111.69, 6469.5, 31.83), size = vec3(4.2, 0.40, 1.25), rotation = 45, maxZ = 33.15}},
	{blip = 108, blipColor = 2, blipScale = 0.9, x = 314.187, y = -278.621, z = 54.170, blipText = "Bank", BankDistance = 3, boxZone = {pos = vec3(313.26, -279.38, 54.35), size = vec3(2.85, 0.40, 1.30), rotation = 250, maxZ = 55.7}},
	{blip = 108, blipColor = 2, blipScale = 0.9, x = -351.534, y = -49.529, z = 49.042, blipText = "Bank", BankDistance = 3, boxZone = {pos = vec3(-351.81, -50.2, 49.24), size = vec3(2.85, 0.30, 1.30), rotation = 250, maxZ = 50.5}},
	{blip = 108, blipColor = 3, blipScale = 1.2, x = 253.38, y = 220.79, z = 106.29, blipText = "Bank", BankDistance = 3, boxZone = {pos = vec3(252.8, 221.9, 106.20), size = vec3(3.6, 0.20, 1.70), rotation = 250, maxZ = 107.6}},
	{blip = 108, blipColor = 2, blipScale = 0.9, x = 1175.064, y = 2706.643, z = 38.094, blipText = "Bank", BankDistance = 3, boxZone = {pos = vec3(1175.72, 2707.36, 38.30), size = vec3(2.85, 0.40, 1.30), rotation = 270, maxZ = 39.5}},
}

Config.ATMDistance = 1.5 -- How close you need to be in order to access the ATM

Config.ATM = { -- ATM models, do not remove any
	{model = -870868698},
	{model = -1126237515},
	{model = -1364697528},
	{model = 506770882}
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 2

Config.BotName = 'ServerName' -- Write the desired bot name

Config.ServerName = 'ServerName' -- Write your server's name

Config.IconURL = '' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.TransferWebhookColor = '16127'

Config.WithdrawWebhookColor = '16127'

Config.DepositWebhookColor = '16127'

-------------------------- LOCALES (DON'T TOUCH)

function _L(id)
	if Locales[Config.Locale][id] then
		return Locales[Config.Locale][id]
	else
		print("Locale '"..id.."' doesn't exist")
	end
end