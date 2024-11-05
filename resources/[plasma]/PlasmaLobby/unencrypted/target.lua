
if string.lower(WhichThirdEye) == "ox" then
	-- affError("Targetting set on QB-Target")
	function targetBoxZone(option)
		local targetID = 0
		targetID = exports.ox_target:addBoxZone(option)
		return targetID
	end

	function removeTargetBoxZone(targetID,targetName)
		exports.ox_target:removeZone(targetID)
	end

	function targetGlobalObject(option)
		local targetID = 0
		for k,v in pairs(option) do
			-- print("k : "..tostring(k).." v: "..tostring(v))
		end
		targetID = exports.ox_target:addGlobalObject( option )
		-- exports['qb-target']:AddGlobalObject(convert({options=option,distance = 2.5}))
		return targetID
	end

	function targetEntity(entity, option)
		local tempOption = {}
		local targetID = 0
		
		if NetworkDoesEntityExistWithNetworkId(entity) then
			aff("ox target networked")
			targetID = exports.ox_target:addEntity(entity, option)
		else
			aff("ox target local")
			targetID = exports.ox_target:addLocalEntity(entity, option)
		end
		return targetID
	end
end


if string.lower(WhichThirdEye) == "qb" then
	-- affError("Targetting set on QB-Target")
	function targetBoxZone(option)
		local name = option.name or "RandomName"
		local coords = option.coords
		local _,_,z = table.unpack(option.coords) 
		local sizeX,sizeY,sizeZ = table.unpack(option.size) 
		local minZ = z - (sizeZ/2)
		local maxZ = z + (sizeZ/2)
		local heading = option.rotation
		local targetID = 0

		
		
		
		local options = {}
		for k,v in pairs(option.options) do
			-- aff("Targetting k : "..tostring(k).." v: "..tostring(v))
			options[k] = v
			if v.serverEvent then
				options[k].type = "server"
				options[k].event = v.serverEvent 
			else
				options[k].type = "client"
				options[k].event = v.event 
			end
		end
		

		targetID = exports['qb-target']:AddBoxZone(name, coords, sizeY, sizeX, { -- The name has to be unique, the coords a vector3 as shown, the 1.5 is the length of the boxzone and the 1.6 is the width of the boxzone, the length and width have to be float values
		  name = name, -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
		  heading = heading, -- The heading of the boxzone, this has to be a float value
		  debugPoly = false, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
		  minZ = minZ, -- This is the bottom of the boxzone, this can be different from the Z value in the coords, this has to be a float value
		  maxZ = maxZ, -- This is the top of the boxzone, this can be different from the Z value in the coords, this has to be a float value
		}, {
		  options = options,
		  distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
		})

		return targetID, name
	end

	function removeTargetBoxZone(targetID,targetName)
		-- exports.ox_target:removeZone(targetID)
		exports['qb-target']:RemoveZone(targetName)
	end

	function targetGlobalObject(option)
		local targetID = 0

		local options = {}
		for k,v in pairs(option) do
			options[k] = v
			if v.serverEvent then
				options[k].type = "server"
				options[k].event = v.serverEvent 
			else
				options[k].type = "client"
				options[k].event = v.event 
			end
		end
		
		-- GetHashKey("pata_trolley")
		exports['qb-target']:AddTargetModel("pata_trolley", { -- This defines the models, can be a string or a table
		  options = options,
		  distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
		})
		return targetID
	end

	function targetEntity(entityID, option)
		local tempOption = {}
		local targetID = 0
		local entity = 0
		if NetworkDoesEntityExistWithNetworkId(entityID) then
			entity = NetworkGetEntityFromNetworkId(entityID)
		else
			entity = entityID
		end
		
		
		local options = {}
		for k,v in pairs(option) do
			options[k] = v
			if v.serverEvent then
				options[k].type = "server"
				options[k].event = v.serverEvent 
			else
				options[k].type = "client"
				options[k].event = v.event 
			end
		end
		
		exports['qb-target']:AddTargetEntity(entity, { -- The specified entity number
			options = options,
			distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
		  })
		return targetID
	end
end