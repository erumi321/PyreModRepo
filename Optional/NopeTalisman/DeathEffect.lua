ModUtil.WrapBaseFunction("CheckDeathSkills", function(baseFunc, deadPlayer, deadCharTeam, booker, killingCharacter)
    TalismanDebugPrintTable("deadPlayer", deadPlayer)
	if deadPlayer ~= SacrificeScorer then
        TalismanDebugPrintTable("killingCharacter", killingCharacter)
		if  UnitHasSkill( deadPlayer, "OnDeathStunItem" ) then
            TalismanDebugPrint({Text = "Fire Stun"})
			FireWeapon({ Name = "InvisibleJumpStunItem", DestinationId = killingCharacter.ObjectId })
            thread( SkillProcFeedback, deadPlayer.ObjectId, "OnDeathStunItem", nil)
		end
	end
    return baseFunc(deadPlayer, deadCharTeam, booker, killingCharacter)
end, NopeTalisman)