ModUtil.RegisterMod( "EmperorCustomChar" )
local config = {
	BaseCount = 21,
	TeamA = {
		{
			Base = 2,
			Bench = 2,
			NilTable = {},
			SetTable = {
			Archetype = "PlayerEmperor",
			ShortName = "NPC_NightwingAscended",
			Portrait = "Brighton01_Small_Backstory",
			SmallPortrait = "Brighton01_Small_Backstory",
			TooltipIds = { FirstName = "NPC_NightwingAscended", FullName = "NPC_NightwingAscended", ShortName = "NPC_NightwingAscended" },
			MaskHue = 50, MaskSaturationAddition = -70, MaskValueAddition = 50,
			MaskHue2 = 100, MaskSaturationAddition2 = -100,  MaskValueAddition2 = -100,
			},
		},
	},
}
EmperorCustomChar.config = config
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
				if bench.UsePhantomShader then
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
				if bench.UsePhantomShader then
					character.FirstName = "Rivals_Captain17_FirstName"
				end
			
				TeamBbench[character.CharacterIndex] = character
			end
		end
	return baseFunc( TeamAid, TeamBid )
end, EmperorCustomChar)
