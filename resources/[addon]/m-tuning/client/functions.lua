CreateThread(function()
    while not Core do
        Citizen.Wait(0)
    end
    if Config.Framework == "ESX" then
        createCallback = Core.TriggerServerCallback
    else
        createCallback = Core.Functions.TriggerCallback
    end
end)

LastEngineMultiplier = 1.0
function setVehData(veh,data)
    if not DoesEntityExist(veh) or not data then return nil end
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", tonumber(data.boost)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", tonumber(data.acceleration)   + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(data.gearchange)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", tonumber(data.drivetrain) + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", tonumber(data.breaking)   + 0.0 )
end

function setAdvancedData(veh,data, bool, three)
    newdata = nil
    if three then
        if data.vehicleData ~= nil then
            newdata = data
        else
            DefaultAdvancedData(veh, GetVehicleNumberPlateText(veh), data)
        end
    else
        if bool then
            newdata = data.vehicleData.Data
        else
            newdata = data
        end
    end

    if not DoesEntityExist(veh) or not newdata then return nil end
    TriggerServerEvent("m-tuning:CreateTableData", GetVehicleNumberPlateText(veh), newdata, "CurrentVehicleData")
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDownforceModifier", tonumber(newdata.vehicleData.downForceValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff", tonumber(newdata.vehicleData.airResistanceValue)  + 0.0 )
    -- CHASIS
    SetVehicleHandlingFloat(veh, "CHandlingData", "fMass", tonumber(newdata.vehicleData.fmassValue)  + 0.0 )
    -- ENGINE
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", tonumber(newdata.vehicleData.powerValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", tonumber(newdata.vehicleData.driveInertiaValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel", tonumber(newdata.vehicleData.topSpeedValue)  + 0.0 )
    -- TRANSMISSION
    SetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears", tonumber(newdata.vehicleData.ofGearsValue)) -- İnteger
    SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(newdata.vehicleData.shiftUpValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift", tonumber(newdata.vehicleData.shiftDownValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", tonumber(newdata.vehicleData.powerBiasValue) + 0.0)
    -- BRAKE
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", tonumber(newdata.vehicleData.brakeStrengthValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", tonumber(newdata.vehicleData.brakeBiasValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce", tonumber(newdata.vehicleData.handBrakeStrength)  + 0.0 )
    -- TRACTION
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax", tonumber(newdata.vehicleData.tireGripMaxValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin", tonumber(newdata.vehicleData.tireGripMinValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveLateral", tonumber(newdata.vehicleData.tractionCurveValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionBiasFront", tonumber(newdata.vehicleData.tireGripBiasValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionLossMult", tonumber(newdata.vehicleData.offRoadTractionValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult", tonumber(newdata.vehicleData.lowSpeedBurnoutValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock", tonumber(newdata.vehicleData.maxSteerAngleValue)  + 0.0 )
    -- SUSPENSION
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionForce", tonumber(newdata.vehicleData.springStrengthValue))
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionCompDamp", tonumber(newdata.vehicleData.springCompDampenStrengthValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionReboundDamp", tonumber(newdata.vehicleData.springReboundDampenStrengthValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionUpperLimit", tonumber(newdata.vehicleData.suspensionUpperLimitValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionLowerLimit", tonumber(newdata.vehicleData.suspensionLowerLimitValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionRaise", tonumber(newdata.vehicleData.suspensionRaiseValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionBiasFront", tonumber(newdata.vehicleData.strengthBiasValue)  + 0.0 )
    -- ANTIROLL
    SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarForce", tonumber(newdata.vehicleData.antirollStrengthValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarBiasFront", tonumber(newdata.vehicleData.antirollStrengthBiasValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront", tonumber(newdata.vehicleData.rollCentreFrontValue)  + 0.0 )
    SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightRear", tonumber(newdata.vehicleData.rollBackFrontValue)  + 0.0 )
end


function DefaultAdvancedData(veh,plate, GelenData)
    if GelenData ~= nil then
        data = GelenData
        if data ~= nil then 
            local tonum = tonumber(data.ofGearsValue)
            if not DoesEntityExist(veh) or not data then return nil end
            SetVehicleHandlingFloat(veh, "CHandlingData", "fDownforceModifier", tonumber(data.downForceValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff", tonumber(data.airResistanceValue)  + 0.0 )
            -- CHASIS
            SetVehicleHandlingFloat(veh, "CHandlingData", "fMass", tonumber(data.fmassValue)  + 0.0 )
            -- ENGINE
            SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", tonumber(data.powerValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", tonumber(data.driveInertiaValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel", tonumber(data.topSpeedValue)  + 0.0 )
            -- TRANSMISSION
            SetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears", math.floor(tonum)) -- İnteger
            SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(data.shiftUpValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift", tonumber(data.shiftDownValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", tonumber(data.powerBiasValue))
            -- BRAKE
            SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", tonumber(data.brakeStrengthValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", tonumber(data.brakeBiasValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce", tonumber(data.handBrakeStrength)  + 0.0 )
            -- TRACTION
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax", tonumber(data.tireGripMaxValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin", tonumber(data.tireGripMinValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveLateral", tonumber(data.tractionCurveValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionBiasFront", tonumber(data.tireGripBiasValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionLossMult", tonumber(data.offRoadTractionValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult", tonumber(data.lowSpeedBurnoutValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock", tonumber(data.maxSteerAngleValue)  + 0.0 )
            -- SUSPENSION
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionForce", tonumber(data.springStrengthValue))
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionCompDamp", tonumber(data.springCompDampenStrengthValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionReboundDamp", tonumber(data.springReboundDampenStrengthValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionUpperLimit", tonumber(data.suspensionUpperLimitValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionLowerLimit", tonumber(data.suspensionLowerLimitValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionRaise", tonumber(data.suspensionRaiseValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionBiasFront", tonumber(data.strengthBiasValue)  + 0.0 )
            -- ANTIROLL
            SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarForce", tonumber(data.antirollStrengthValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarBiasFront", tonumber(data.antirollStrengthBiasValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront", tonumber(data.rollCentreFrontValue)  + 0.0 )
            SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightRear", tonumber(data.rollBackFrontValue)  + 0.0 )
            TriggerServerEvent("m-tuning:CreateTableData", plate, data, "CurrentVehicleData")
        end
    else
        createCallback('m-tuning:sqlDta', function(data)

            if data ~= nil then 
                local tonum = tonumber(data.ofGearsValue)
                if not DoesEntityExist(veh) or not data then return nil end
                SetVehicleHandlingFloat(veh, "CHandlingData", "fDownforceModifier", tonumber(data.downForceValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff", tonumber(data.airResistanceValue)  + 0.0 )
                -- CHASIS
                SetVehicleHandlingFloat(veh, "CHandlingData", "fMass", tonumber(data.fmassValue)  + 0.0 )
                -- ENGINE
                SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", tonumber(data.powerValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", tonumber(data.driveInertiaValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel", tonumber(data.topSpeedValue)  + 0.0 )
                -- TRANSMISSION
                SetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears", math.floor(tonum)) -- İnteger
                SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(data.shiftUpValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift", tonumber(data.shiftDownValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", tonumber(data.powerBiasValue))
                -- BRAKE
                SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", tonumber(data.brakeStrengthValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", tonumber(data.brakeBiasValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce", tonumber(data.handBrakeStrength)  + 0.0 )
                -- TRACTION
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax", tonumber(data.tireGripMaxValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin", tonumber(data.tireGripMinValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveLateral", tonumber(data.tractionCurveValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionBiasFront", tonumber(data.tireGripBiasValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionLossMult", tonumber(data.offRoadTractionValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult", tonumber(data.lowSpeedBurnoutValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock", tonumber(data.maxSteerAngleValue)  + 0.0 )
                -- SUSPENSION
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionForce", tonumber(data.springStrengthValue))
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionCompDamp", tonumber(data.springCompDampenStrengthValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionReboundDamp", tonumber(data.springReboundDampenStrengthValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionUpperLimit", tonumber(data.suspensionUpperLimitValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionLowerLimit", tonumber(data.suspensionLowerLimitValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionRaise", tonumber(data.suspensionRaiseValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionBiasFront", tonumber(data.strengthBiasValue)  + 0.0 )
                -- ANTIROLL
                SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarForce", tonumber(data.antirollStrengthValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarBiasFront", tonumber(data.antirollStrengthBiasValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront", tonumber(data.rollCentreFrontValue)  + 0.0 )
                SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightRear", tonumber(data.rollBackFrontValue)  + 0.0 )
                TriggerServerEvent("m-tuning:CreateTableData", plate, data, "CurrentVehicleData")
            end
        end, plate, "DefaultData")
    end

end


local VehicleDefaultData = {}

function GetVehData(veh)
    VehicleDefaultData = {}
    VehicleDefaultData.downForceValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fDownforceModifier")
    VehicleDefaultData.airResistanceValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff")
    -- CHASIS
    VehicleDefaultData.fmassValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fMass")
    VehicleDefaultData.comValue = GetVehicleHandlingVector(veh, "CHandlingData", "vecCentreOfMassOffset") -- Vector
    VehicleDefaultData.inertiaValue = GetVehicleHandlingVector(veh, "CHandlingData", "vecInertiaMultiplier") -- Vector
    -- ENGINE
    VehicleDefaultData.powerValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce") 
    VehicleDefaultData.driveInertiaValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia") 
    VehicleDefaultData.topSpeedValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel") 
    -- TRANSMISSION
    VehicleDefaultData.ofGearsValue = GetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears") -- İnteger
    VehicleDefaultData.shiftUpValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift") 
    VehicleDefaultData.shiftDownValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift") 
    VehicleDefaultData.powerBiasValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront") 
    -- BRAKE
    VehicleDefaultData.brakeStrengthValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce") 
    VehicleDefaultData.brakeBiasValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront") 
    VehicleDefaultData.handBrakeStrength = GetVehicleHandlingFloat(veh, "CHandlingData", "fHandBrakeForce") 
    -- TRACTION
    VehicleDefaultData.tireGripMaxValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax") 
    VehicleDefaultData.tireGripMinValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin") 
    VehicleDefaultData.tractionCurveValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveLateral") 
    VehicleDefaultData.tireGripBiasValue= GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionBiasFront") 
    VehicleDefaultData.offRoadTractionValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fTractionLossMult") 
    VehicleDefaultData.lowSpeedBurnoutValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult") 
    VehicleDefaultData.maxSteerAngleValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock") 
    -- SUSPENSION
    VehicleDefaultData.springStrengthValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionForce") 
    VehicleDefaultData.springCompDampenStrengthValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionCompDamp") 
    VehicleDefaultData.springReboundDampenStrengthValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionReboundDamp") 
    VehicleDefaultData.suspensionUpperLimitValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionUpperLimit") 
    VehicleDefaultData.suspensionLowerLimitValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionLowerLimit") 
    VehicleDefaultData.suspensionRaiseValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionRaise") 
    VehicleDefaultData.strengthBiasValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fSuspensionBiasFront") 
    -- ANTIROLL
    VehicleDefaultData.antirollStrengthValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarForce") 
    VehicleDefaultData.antirollStrengthBiasValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fAntiRollBarBiasFront") 
    VehicleDefaultData.rollCentreFrontValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront") 
    VehicleDefaultData.rollBackFrontValue = GetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightRear") 
    return VehicleDefaultData
end



