OnAnyLoad{function(triggerArgs)
	VaporizeGraphics["PlayerPhantom"] = { ScoreGraphic = "PlayerMediumScorePose", OpacityDelay = 2.4, TeleportOffsetX = 0, TeleportOffsetY = 0}
	BallScale["PlayerPhantom"] = 0.80
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
	["PlayerPhantom"] = {  MaxTauntVelocity = 300, TauntCooldown = 2.0 },
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

end, PhantomCustomChar)
--[[ModUtil.BaseOverride("DistributeTeamSkills", function (team)
local empSkillsToDistribute =
{
	"TeamBallSkill", "TeamStaminaRechargeSkill","PhantomStealSpeedSkill","PhantomTeamStaminaUpSkill",
}

local empTeamSkills =
{
	"TeamBallSkill", "TeamStaminaRechargeSkill",
	"BetterBeacon", "TauntSaplingExplode", "TeamEnemyBanishTime", "TeamReviveSkill",
	"TeamHeadWinds", "SoleUnitPowerUp", "AllDeadRespawnTeam", "PyreLastHitRegenerateTeam",
	"LosingScoreScoreDebuff", "LosingBallPosition","PhantomStealSpeedSkill","PhantomTeamStaminaUpSkill",
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
end, PhantomCustomChar)]]--

PhantomUsedSwap = {}
SaveIgnores["PhantomUsedSwap"] = true
function CheckPhantomSwap( taunter )

		if PhantomUsedSwap[taunter] ~= nil then
			if PhantomUsedSwap[taunter] > 0 then
				return
			end
		else
		PhantomUsedSwap[taunter] = 0
		end
		PhantomUsedSwap[taunter] = PhantomUsedSwap[taunter] + 1
	local tempTeam = GetMatchTeamByCharacterId(taunter)
	
	thread( PhantomSwapRevStatus, tempTeam )
end
function PhantomSwapRevStatus( team )
	local revTeamIndexs = {}
	local deadTeamIndexs = {}
	for i,v in pairs(team.ObjectIds) do 
		local curChar = team.AssignedCharacters[i]
		if curChar.RespawnTimer > 0 and curChar.RespawnTimer ~= 999999 then
			table.insert(revTeamIndexs, v)
		end
	end
	for i,v in pairs(GetOpposingTeam(team).ObjectIds) do 
		local curChar = GetOpposingTeam(team).AssignedCharacters[i]
		if curChar.RespawnTimer <= 0 then
			table.insert(deadTeamIndexs, v)
		end
	end
	RespawnUnit(revTeamIndexs[#revTeamIndexs])
	Destroy({ Id = deadTeamIndexs[#deadTeamIndexs]})
end
ModUtil.WrapBaseFunction("Score", function ( baseFunc, scoringTeam, scoredOnTeam, scorer )
	local returnValue = baseFunc(scoringTeam, scoredOnTeam, scorer)
	PhantomUsedSwap = {}
	return returnValue
end, PhantomCustomChar)
ModUtil.WrapBaseFunction("CheckTauntSkills", function(baseFunc, taunter)
	local characterInfo = GetCharacterTableByObjectId( taunter )
	if UnitHasSkill(characterInfo, "PhantomTauntSwapStatusSkill") then
		thread(CheckPhantomSwap, taunter )
	end
	return baseFunc(taunter)
end, PhantomCustomChar)

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
	local phantomChar = nil
	local added = 0
	if UnitHasSkill(scoringCharacter, "PhantomStealEnemyGlory") then
		for i,v in pairs(opposingTeam.ObjectIds) do 
			local curChar = opposingTeam.AssignedCharacters[i]
			if curChar.RespawnTimer > 0 then
				added = added + 3
			end
		end
	end
	scoreBonus = scoreBonus + added
	return scoreBonus
end,PhantomCustomChar)

ModUtil.BaseOverride("UpdateBallScale", function()
	local BallScale =
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
		["PlayerPhantom"] = 0.80,
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
end,PhantomCustomChar)
ModUtil.BaseOverride("UpdateBallScaleCharacter", function(character)
	local BallScale =
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
		["PlayerPhantom"] = 0.80,
	}
	local ballScaleMath = BallScale[character.Archetype]
	ballScale = ballScaleMath
	SetScale({ Id = ballId, Fraction = ballScale, Duration = 0.3 })
	if ImpifiedUnits[BallCarrierId] then
		SetScale({ Id = ballId, Fraction = 0.4, Duration = 0.3 })
	end
end,PhantomCustomChar)
OnWeaponTriggerRelease{ "JumpPhantom",
	function(triggerArgs)
		
		local flyingUnit = triggerArgs.triggeredById
		local flyingUnitData = GetCharacterTableByObjectId( flyingUnit )
		local activePoolPlayerA = GetActiveUnitId({ PlayerIndex = 1 })
		local activePoolPlayerB = GetActiveUnitId({ PlayerIndex = 2 })
		if flyingUnit == activePoolPlayerA and UnitHasSkill(flyingUnitData,"PhantomBanishFall") then
			Destroy({Id = GetClosest({ Id = flyingUnit, DestinationIds = TeamBObjectIds, Distance = 160})})
		elseif flyingUnit == activePoolPlayerB and UnitHasSkill(flyingUnitData,"PhantomBanishFall") then
			Destroy({Id = GetClosest({ Id = flyingUnit, DestinationIds = TeamAObjectIds, Distance = 160})})
		end
		
	end
}
OnDestroyAny{ "TeamA TeamB", function( triggerArgs )

	if triggerArgs.triggeredById == nil then
		return
	end

	local deadCharTeam = GetMatchTeamByCharacterId( triggerArgs.triggeredById )
	local deadPlayerObjectId = triggerArgs.triggeredById
	local deadPlayer = CharacterCache[triggerArgs.triggeredById]
	local deathWeapon = triggerArgs.name
	local booker = triggerArgs.KillerId
	local killingPlayer = CharacterCache[booker]
	if  UnitHasSkill(deadPlayer, "PhantomHalfRespawnTimeSkill") then
		for i,v in pairs(deadCharTeam.ObjectIds) do 
			local curChar = deadCharTeam.AssignedCharacters[i]
			if curChar.RespawnTimer > 0 and curChar.RespawnTimer ~= 999999 and not UnitHasSkill(curChar, "PhantomHalfRespawnTimeSkill") then
				curChar.RespawnTimer = curChar.RespawnTimer * 0.5
			end
		end 
	end
	if UnitHasSkill(deadPlayer, "PhantomStaminaDeadSkill") then
		for i,v in pairs(deadCharTeam.ObjectIds) do 
			local curChar = deadCharTeam.AssignedCharacters[i]
			if curChar.RespawnTimer <= 0 then
				FireWeapon({ Name = "InvisibleStaminaRecover3", DestinationId = v })
			end
		end 
	end
	if UnitHasSkill(deadPlayer, "PhantomStunBanisherSkill") then
		FireWeapon({ Name = "InvisibleJumpStunItem", DestinationId = booker })
	end

end }
