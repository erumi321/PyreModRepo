ModUtil.RegisterMod( "AddedScribes" )
--[[
Google Sheet for different character Values
https://docs.google.com/spreadsheets/d/1XxANHz_vtz8QHXYa0GqOX6xrL1XXGSsWsXiZWzZkVyw/edit?usp=sharing
]]--
local config = {
	BaseCount = 21,
	TeamA = {
		{
			Base = 2,
			Bench = 8,
			NilTable = {},
			SetTable = {
			PlayerAttributeAura = 19,
			PlayerAttributeSpeed = 19,
			PlayerAttributeRespawn = 1,
			ScoreValue = 26,
			ShortName = "NPC_ScribeNomad",
			SmallPortrait = "ScribeNomad01_Small",
			UsePhantomShader = true,
			MaskHue = 30, MaskSaturationAddition = -30, MaskValueAddition = -30,
			MaskHue2 = 40, MaskSaturationAddition2 = 10, MaskValueAddition2 = 30,
			},
		},
		{
			Base = 2,
			Bench = 10,
			NilTable = {},
			SetTable = {
			PlayerAttributeAura = 27,
			PlayerAttributeRespawn = 1,
			ShortName = "NPC_ScribeCur",
			SmallPortrait = "ScribeCur01_Small",
			MaskHue = 80, MaskSaturationAddition = 0, MaskValueAddition = -60,
			MaskHue2 = 190, MaskSaturationAddition2 = 10, MaskValueAddition2 = -50,
			},
		},
		{
			Base = 3,
			Bench = 10,
			NilTable = {},
			SetTable = {
			PlayerAttributeRespawn = 34,
			ScoreValue = 5,
			ShortName = "NPC_ScribeDemon",
			SmallPortrait = "ScribeDemon01_Small",
			MaskHue = 290, MaskSaturationAddition = -30, MaskValueAddition = -25,
			MaskHue2 = 40, MaskSaturationAddition2 = -40, MaskValueAddition2 = 40,
			},
		},
		{
			Base = 4,
			Bench = 10,
			NilTable = {},
			SetTable = {
			PlayerAttributeAura = 16,
			PlayerAttributeRespawn = 1,
			PlayerAttributeSpeed = 22,
			ScoreValue = 28,
			ShortName = "NPC_ScribeTraitor",
			SmallPortrait = "ScribeTraitor01_Small"
			},
		},
		{
			Base = 5,
			Bench = 10,
			NilTable = {},
			SetTable = {
			PlayerAttributeSpeed = 28,
			PlayerAttributeRespawn = 1,
			ShortName = "NPC_ScribeImp",
			SmallPortrait = "ScribeImp01_Small",
			MaskHue = 20, MaskSaturationAddition = -0, MaskValueAddition = -5,
			MaskHue2 = 50, MaskSaturationAddition2 = -80,  MaskValueAddition2 = -85,
			},
		},
		{
			Base = 6,
			Bench = 10,
			NilTable = {},
			SetTable = {
			PlayerAttributeAura = 13,
			ScoreValue = 23,
			PlayerAttributeRespawn = 1,
			ShortName = "NPC_ScribeWyrm",
			SmallPortrait = "ScribeWyrm01_Small",
			MaskHue = 170, MaskSaturationAddition = 0, MaskValueAddition = -20,
			MaskHue2 = 0, MaskSaturationAddition2 = 10, MaskValueAddition2 = 30,
			},
		},
		{
			Base = 7,
			Bench = 10,
			NilTable = {},
			SetTable = {
			PlayerAttributeSpeed = 24,
			PlayerAttributeRespawn = 1,
			ShortName = "NPC_ScribeHarp",
			SmallPortrait = "ScribeHarp01_Small",
			MaskHue = 160, MaskSaturationAddition = -10, MaskValueAddition = -50,
			MaskHue2 = 270, MaskSaturationAddition2 = -20, MaskValueAddition2 = 20,
			},
		},
		{
			Base = 8,
			Bench = 10,
			NilTable = {},
			SetTable = {
			PlayerAttributeSpeed = 18,
			PlayerAttributeRespawn = 1,
			ShortName = "NPC_ScribeSap",
			SmallPortrait = "ScribeSap01_Small",
			MaskHue = 345, MaskSaturationAddition = -30, MaskValueAddition = 30,
			MaskHue2 = 40, MaskSaturationAddition2 = 20,  MaskValueAddition2 = 30,
			},
		},
		{
			Base = 9,
			Bench = 10,
			NilTable = {},
			SetTable = {
			ScoreValue = 34,
			PlayerAttributeRespawn = 1,
			ShortName = "NPC_ScribeCrone",
			SmallPortrait = "ScribeCrone01_Small",
			MaskHue = 75, MaskSaturationAddition = -30, MaskValueAddition = -25,
			MaskHue2 = 128, MaskSaturationAddition2 = -40, MaskValueAddition2 = 60,
			},
		}
	},
}
AddedScribes.config = config
config.TeamB = config.TeamA

ModUtil.WrapBaseFunction( "PrepareLocalMPDraft", function(baseFunc, TeamAid, TeamBid )
SetMenuOptions({ Name = "RosterScreen", Item = "CharacterGridButton", Properties = { 
			Scale = "0.9",
			OffsetX="550",
			OffsetY="950",
			SpacingX="83",
			SpacingY="84"
} })
		local TeamAbench = League[TeamAid].TeamBench
		local TeamBbench = League[TeamBid].TeamBench
		local nA = #TeamAbench
		local nB = #TeamBbench
		if #TeamAbench == config.BaseCount and #TeamBbench == config.BaseCount then
			for i,v in ipairs(config.TeamA) do
				local bench = League[v.Bench]
				local character = DeepCopyTable(bench.TeamBench[v.Base])

				character.CharacterIndex = nA+i
				character.TeamIndex = TeamAid
			
				character.MaskHue = bench.MaskHue 
				character.MaskSaturationAddition = bench.MaskSaturationAddition
				character.MaskValueAddition = bench.MaskValueAddition
				character.MaskHue2 = bench.MaskHue2
				character.MaskSaturationAddition2 = bench.MaskSaturationAddition2
				character.MaskValueAddition2 = bench.MaskValueAddition2
				
				ModUtil.MapNilTable(character,v.NilTable)
				ModUtil.MapSetTable(character,v.SetTable)
				
				character.SkillTreeA = character.Archetype .. "A"
				character.SkillTreeB = character.Archetype .. "B"
				
				character.StartingSkills = {}

				character.MatchSkills = {}
				character.MatchItems ={}
				if bench.UsePhantomShader then
					character.FirstName = "Rivals_Captain17_FirstName"
				end
				TeamAbench[character.CharacterIndex] = character
			end
			for i,v in ipairs(config.TeamB) do
				local bench = League[v.Bench]
				local character = DeepCopyTable(bench.TeamBench[v.Base])
				ModUtil.MapNilTable(character,v.NilTable)
				ModUtil.MapSetTable(character,v.SetTable)
				character.CharacterIndex = nB+i
				character.TeamIndex = TeamBid
			
				character.MaskHue = bench.MaskHue 
				character.MaskSaturationAddition = bench.MaskSaturationAddition
				character.MaskValueAddition = bench.MaskValueAddition
				character.MaskHue2 = bench.MaskHue2
				character.MaskSaturationAddition2 = bench.MaskSaturationAddition2
				character.MaskValueAddition2 = bench.MaskValueAddition2
			
				character.SkillTreeA = character.Archetype .. "A"
				character.SkillTreeB = character.Archetype .. "B"
			
				character.StartingSkills = {}
				character.MatchSkills = {}
				character.MatchItems ={}
				if bench.UsePhantomShader then
					character.FirstName = "Rivals_Captain17_FirstName"
				end
			
				TeamBbench[character.CharacterIndex] = character
			end
		end
	return baseFunc( TeamAid, TeamBid )
end, AddedScribes)