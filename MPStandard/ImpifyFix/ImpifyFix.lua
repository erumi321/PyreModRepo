Deimpify = function ( objectId, type )

	if ImpifiedUnits[objectId] == nil then
		return
	end

	local characterData = GetCharacterTableByObjectId( objectId )

	if type ~= "DeathDispell" then
		PlayOverheadAnimation({ Name = "AuraExplosionFlare", DestinationId = objectId, IgnoreOverheadOffset = true, Scale = 2.0 })
		StopAnimation({ Name = "ImpFeralRoll", DestinationId = objectId, PreventChain = true })
		StopAnimation({ Name = "ImpFeralWalk", DestinationId = objectId, PreventChain = true })
		PlayAnimation({ Name = characterData["Archetype"].."Idle", DestinationId = objectId })
		PlaySound({ Name = "/SFX/Leftovers/PlayerOnHit", DestinationId = objectId })
	end

	local graphicsTable = ImpifiedUnits[objectId]["Graphics"]
	for graphicType, graphicName in pairs(graphicsTable) do
		if graphicName == "ImpulsedAnimation" or graphicName == "TouchdownGraphic" then
			if graphicType == nil then
				SetThingProperty({ DestinationId = objectId, Name = graphicType, Value = "null" })
			else
				SetThingProperty({ DestinationId = objectId, Name = graphicType, Value = graphicName })
			end
		else
			if graphicType == nil then
				SetUnitProperty({ DestinationId = objectId, Name = graphicType, Value = "null" })
			else
				SetUnitProperty({ DestinationId = objectId, Name = graphicType, Value = graphicName })
			end
		end
	end

	local weaponsTable = ImpifiedUnits[objectId]["Weapons"]
	for weaponType, weaponName in pairs(weaponsTable) do
		SetWeaponProperty({ DestinationId = objectId, WeaponName = weaponName, PropertyName = "Enabled", Value = true })
	end

	SetLifeProperty({ Name = "DeathGraphic", DestinationId = objectId, Value = ImpifiedUnits[objectId]["LifeProperties"]["DeathGraphic"] })

	local playerSpeedStat = characterData["PlayerAttributeSpeed"]
	local characterSpeed = SpeedStatTable[playerSpeedStat]
	if characterData["Archetype"] == "PlayerLarge" then
		local characterMinMovingSpeed = 165
		--FV1
		--local characterAcceleration = (characterSpeed - characterMinMovingSpeed)
		characterAcceleration = ImpifiedUnits[objectId]["Acceleration"]
		SetUnitProperty({ Name = "MinMovingSpeed", Value = characterMinMovingSpeed, DestinationId = objectId })
		SetUnitProperty({ Name = "Acceleration", Value = characterAcceleration, DestinationId = objectId })
	end
	SetUnitProperty({ Name = "Speed", Value = characterSpeed, DestinationId = objectId })
	--FV1 change
	--SetThingProperty({ DestinationId = objectId, Name = "OverheadOffset", Value = GetThingDataValue({  Id = objectId, Property = "OverheadOffset" }) })
	SetThingProperty({ DestinationId = objectId, Name = "OverheadOffset", Value = ImpifiedUnits[objectId]["OverheadOffset"] })
	UpdateBallScale()
	ImpifiedUnits[objectId] = nil
end

ImpifiedUnits = { }
Impify = function( objectId )

	--ImpifiedUnits[objectId] = { }
	ImpifiedUnits[objectId] = { Weapons = { }, Graphics = { }, LifeProperties = { }, OverheadOffset = 0 }
	local characterData = GetCharacterTableByObjectId( objectId )
	if characterData == nil then
		return
	end

	PlayOverheadAnimation({ Name = "AuraExplosionFlare", DestinationId = objectId, IgnoreOverheadOffset = true, Scale = 2.0 })
	PlayAnimation({ Name = "ImpFeralRollSpecial", DestinationId = objectId })
	PlaySound({ Name = "/SFX/Match SFX/AuraPerfectThrow", Id = objectId })

	ImpifiedUnits[objectId]["Graphics"]["StartGraphic"] = GetUnitDataStringValue({ Id = objectId, Property = "StartGraphic" })
	ImpifiedUnits[objectId]["Graphics"]["MoveGraphic"] = GetUnitDataStringValue({ Id = objectId, Property = "MoveGraphic" })
	ImpifiedUnits[objectId]["Graphics"]["StopGraphic"] = GetUnitDataStringValue({ Id = objectId, Property = "StopGraphic" })
	ImpifiedUnits[objectId]["Graphics"]["Graphic"] = GetUnitDataStringValue({ Id = objectId, Property = "Graphic" })
	ImpifiedUnits[objectId]["Graphics"]["ReceiveAnimation"] = GetUnitDataStringValue({ Id = objectId, Property = "ReceiveAnimation" })
	ImpifiedUnits[objectId]["Graphics"]["PassAnimation"] = GetUnitDataStringValue({ Id = objectId, Property = "PassAnimation" })
	ImpifiedUnits[objectId]["Graphics"]["ImpulsedAnimation"] = GetThingDataValue({ Id = objectId, Property = "ImpulsedAnimation" })
	ImpifiedUnits[objectId]["Graphics"]["TouchdownGraphic"] = GetThingDataValue({ Id = objectId, Property = "TouchdownGraphic" })
	--FV1
	ImpifiedUnits[objectId]["OverheadOffset"] = GetThingDataValue({ Id = objectId, Property = "OverheadOffset" })
	ImpifiedUnits[objectId]["Acceleration"] = GetThingDataValue({ Id = objectId, Property = "Acceleration" })

	if ImpifiedUnits[objectId]["Graphics"]["StartGraphic"] then
		SetUnitProperty({ DestinationId = objectId, Name = "StartGraphic", Value = "null" })
	end
	if ImpifiedUnits[objectId]["Graphics"]["MoveGraphic"] then
		SetUnitProperty({ DestinationId = objectId, Name = "MoveGraphic", Value = "null" })
	end
	if ImpifiedUnits[objectId]["Graphics"]["StopGraphic"] then
		SetUnitProperty({ DestinationId = objectId, Name = "StopGraphic", Value = "null" })
	end
	if ImpifiedUnits[objectId]["Graphics"]["Graphic"] then
		SetUnitProperty({ DestinationId = objectId, Name = "Graphic", Value = "ImpFeralWalkSpecial" })
	end
	if ImpifiedUnits[objectId]["Graphics"]["ReceiveAnimation"] then
		SetUnitProperty({ DestinationId = objectId, Name = "ReceiveAnimation", Value = "null" })
	end
	if ImpifiedUnits[objectId]["Graphics"]["PassAnimation"] then
		SetUnitProperty({ DestinationId = objectId, Name = "PassAnimation", Value = "null" })
	end
	if ImpifiedUnits[objectId]["Graphics"]["ImpulsedAnimation"] then
		SetThingProperty({ DestinationId = objectId, Name = "ImpulsedAnimation", Value = "null" })
	end
	if ImpifiedUnits[objectId]["Graphics"]["TouchdownGraphic"] then
		SetThingProperty({ DestinationId = objectId, Name = "TouchdownGraphic", Value = "null" })
	end

	local equippedAura = GetUnitDataStringValue({ Id = objectId, Property = "ContinuousWeapon" })
	local equippedThrowWeapon = GetUnitDataStringValue({ Id = objectId, Property = "ThrowWeapon" })
	local equippedCastWeapon = "Cast"..ArchetypeData[characterData.Archetype]["WeaponSuffix"]
	local equippedJumpWeapon = "Jump"..ArchetypeData[characterData.Archetype]["WeaponSuffix"]
	local equippedSprintWeapon = "Sprint"..ArchetypeData[characterData.Archetype]["WeaponSuffix"]

	ImpifiedUnits[objectId]["Weapons"]["ContinuousWeapon"] = equippedAura
	ImpifiedUnits[objectId]["Weapons"]["ThrowWeapon"] = equippedThrowWeapon
	ImpifiedUnits[objectId]["Weapons"]["CastWeapon"] = equippedCastWeapon
	ImpifiedUnits[objectId]["Weapons"]["JumpWeapon"] = equippedJumpWeapon
	ImpifiedUnits[objectId]["Weapons"]["SprintWeapon"] = equippedSprintWeapon

	SetWeaponProperty({ DestinationId = objectId, WeaponName = equippedAura, PropertyName = "Enabled", Value = false  })
	SetWeaponProperty({ DestinationId = objectId, WeaponName = equippedThrowWeapon, PropertyName = "Enabled", Value = false  })
	SetWeaponProperty({ DestinationId = objectId, WeaponName = equippedCastWeapon, PropertyName = "Enabled", Value = false  })
	SetWeaponProperty({ DestinationId = objectId, WeaponName = equippedJumpWeapon, PropertyName = "Enabled", Value = false  })
	SetWeaponProperty({ DestinationId = objectId, WeaponName = equippedSprintWeapon, PropertyName = "Enabled", Value = false  })

	ImpifiedUnits[objectId]["LifeProperties"]["DeathGraphic"] = GetLifeDataValue({ Id = objectId, Property = "DeathGraphic" })
	SetLifeProperty({ Name = "DeathGraphic", DestinationId = objectId, Value = "ImpFeralDeath" })

	SetThingProperty({ DestinationId = objectId, Name = "OverheadOffset", Value = 300 })

	SetUnitProperty({ DestinationId = objectId, Name = "Speed", Value = 700 })
	UpdateBallScale()

	ExpireAllFluid({ Id = objectId })
end