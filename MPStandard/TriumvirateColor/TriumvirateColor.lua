ModUtil.RegisterMod( "TriumvirateColor" )

--Mod to change the color of triumvirates

--table where you can adjust the color values
TriumvirateColor.color_table = {
	{
		--Nightwings
		hue1 = 210,
		hue2 = 10,
		sat1 = -20,
		sat2 = 0,
		value1 = -15,
		value2 = 0
	},
	{
		--Accusers
		hue1 = 45,
		hue2 = 50,
		sat1 = -30,
		sat2 = 10,
		value1 = -30,
		value2 = 30
	},
	{
		--Fate
		hue1 = 290,
		hue2 = 40,
		sat1 = -30,
		sat2 = -40,
		value1 = -25,
		value2 = 40
	},
	{
		--Dissidents
		hue1 = 25,
		hue2 = 50,
		sat1 = 0,
		sat2 = -5,
		value1 = -80,
		value2 = -85
	},
	{
		--Withdrawn
		hue1 = 80,
		hue2 = 125,
		sat1 = -30,
		sat2 = -40,
		value1 = -25,
		value2 = 60
	},
	{
		--Pyrehearts
		hue1 = 180,
		hue2 = 355,
		sat1 = 0,
		sat2 = 10,
		value1 = -20,
		value2 = 30
	},
	{
		--Essence
		hue1 = 140,
		hue2 = 270,
		sat1 = -10,
		sat2 = -20,
		value1 = -50,
		value2 = 20
	},
	{
		--Chastity
		hue1 = 340,
		hue2 = 40,
		sat1 = -30,
		sat2 = 20,
		value1 = 30,
		value2 = 30
	},
	{
		--Tempers
		hue1 = 110,
		hue2 = 190,
		sat1 = 0,
		sat2 = 10,
		value1 = -60,
		value2 = -50
	},
	{
		--Beyonders
		hue1 = 60,
		hue2 = 100,
		sat1 = -40,
		sat2 = -60,
		value1 = 80,
		value2 = 70
	},
	{
		--True Nightwings
		hue1 = 10,
		hue2 = 210,
		sat1 = 0,
		sat2 = -40,
		value1 = -20,
		value2 = -45
	},
}

--Control variable to switch between colorless/white and yellowish Beyonders. To set the Beyonders to white set the variable to true, otherwise to false
local beyondersColorless = true

ModUtil.WrapBaseFunction("SetLocalMPTeamAttributes", function(baseFunc, teamA, teamB)
	baseFunc(teamA, teamB)
	indexlist = {GetConfigOptionValue({ Name = "LocalMPTeamAIndex" }),GetConfigOptionValue({ Name = "LocalMPTeamBIndex" })}
	-- Here you can set new color hues and saturation for both the primary and secondary color for every triumvirate.
	for i = 1,2,1 do
		local hue1 = TriumvirateColor.color_table[indexlist[i]].hue1
		local hue2 = TriumvirateColor.color_table[indexlist[i]].hue2
		local sat1 = TriumvirateColor.color_table[indexlist[i]].sat1
		local sat2 = TriumvirateColor.color_table[indexlist[i]].sat2
		local value1 = TriumvirateColor.color_table[indexlist[i]].value1
		local value2 = TriumvirateColor.color_table[indexlist[i]].value2
		if indexlist[i] == 10 and beyondersColorless then

		elseif indexlist[i] > 12 then
			hue1 = PlayerData.Teams[indexlist[i]].MaskHue
			hue2 = PlayerData.Teams[indexlist[i]].MaskHue2
		end
		if i == 1 then
			teamA["MaskHue"] = hue1
			teamA["MaskHue2"] = hue2
			teamA["MaskSaturationAddition1"] = sat1
			teamA["MaskSaturationAddition2"] = sat2
			teamA["MaskValueAddition1"] = value1
			teamA["MaskValueAddition2"] = value2
			if indexlist[i] == 10 and beyondersColorless then
				teamA["MaskHueRGB"] = HSVtoRGB(hue1,0.0,1.0)
				teamA["MaskHueRGB2"] = HSVtoRGB(hue2,1.0,0.0)
			else
				teamA["MaskHueRGB"] = HSVtoRGB(hue1,1.0,1.0)
				teamA["MaskHueRGB2"] = HSVtoRGB(hue2,1.0,1.0)
			end
		else
			teamB["MaskHue"] = hue1
			teamB["MaskHue2"] = hue2
			teamB["MaskSaturationAddition1"] = sat1
			teamB["MaskSaturationAddition2"] = sat2
			teamB["MaskValueAddition1"] = value1
			teamB["MaskValueAddition2"] = value2
			if indexlist[i] == 10 and beyondersColorless then
				teamB["MaskHueRGB"] = HSVtoRGB(hue1,0.0,1.0)
				teamB["MaskHueRGB2"] = HSVtoRGB(hue2,1.0,0.0)
			else
				teamB["MaskHueRGB"] = HSVtoRGB(hue1,1.0,1.0)
				teamB["MaskHueRGB2"] = HSVtoRGB(hue2,1.0,1.0)
			end
		end
	end
end, TriumvirateColor)

-- If the Beyonders are colorless we do not assign the aura color which reverts to white.
ModUtil.WrapBaseFunction("SetupSingleUnitHouseColors", function(baseFunc, character, objectId)
	if beyondersColorless and ( (character.TeamIndex == 12 and GetConfigOptionValue({ Name = "LocalMPTeamAIndex" }) == 10) or (character.TeamIndex == 13 and GetConfigOptionValue({ Name = "LocalMPTeamBIndex" }) == 10) ) then
		local team = League[character.TeamIndex]
		local colorObject = team
		SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = true, Name = "MaskSaturationAddition", Value = colorObject.MaskSaturationAddition })
		SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = true, Name = "MaskSaturationAddition2", Value = colorObject.MaskSaturationAddition2 })
		SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = true, Name = "MaskValueAddition", Value = colorObject.MaskValueAddition })
		SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = true, Name = "MaskValueAddition2", Value = colorObject.MaskValueAddition2 })
		if character.MaskHue ~= nil then
			colorObject = character
			SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = false, Name = "MaskHue", Value = colorObject.MaskHue })
			SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = false, Name = "MaskHue2", Value = colorObject.MaskHue2 })
			SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = false, Name = "MaskSaturationAddition", Value = colorObject.MaskSaturationAddition })
			SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = false, Name = "MaskSaturationAddition2", Value = colorObject.MaskSaturationAddition2 })
			SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = false, Name = "MaskValueAddition", Value = colorObject.MaskValueAddition })
			SetPlayerUnitProperty({ DestinationId = objectId, DeriveRGB = false, Name = "MaskValueAddition2", Value = colorObject.MaskValueAddition2 })
		end
	else
		baseFunc(character, objectId)
	end
end, TriumvirateColor)