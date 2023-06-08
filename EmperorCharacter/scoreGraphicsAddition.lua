OnAnyLoad{function(triggerArgs)
	VaporizeGraphics["PlayerEmperor"] = { ScoreGraphic = "PlayerMediumScorePose", OpacityDelay = 2.4, TeleportOffsetX = 0, TeleportOffsetY = 0}
	BallScale["PlayerEmperor"] = 0.80
end}
ModUtil.BaseOverride("PlayerTaunt", function ( tauntingPlayer, skipInputRule )
TauntParameters =
{
	["PlayerSmall"] = { MaxTauntVelocity = 700, TauntCooldown = 1.3 },
	["PlayerMedium"] = { MaxTauntVelocity = 500, TauntCooldown = 2.5, TauntRumble = 0.2, TauntRumbleDuration = 0.2, TauntRumbleDelay = 2.2 },
	["PlayerLarge"] = { MaxTauntVelocity = 260, VelocityHalt = true, TauntCooldown = 3.5 },
	["PlayerMediumAlt"] = { MaxTauntVelocity = 500, TauntCooldown = 2.0 },
	["PlayerImp"] = { MaxTauntVelocity = 1, TauntCooldown = 2.0 },
	["PlayerTrail"] = { MaxTauntVelocity = 1, TauntCooldown = 2.0 },
	["PlayerFlying"] = { MaxTauntVelocity = 1, TauntCooldown = 2.0 },
	["PlayerMonster"] = { MaxTauntVelocity = 300, TauntCooldown = 2.0 },
	["PlayerTree"] = { MaxTauntVelocity = 1, TauntCooldown = 2.0 },
	["PlayerEmperor"] = {  MaxTauntVelocity = 300, TauntCooldown = 2.0 },
}
	if not skipInputRule then

		if introMatch then
			return
		end

		if IsControlDown({ Names = { "Sprint", "Jump", "Cast" }, PlayerIndex = tauntingPlayer }) then
			return
		end

		if not IsInputAllowed({ PlayerIndex = tauntingPlayer }) then
			return
		end
	end

	local currentTauntingUnit = GetActiveUnitId({ PlayerIndex = tauntingPlayer })
	local currentTauntingUnitData = GetCharacterTableByObjectId( currentTauntingUnit )
	local currentTauntingUnitParameters = TauntParameters[currentTauntingUnitData.Archetype]
	local tauntingUnitTeam = GetTeamByCharacterId( currentTauntingUnit )

	if currentTauntingUnitData == nil then
		return
	end

	if not CheckUnitAlive( currentTauntingUnit ) then
		return
	end

	if ImpifiedUnits[currentTauntingUnit] and not UnitHasSkill(currentTauntingUnitData, "TauntFeralImp") then
		return
	end

	local velocity = GetVelocity({ Id = currentTauntingUnit })
	local maxVelocity = currentTauntingUnitParameters.MaxTauntVelocity or 999999
	if velocity > maxVelocity then
		return
	end

	if GetZLocation({ Id = currentTauntingUnit }) > 1 then
		return
	end

	if ThrowingUnits[currentTauntingUnit] then
		return
	end

	if TauntCooldowns[currentTauntingUnit] then
		return
	end
	TauntCooldowns[currentTauntingUnit] = true

	if IsMoving({ Id = currentTauntingUnit }) then
		Stop({ Id = currentTauntingUnit })
	end

	if currentTauntingUnitParameters.VelocityHalt then
		Halt({ Id = currentTauntingUnit })
	end

	tauntingUnitTeam.LastTauntTime = _worldTime

	-- SFX
	if currentTauntingUnitData.Archetype == "PlayerSmall" then
		-- do nothing
	elseif currentTauntingUnitData.Archetype == "PlayerMedium" or currentTauntingUnitData.Archetype == "PlayerMediumAlt" then
		thread( EmoteTauntingMedium, currentTauntingUnitData.VoicePrefix, currentTauntingUnitData, tauntingUnitTeam )
	elseif currentTauntingUnitData.Archetype == "PlayerLarge" and currentTauntingUnitData.StartingTrait ~= "Nightwing01" then
		thread( EmoteTauntingLarge, currentTauntingUnitData.VoicePrefix, currentTauntingUnit )
	else
		thread( EmoteTaunting, currentTauntingUnitData.VoicePrefix, currentTauntingUnit )
	end

	-- taunt escape skill
	if TauntEscapees[currentTauntingUnit] then
		return
	end
	if UnitHasSkill(currentTauntingUnitData, "TauntEscape") then
		thread(CheckTauntEscape, currentTauntingUnit)
	end

	if not TauntEscapees[currentTauntingUnit] then
		if UnitHasSkill(currentTauntingUnitData, "TauntAreaFumble") then
			PlayAnimation({ Name = ArchetypeData[currentTauntingUnitData.Archetype].TauntAlternateAnimation, DestinationId = currentTauntingUnit })
			thread( SkillProcFeedback, currentTauntingUnit, "TauntAreaFumble", nil, nil, 0.3 )
		elseif currentTauntingUnitData.SpecialTauntAnimation then
			PlayAnimation({ Name = currentTauntingUnitData.SpecialTauntAnimation, DestinationId = currentTauntingUnit })
			--thread(GiveOnUnitFeedback, currentTauntingUnit, "MatchMessage_Taunt", nil, nil, 0.3 )
		else
			PlayAnimation({ Name = ArchetypeData[currentTauntingUnitData.Archetype].TauntAnimation, DestinationId = currentTauntingUnit })
			--thread(GiveOnUnitFeedback, currentTauntingUnit, "MatchMessage_Taunt", nil, nil, 0.3 )
		end
	end

	if UnitHasSkill(currentTauntingUnitData, "TauntTimeout") then
		Rumble({ Fraction = currentTauntingUnitParameters.TauntRumble, Duration = currentTauntingUnitParameters.TauntRumbleDuration, Delay = currentTauntingUnitParameters.TauntRumbleDelay })
		CheckTauntStun( currentTauntingUnit )
		TauntCooldowns[currentTauntingUnit] = false
	end

	if UnitHasSkill(currentTauntingUnitData, "TauntFeralImp") then
		Rumble({ Fraction = currentTauntingUnitParameters.TauntRumble, Duration = currentTauntingUnitParameters.TauntRumbleDuration, Delay = currentTauntingUnitParameters.TauntRumbleDelay })
		CheckTauntFeralImp( currentTauntingUnit )
		TauntCooldowns[currentTauntingUnit] = false
		return
	end

	if UnitHasSkill(currentTauntingUnitData, "TauntSwap") then
		Rumble({ Fraction = currentTauntingUnitParameters.TauntRumble, Duration = currentTauntingUnitParameters.TauntRumbleDuration, Delay = currentTauntingUnitParameters.TauntRumbleDelay })
		CheckTauntSwap( currentTauntingUnit )
		TauntCooldowns[currentTauntingUnit] = false
		return
	end

	if UnitHasSkill(currentTauntingUnitData, "TauntBallTeleport") then
		Rumble({ Fraction = currentTauntingUnitParameters.TauntRumble, Duration = currentTauntingUnitParameters.TauntRumbleDuration, Delay = currentTauntingUnitParameters.TauntRumbleDelay })
		if CheckTauntBallTeleport( currentTauntingUnit ) then
			TauntCooldowns[currentTauntingUnit] = false
			return
		end
	end

	if UnitHasSkill(currentTauntingUnitData, "TauntSaplingExplode" ) then
		CheckTauntSaplingExplode( currentTauntingUnitData )
	end

	if currentTauntingUnitData.Archetype == "PlayerLarge" then
		thread( SpecialDemonTaunt, currentTauntingUnit, "overrideTaunt" )
	end

	if currentTauntingUnitParameters.TauntRumble ~= nil then
		Rumble({ Fraction = currentTauntingUnitParameters.TauntRumble, Duration = currentTauntingUnitParameters.TauntRumbleDuration, Delay = currentTauntingUnitParameters.TauntRumbleDelay })
	end

	thread(CheckTauntSkills, currentTauntingUnit )
	wait(currentTauntingUnitParameters.TauntCooldown)
	TauntCooldowns[currentTauntingUnit] = false

end, EmperorCustomChar)
ModUtil.BaseOverride("DistributeTeamSkills", function (team)
local empSkillsToDistribute =
{
	"TeamBallSkill", "TeamStaminaRechargeSkill","EmperorStealSpeedSkill","EmperorTeamStaminaUpSkill",
}

local empTeamSkills =
{
	"TeamBallSkill", "TeamStaminaRechargeSkill",
	"BetterBeacon", "TauntSaplingExplode", "TeamEnemyBanishTime", "TeamReviveSkill",
	"TeamHeadWinds", "SoleUnitPowerUp", "AllDeadRespawnTeam", "PyreLastHitRegenerateTeam",
	"LosingScoreScoreDebuff", "LosingBallPosition","EmperorStealSpeedSkill","EmperorTeamStaminaUpSkill",
}
	for i, teamSkillName in pairs( empTeamSkills ) do
		for k, character in pairs( team.AssignedCharacters ) do
			if UnitHasSkill( character, teamSkillName ) then
				team.TeamSkills[teamSkillName] = true
			end
		end
	end

	for i, skillName in pairs( empSkillsToDistribute ) do
		if TeamHasSkillDrafted( team, skillName ) then
			for j, character in pairs( team.AssignedCharacters ) do
				if not UnitHasSkill( character, skillName ) then
					ApplyUpgrade({ Name = skillName, DestinationId = character.ObjectId })
				end
			end
		end
	end
end, EmperorCustomChar)
OnDestroyAny{ "TeamA TeamB", function( triggerArgs )

	if triggerArgs.triggeredById == nil then
		return
	end

	if ImpifiedUnits[triggerArgs.triggeredById] then
		FireWeapon({ Name = "ImpifyDeathWeapon", DestinationId = triggerArgs.triggeredById })
		Deimpify( triggerArgs.triggeredById, "DeathDispell" )
	end

	if deathPoolActive then
		CheckDeathPools( triggerArgs.triggeredById, triggerArgs.KillerId )
	end

	local deadCharTeam = GetMatchTeamByCharacterId( triggerArgs.triggeredById )
	local deadPlayerObjectId = triggerArgs.triggeredById
	local deadPlayer = CharacterCache[triggerArgs.triggeredById]
	local deathWeapon = triggerArgs.name
	local booker = triggerArgs.KillerId
	local killingPlayer = CharacterCache[booker]

	if deadPlayer == nil and killingPlayer == nil then
		return
	end

	local perfectKill = false
	if triggerArgs.IsPerfectCharge then
		perfectKill = true
	end

	if deadPlayer == nil then
		CheckKillSkills( killingPlayer, deathWeapon, nil, deadPlayerObjectId, perfectKill )
		return
	end
	deadPlayer.LastDeathTime = _worldTime

	-- tutorial nonsense
	if fakeJumpPresentation then
		DisableInput({ PlayerIndex = 1 })
		Teleport({ Id = deadPlayerObjectId, DestinationId = 40011 })
		AngleTowardTarget({ Id = deadPlayerObjectId, DestinationId = goalB })
		Revive({ Id = deadPlayerObjectId, Delay = 0.3 })
		SetOpacity({ Id = deadPlayerObjectId, Fraction = 1, Duration = 0.2, Delay = 0.3 })
		PlayOverheadAnimation({ Name = "DraftPickedGlow", DestinationId = deadPlayerObjectId })
		EnableInput({ PlayerIndex = 1, Delay = 0.3 })
		thread( PlayIntroMatchSpeech, "jumpfail" )
		if timesJumpFailed >= 5 then -- this is counted in AudioScripts
			thread(MakeJumpTutorialGoalEasier)
		end
		return
	end
	local addAmount = 0
	local empChar = nil
	local empIndex = nil
	for i,v in pairs(deadCharTeam.ObjectIds) do 
		local curChar = deadCharTeam.AssignedCharacters[i]
		if curChar.RespawnTimer > 0 then
		addAmount = addAmount + 1
		else
		if UnitHasSkill(curChar, "EmperorTeamBanishUpSkill") then
			empChar = curChar
			empIndex = v
		end
		end
	end
	if empChar ~= nil then
		local auraValue = empChar.PlayerAttributeAura
			auraValue = auraValue + (3 * addAmount)
			auraValue = Clamp( auraValue, 1, 40 )
			local playerSpeedStat = empChar.PlayerAttributeSpeed
			playerSpeedStat = playerSpeedStat + (3*addAmount)
			playerSpeedStat = Clamp( playerSpeedStat, 1, 40 )
			local characterSpeed = SpeedStatTable[playerSpeedStat]
			SetUnitProperty({ Name = "Speed", Value = characterSpeed, DestinationId = empIndex })
			ApplyUpgrade({ Name = "Aura_"..auraValue, DestinationId = empIndex })
	end
end }

OnRevive{function(triggerArgs)
	local reviveCharTeam = GetMatchTeamByCharacterId( triggerArgs.triggeredById )
	local addAmount = 0
	local empChar = nil
	local empIndex = nil
	for i,v in pairs(reviveCharTeam.ObjectIds) do 
		local curChar = reviveCharTeam.AssignedCharacters[i]
		if curChar.RespawnTimer > 0 then
		addAmount = addAmount + 1
		else
		if UnitHasSkill(curChar, "EmperorTeamBanishUpSkill") then
			empChar = curChar
			empIndex = v
		end
		end
	end
	if empChar ~= nil then
		local auraValue = empChar.PlayerAttributeAura
			auraValue = auraValue + (3 * addAmount)
			auraValue = Clamp( auraValue, 1, 40 )
			local playerSpeedStat = empChar.PlayerAttributeSpeed
			playerSpeedStat = playerSpeedStat + (3 * addAmount)
			playerSpeedStat = Clamp( playerSpeedStat, 1, 40 )
			local characterSpeed = SpeedStatTable[playerSpeedStat]
			SetUnitProperty({ Name = "Speed", Value = characterSpeed, DestinationId = empIndex })
			ApplyUpgrade({ Name = "Aura_"..auraValue, DestinationId = empIndex })
	end
	end
}
OnActiveUnitChanged
{
	function( triggerArgs )

		local SelectedCharacter = GetMatchTeamByCharacterId(GetCharacterTableByObjectId( triggerArgs.triggeredById ).ObjectId)

		if not someoneScored then
			local team = GetMatchTeamByCharacterId( triggerArgs.triggeredById )
			local DoApply = false
			local dontApplyTo = 0
			local hasBall = false
			local newControlId = triggerArgs.triggeredById
			local currentPossessorId = BallCarrierId
			if currentPossessorId == newControlId then
				hasBall = true
			end
			for i,v in pairs(team.ObjectIds) do 
				local curChar = team.AssignedCharacters[i]
				if UnitHasSkill(curChar, "EmperorBallStaminaSkill") and v == triggerArgs.triggeredById and hasBall then
					FireWeapon({ Name = "InvisibleStaminaRecover2", DestinationId = v })
				end
				if UnitHasSkill(curChar, "EmperorTeamBallStaminaSkill") and hasBall then
					DoApply = true
					dontApplyTo = v
				end
			end 
			if DoApply == true then
				for i,v in pairs(team.ObjectIds) do 
					if dontApplyTo ~= v then
						FireWeapon({ Name = "InvisibleStaminaRecover2", DestinationId = v })
					end
				end 
			end
		end
	end
}
local EmpUsedSlow = {}
local EmpUsedRevive = {}
function CheckEmperorTyphoon( taunter )

	if Contains(TeamBObjectIds, taunter) then
		if EmpUsedSlow[taunter] ~= nil then
			if EmpUsedSlow[taunter] > 2 then
				return
			end
		else
		EmpUsedSlow[taunter] = 0
		end
		EmpUsedSlow[taunter] = EmpUsedSlow[taunter] + 1
	else
		if EmpUsedSlow[taunter] ~= nil then
			if EmpUsedSlow[taunter] > 2 then
				return
			end
		else
		EmpUsedSlow[taunter] = 0
		end
		EmpUsedSlow[taunter] = EmpUsedSlow[taunter] + 1
	end
	local tempTeam = GetMatchTeamByCharacterId(taunter)

	thread( EmpCheckHeadWinds, tempTeam )
end
function EmpCheckHeadWinds( team )
	local gustSide = "Left"
	if team == TeamA then
		gustSide = "Left"
		teamVictimSide = TeamB
		teamVictimObjectIds = TeamBObjectIds
		goalObject = goalA
	else
		gustSide = "Right"
		teamVictimSide = TeamA
		teamVictimObjectIds = TeamAObjectIds
		goalObject = goalB
	end

	if gustSide == "Left" then
		gustClouds = "GliderSpeedlines"
		gustSpeed = 150
		gustAngle = 0

	elseif gustSide == "Right" then
		gustClouds = "CycleSpeedLines"
		gustSpeed = -150
		gustAngle = 180
	end
	for k,v in pairs(teamVictimObjectIds) do
		local curChar = GetCharacterTableByObjectId(v)
		local equippedThrowWeapon = GetUnitDataStringValue({ Id = v, Property = "ThrowWeapon" })
		local equippedCastWeapon = "Cast"..ArchetypeData[curChar.Archetype]["WeaponSuffix"]
		local equippedJumpWeapon = "Jump"..ArchetypeData[curChar.Archetype]["WeaponSuffix"]
		local equippedSprintWeapon = "Sprint"..ArchetypeData[curChar.Archetype]["WeaponSuffix"]
		SetWeaponProperty({ DestinationId = v, WeaponName = equippedThrowWeapon, PropertyName = "Enabled", Value = false  })
		SetWeaponProperty({ DestinationId = v, WeaponName = equippedCastWeapon, PropertyName = "Enabled", Value = false  })
		SetWeaponProperty({ DestinationId = v, WeaponName = equippedJumpWeapon, PropertyName = "Enabled", Value = false  })
		SetWeaponProperty({ DestinationId = v, WeaponName = equippedSprintWeapon, PropertyName = "Enabled", Value = false  })
	end
	--ToggleControl({ Names = { "Sprint", "Jump", "Cast", "Taunt" }, Enabled = false })
	StartFlyers({ Name = gustClouds, DrawInFrontOfGroupName = "Events" })
	
	local passedTime = 0
	while passedTime < 4 do
		FireWeapon({ Name = "HeadWindsSlow", DestinationIds = teamVictimObjectIds })
		passedTime = passedTime + 0.05
		wait(0.05)
	end
	for k,v in pairs(teamVictimObjectIds) do
		local curChar = GetCharacterTableByObjectId(v)
		local equippedThrowWeapon = GetUnitDataStringValue({ Id = v, Property = "ThrowWeapon" })
		local equippedCastWeapon = "Cast"..ArchetypeData[curChar.Archetype]["WeaponSuffix"]
		local equippedJumpWeapon = "Jump"..ArchetypeData[curChar.Archetype]["WeaponSuffix"]
		local equippedSprintWeapon = "Sprint"..ArchetypeData[curChar.Archetype]["WeaponSuffix"]
		SetWeaponProperty({ DestinationId = v, WeaponName = equippedThrowWeapon, PropertyName = "Enabled", Value = true  })
		SetWeaponProperty({ DestinationId = v, WeaponName = equippedCastWeapon, PropertyName = "Enabled", Value = true  })
		SetWeaponProperty({ DestinationId = v, WeaponName = equippedJumpWeapon, PropertyName = "Enabled", Value = true  })
		SetWeaponProperty({ DestinationId = v, WeaponName = equippedSprintWeapon, PropertyName = "Enabled", Value = true  })
	end
	--ToggleControl({ Names = { "Sprint", "Jump", "Cast", "Taunt" }, Enabled = true })
	StopFlyers({ Name = gustClouds })
	StopSpawningFlyers({ Name = gustClouds })

	StopFlyers({ Name = "CycleSpeedLines" })
	StopFlyers({ Name = "GliderSpeedlines" })
end
function CheckEmperorRevive( taunter )

	if Contains(TeamBObjectIds, taunter) then
		if EmpUsedRevive[taunter] ~= nil then
			if EmpUsedRevive[taunter] > 2 then
				return
			end
		else
		EmpUsedRevive[taunter] = 0
		end
		EmpUsedRevive[taunter] = EmpUsedRevive[taunter] + 1
	else
		if EmpUsedRevive[taunter] ~= nil then
			if EmpUsedRevive[taunter] > 2 then
				return
			end
		else
		EmpUsedRevive[taunter] = 0
		end
		EmpUsedRevive[taunter] = EmpUsedRevive[taunter] + 1
	end
	local tempTeam = GetMatchTeamByCharacterId(taunter)

	thread( EmpCheckRevive, tempTeam )
end
function EmpCheckRevive( team )
	for k, v in pairs(team.ObjectIds) do
		local playerTable = GetCharacterTableByObjectId(v)
		playerTable["RespawnTimer"]  = -1
		RespawnUnit( v )
	end
end
ModUtil.WrapBaseFunction("CheckTauntSkills", function(baseFunc, taunter)
	local characterInfo = GetCharacterTableByObjectId( taunter )
	if UnitHasSkill(characterInfo, "EmperorHeadwindsTauntSkill") then
		thread(CheckEmperorTyphoon, taunter )
	end
		if UnitHasSkill(characterInfo, "EmperorTeamReviveSkill") then
		thread(CheckEmperorRevive, taunter )
	end
	return baseFunc(taunter)
end,EmperorCustomChar)

ModUtil.BaseOverride("GetScoreValueBonus", function(scoringCharacter, throwing, skipSkillProc)

	local scoreBonus = 0
	local scoringTeam = League[scoringCharacter.TeamIndex]
	local opposingTeam = GetOpposingTeam( scoringTeam )

	if ScoreValueCheat ~= nil then
		scoreBonus = ScoreValueCheat
	end

	if throwing then
		local pyreDamageBonusValue = GetUnitSkillValue( scoringCharacter, "ThrowScoreSkill" )
		if pyreDamageBonusValue > 0 then
			scoreBonus = scoreBonus + pyreDamageBonusValue
			if not skipSkillProc then
				thread( SkillProcFeedback, scoringCharacter.ObjectId, "ThrowScoreSkill", nil, pyreDamageBonusValue )
			end
		end
	else
		local pyreDamageBonusValue = GetUnitSkillValue( scoringCharacter, "SacrificeScoreSkill" )
		if pyreDamageBonusValue > 0 then
			scoreBonus = scoreBonus + pyreDamageBonusValue
			thread( SkillProcFeedback, scoringCharacter.ObjectId, "SacrificeScoreSkill", nil, pyreDamageBonusValue )
		end
	end

	if tauntScorers[scoringCharacter.ObjectId] then
		tauntValue = GetUnitSkillValue( scoringCharacter, "TauntScoreSkill" )
		scoreBonus = scoreBonus + tauntValue
		thread( SkillProcFeedback, scoringCharacter.ObjectId, "TauntScoreSkill", nil, tauntValue )
	end

	if airScore then
		local flyingSkill = GetUnitSkillValue( scoringCharacter, "UniqueFlyingSkill" )
		if flyingSkill > 0 then
			scoreBonus = scoreBonus + flyingSkill
			thread( SkillProcFeedback, scoringCharacter.ObjectId, "UniqueFlyingSkill", nil, flyingSkill )
		end
	end

	if UnitHasSkill( scoringCharacter, "AnyScoreSkill" ) then
		scoreBonus = scoreBonus + 10
		if not skipSkillProc then
			thread( SkillProcFeedback, scoringCharacter.ObjectId, "AnyScoreSkill", nil, 10 )
		end
	end

	if BanishScorers[scoringCharacter.ObjectId] then
		scoreBonus = scoreBonus + 10
		thread( SkillProcFeedback, scoringCharacter.ObjectId, "BanishScoreBonus", nil, 10 )
	end

	if raining then
		scoreBonus = scoreBonus + 5
		thread( SkillProcFeedback, scoringCharacter.ObjectId, "RainSkill" )
	end

	if scoringTeam.PyreHealth < opposingTeam.PyreHealth then
		local losingScoreSkillValue = GetUnitSkillValue( scoringCharacter, "LosingScoreSkill" )
		if losingScoreSkillValue > 0 then
			scoreBonus = scoreBonus + losingScoreSkillValue
			if not skipSkillProc then
				thread( SkillProcFeedback, scoringCharacter.ObjectId, "LosingScoreSkill", nil, losingScoreSkillValue )
			end
		end
	elseif scoringTeam.PyreHealth > opposingTeam.PyreHealth then

		if TeamHasSkillDrafted( opposingTeam, "LosingScoreScoreDebuff" ) then
			scoreBonus = scoreBonus - 10
			if not skipSkillProc then
				thread( SkillProcFeedback, scoringCharacter.ObjectId, "LosingScoreScoreDebuff", nil, 10 )
			end
		end

		local winningScoreSkillValue = GetUnitSkillValue( scoringCharacter, "WinningScoreSkill" )
		if winningScoreSkillValue > 0 then
			scoreBonus = scoreBonus + winningScoreSkillValue
			if not skipSkillProc then
				thread( SkillProcFeedback, scoringCharacter.ObjectId, "WinningScoreSkill", nil, winningScoreSkillValue )
			end
		end

	end

	local pyreDamageBonusValue = GetUnitSkillValue( scoringCharacter, "PyreDamageSkill" )
	if pyreDamageBonusValue > 0 then
		scoreBonus = scoreBonus + pyreDamageBonusValue
		if not skipSkillProc then
			thread( SkillProcFeedback, scoringCharacter.ObjectId, "PyreDamageSkill", nil, pyreDamageBonusValue )
		end
	end

	if scoringTeam == TeamB and ConstellationActive("RivalPyreDamage") then
		scoreBonus = scoreBonus + 5
		--thread( SkillProcFeedback, scoringCharacter.ObjectId, "RivalPyreDamage" )
	end
	for k,v in pairs(opposingTeam.ObjectIds) do
		local curChar = GetCharacterTableByObjectId(v)
		if UnitHasSkill(curChar, "EmperorDamageDownSkill") and curChar.RespawnTimer <= 0 then
			scoreBonus = scoreBonus - 5
		end
	end
	return scoreBonus
end,EmperorCustomChar)

ModUtil.BaseOverride("UpdateBallScale", function()
BallScale =
{
	["PlayerSmall"] = 0.45,
	["PlayerMedium"] = 0.80,
	["PlayerMediumAlt"] = 0.80,
	["PlayerLarge"] = 1.10,
	["PlayerTrail"] = 0.425,
	["PlayerFlying"] = 0.70,
	["PlayerMonster"] = 1.0,
	["PlayerTree"] = 1.0,
	["PlayerImp"] = 0.375,
	["PlayerEmperor"] = 0.80,
}
	local characterData = CharacterCache[BallCarrierId]
	if characterData == nil then
		return
	end

	local ballScaleMath = BallScale[characterData.Archetype]
	ballScale = ballScaleMath
	SetScale({ Id = ballId, Fraction = ballScale, Duration = 0.3 })
	if ImpifiedUnits[BallCarrierId] then
		SetScale({ Id = ballId, Fraction = 0.4, Duration = 0.3 })
	end
end,EmperorCustomChar)