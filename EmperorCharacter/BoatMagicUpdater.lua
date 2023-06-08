local FlingForces = {
	["PlayerSmall"] = { Force = 700, UpForce = 2000, UpForceAirborne = 1800, ForceAirborne = 500 },
	["PlayerMedium"] = { Force = 650, UpForce = 1800, UpForceAirborne = 1800, ForceAirborne = 700 },
	["PlayerLarge"] = { Force = 1500, UpForce = 1600, UpForceAirborne = 2000, ForceAirborne = 150 },
	["PlayerMediumAlt"] = { Force = 700, UpForce = 1900, UpForceAirborne = 1500, ForceAirborne = 300 },
	["PlayerImp"] = { Force = 700, UpForce = 2000, UpForceAirborne = 1200, ForceAirborne = 550 },
	["PlayerTree"] = { Force = 1200, UpForce = 1600, UpForceAirborne = 2500, ForceAirborne = 700 },
	["PlayerFlying"] = { Force = 650, UpForce = 2500, UpForceAirborne = 1400, ForceAirborne = 650 },
	["PlayerTrail"] = { Force = 800, UpForce = 1700, UpForceAirborne = 1700, ForceAirborne = 350 },
	["PlayerMonster"] = { Force = 1200, UpForce = 1600, UpForceAirborne = 100, ForceAirborne = 300 },
	["PlayerEmperor"] = { Force = 650, UpForce = 1800, UpForceAirborne = 1800, ForceAirborne = 700 },
}
ModUtil.BaseOverride("FlingUnit", function(unitId, flingerId)
	--if FlungUnits[unitId] == flingerId then
		--return
	--end

	local unitData = GetCharacterTableByObjectId( unitId )
	local angle = GetAngle({ Id = unitId })
	local flingForce = FlingForces[unitData.Archetype].Force
	ApplyForce({ Id = unitId, Speed = flingForce, Angle = angle, UsingRadians = true })
	local flingUpwardForce = FlingForces[unitData.Archetype].UpForce
	if FlingForces[unitData.Archetype].UpForceAirborne ~= nil and GetZLocation({ Id = unitId }) > 0.0 then -- The height of the blocking obstacles under the Jumpers
		flingUpwardForce = FlingForces[unitData.Archetype].UpForceAirborne
		flingForce = FlingForces[unitData.Archetype].ForceAirborne
	end
	ApplyUpwardForce({ Id = unitId, Speed = flingUpwardForce })

	PlaySound({ Name = "/SFX/Object Ambiences/WaterRushingLarge" })
	FireWeapon({ Name = "InvisibleDisarm", DestinationId = unitId })
	--FlungUnits[unitId] = flingerId
	wait(0.3)
	StopSound({ Name = "/SFX/Object Ambiences/WaterRushingLarge", Duration = 0.3, Delay = 0.2 })
	--FlungUnits[unitId] = nil

end,EmperorCustomChar)