ModUtil.RegisterMod( "ImplosionRespawnFix" )

--Implementation of a fix by Failer

ModUtil.WrapBaseFunction("CheckKillSkills", function(baseFunc, killingPlayer, killingWeaponName, deadPlayer, deadPlayerId, perfectKill)
    if killingPlayer ~= deadPlayer then
		return baseFunc(killingPlayer, killingWeaponName, deadPlayer, deadPlayerId, perfectKill)
    end
end, ImplosionRespawnFix)
