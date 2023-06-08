local FlingForces = {
	["PlayerSmall"] = { Force = 600, UpForce = 2000 },
	["PlayerMedium"] = { Force = 600, UpForce = 2100 },
	["PlayerLarge"] = { Force = 900, UpForce = 2500 },
	["PlayerMediumAlt"] = { Force = 700, UpForce = 2200 },
	["PlayerImp"] = { Force = 600, UpForce = 2000 },
	["PlayerTree"] = { Force = 700, UpForce = 2500 },
	["PlayerFlying"] = { Force = 700, UpForce = 2500 },
	["PlayerTrail"] = { Force = 600, UpForce = 2000 },
	["PlayerMonster"] = { Force = 700, UpForce = 2200 },
	["PlayerEmperor"] = { Force = 600, UpForce = 2100 },
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