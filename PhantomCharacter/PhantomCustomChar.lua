ModUtil.RegisterMod( "PhantomCustomChar" )
local config = {
	BaseCount = 21,
	TeamA = {
		{
			Base = 2,
			Bench = 2,
			NilTable = {},
			SetTable = {
			Archetype = "PlayerPhantom",
			ShortName = "NPC_Wraith",
			Portrait = "NPC_Wraith_01",
			RobedPortrait = "NPC_Wraith_01",
			SmallPortrait = "NPC_Wraith_01_Small",
			TooltipIds = { FirstName = "NPC_NightwingAscended", FullName = "NPC_NightwingAscended", ShortName = "NPC_NightwingAscended" },
			MaskHue = 147, MaskSaturationAddition = -22, MaskValueAddition = -24,
			MaskHue2 = 50, MaskSaturationAddition2 = -70, MaskValueAddition2 = 50,
			UsePhantomShader = true
			},
		},
	},
}
PhantomCustomChar.config = config
config.TeamB = config.TeamA

ModUtil.WrapBaseFunction( "PrepareLocalMPDraft", function(baseFunc, TeamAid, TeamBid )
		local TeamAbench = League[TeamAid].TeamBench
		local TeamBbench = League[TeamBid].TeamBench
		local nA = #TeamAbench
		local nB = #TeamBbench
		if nA == config.BaseCount and nB == config.BaseCount then
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
				
				character.SkillTreeA = character.Archetype .."A"
				character.SkillTreeB = character.Archetype .."B"
				
				character.StartingSkills = {}

				character.MatchSkills = {}
				character.MatchItems ={}
				if bench.UsePhantomShader or character.UsePhantomShader then
					character.FirstName = "Rivals_Captain17_FirstName"
				end
				TeamAbench[character.CharacterIndex] = character
			end
			for i,v in ipairs(config.TeamB) do
				local bench = League[v.Bench]
				local character = DeepCopyTable(bench.TeamBench[v.Base])

				character.CharacterIndex = nB+i
				character.TeamIndex = TeamBid
			
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
				if bench.UsePhantomShader or character.UsePhantomShader then
					character.FirstName = "Rivals_Captain17_FirstName"
				end
			
				TeamBbench[character.CharacterIndex] = character
			end
		end
	return baseFunc( TeamAid, TeamBid )
end, PhantomCustomChar)
