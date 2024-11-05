local currentStatus = 'out'
local lastIsFreeze = false
local lastDict, lastAnim, netid, phoneProp, phoneModel = nil, nil, nil, nil, nil

local ANIMS = {
	['cellphone@'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_listen_base',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_call_out',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	},
	['anim@cellphone@in_car@ps'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_in',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_horizontal_exit',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	}
}

function newPhoneProp(model)
	phoneModel = model
	deletePhone()
	RequestModel(phoneModel)
	while not HasModelLoaded(phoneModel) do
		Wait(100)
	end
	phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)
	netid = ObjToNet(phoneProp)
	SetNetworkIdExistsOnAllMachines(netid, true)
	NetworkSetNetworkIdDynamic(netid, true)
	SetNetworkIdCanMigrate(netid, false)

	local bone = GetPedBoneIndex(PlayerPedId(), 28422)
	if phoneModel == `prop_cs_phone_01` then
		AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 50.0, 320.0, 50.0, 1, 1, 0, 0, 2, 1)
	else
		AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	end
end

function deletePhone()
	if netid then
		DetachEntity(NetToObj(netid), 1, 1)
		DeleteEntity(NetToObj(netid))
		phoneProp = nil
		netid = nil
	end
end

function LoadAnimation(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(1)
	end
end

function CancelPhoneAnim()
	local ped = PlayerPedId()
	local AnimationLib = 'cellphone@'
	local AnimationStatus = 'cellphone_call_listen_base'

	if IsPedInAnyVehicle(ped, false) then
		AnimationLib = 'anim@cellphone@in_car@ps'
	end

	if PhoneData.isOpen then
		AnimationStatus = 'cellphone_call_to_text'
	end

	LoadAnimation(AnimationLib)
	TaskPlayAnim(ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)

	if not PhoneData.isOpen then
		deletePhone()
	end
end

function DoPhoneAnimation(anim)
	local ped = PlayerPedId()
	local AnimationLib = 'cellphone@'
	local AnimationStatus = anim

	if IsPedInAnyVehicle(ped, false) then
		AnimationLib = 'anim@cellphone@in_car@ps'
	end

	LoadAnimation(AnimationLib)
	TaskPlayAnim(ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)

	PhoneData.AnimationData.lib = AnimationLib
	PhoneData.AnimationData.anim = AnimationStatus
end

function PhonePlayAnim(status, freeze, force)
	if currentStatus == status and force ~= true then
		return
	end

	myPedId = PlayerPedId()
	local freeze = freeze or false

	local dict = 'cellphone@'
	if IsPedInAnyVehicle(myPedId, false) then
		dict = 'anim@cellphone@in_car@ps'
	end
	loadAnimDict(dict)

	local anim = ANIMS[dict][currentStatus][status]
	if currentStatus ~= 'out' then
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end
	local flag = 50
	if freeze == true then
		flag = 14
	end
	TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

	if status ~= 'out' and currentStatus == 'out' then
		Wait(380)
		newPhoneProp()
	end

	lastDict = dict
	lastAnim = anim
	lastIsFreeze = freeze
	currentStatus = status

	if status == 'out' then
		Wait(180)
		deletePhone()
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end
end

function PhonePlayOut()
	PhonePlayAnim('out')
end

function PhonePlayText()
	PhonePlayAnim('text')
end

function PhonePlayCall(freeze)
	PhonePlayAnim('call', freeze)
end

function PhonePlayIn()
	if currentStatus == 'out' then
		PhonePlayText()
	end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(1)
	end
end
