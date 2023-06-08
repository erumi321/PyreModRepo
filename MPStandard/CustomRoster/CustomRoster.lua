ModUtil.RegisterMod( "CustomRoster" )
--[[
Google Sheet for different character Values
https://docs.google.com/spreadsheets/d/1XxANHz_vtz8QHXYa0GqOX6xrL1XXGSsWsXiZWzZkVyw/edit?usp=sharing
]]--
local config = {
	BaseCount = 21,
	TeamA = {
		-- Vispaleth
		{
			Base = 4,
			Bench = 2,
			NilTable = {},
			SetTable = {},
			PlayerAttributeAuraModifier = 0,
			PlayerAttributeRespawnModifier = 1,
			PlayerAttributeSpeedModifier = 2,
			StartingSkills = { "DoubleRush" },
			Skills = {},
			MatchItems = {},
			MatchSkills = {},
			SkillTreeA = "PlayerLargeA",
			SkillTreeB = "PlayerLargeB",
			XP = 1200,
			TotalXP = 1200,
			Level = 2,
			MusicTheme = "/Music/UrsaIdea8_MC",
			MusicStemName = "Guitars",
			MusicStemValue = 1,
			MaskHue = 30,
			MaskHue2 = 40,
			MaskSaturationAddition = -30,
			MaskSaturationAddition2 = 10,
			MaskValueAddition = -30,
			MaskValueAddition2 = 30,
			SpecialScorePose = "PlayerLargeScorePoseAlt"
		},
		-- Gareph
		{
			Base = 2,
			Bench = 11,
			NilTable = {},
			SetTable = {},
			PlayerAttributeAuraModifier = -1,
			PlayerAttributeRespawnModifier = -1,
			PlayerAttributeSpeedModifier = 1,
			StartingSkills = { "MobilityChargeTime" },
			Skills = {},
			MatchItems = {},
			MatchSkills = {},
			SkillTreeA = "PlayerMediumAltA",
			SkillTreeB = "PlayerMediumAltB",
			XP = 1200,
			TotalXP = 1200,
			Level = 2,
			MusicTheme = "/Music/MatchMusic5_MC",
			MusicStemName = "Guitars",
			MusicStemValue = 1,
			MaskHue = 10,
			MaskHue2 = 210,
			MaskSaturationAddition = 0,
			MaskSaturationAddition2 = -40,
			MaskValueAddition = -20,
			MaskValueAddition2 = -45
		},
		-- Ra'ji
		{
			Base = 4,
			Bench = 3,
			NilTable = {},
			SetTable = {},
			PlayerAttributeAuraModifier = 0,
			PlayerAttributeRespawnModifier = 0,
			PlayerAttributeSpeedModifier = 0,
			StartingSkills = { "MoveBetter", "Beacon", "BetterBeacon"},
			Skills = {},
			MatchItems = {},
			MatchSkills = {},
			SkillTreeA = "PlayerImpA",
			SkillTreeB = "PlayerImpB",
			XP = 6050,
			TotalXP = 6050,
			Level = 4,
			MusicTheme = "/Music/MatchMusic7_MC",
			MusicStemName = "Guitars",
			MusicStemValue = 1,
			MaskHue = 290,
			MaskHue2 = 40,
			MaskSaturationAddition = -30,
			MaskSaturationAddition2 = -40,
			MaskValueAddition = -25,
			MaskValueAddition2 = 40
		},
		-- Lady River
		{
			Base = 3,
			Bench = 9,
			NilTable = {},
			SetTable = {},
			PlayerAttributeAuraModifier = 7,
			PlayerAttributeRespawnModifier = -1,
			PlayerAttributeSpeedModifier = -1,
			StartingSkills = { "TrailExplosion", "BanishScoreBonus" },
			Skills = {},
			MatchItems = {},
			MatchSkills = {},
			SkillTreeA = "PlayerTrailA",
			SkillTreeB = "PlayerTrailB",
			XP = 3875,
			TotalXP = 3875,
			Level = 3,
			MusicTheme = "/Music/MatchMusic4_MC",
			MusicStemName = "Guitars",
			MusicStemValue = 1,
			MaskHue = 80,
			MaskHue2 = 190,
			MaskSaturationAddition = 0,
			MaskSaturationAddition2 = 10,
			MaskValueAddition = -60,
			MaskValueAddition2 = -50,
		},
		-- Xaxiana
		{
			Base = 3,
			Bench = 8,
			NilTable = {},
			SetTable = {},
			PlayerAttributeAuraModifier = 0,
			PlayerAttributeRespawnModifier = -2,
			PlayerAttributeSpeedModifier = 2,
			StartingSkills = { "OnKillBuffSpeed", "RespawnBuff" },
			Skills = {},
			MatchItems = {},
			MatchSkills = {},
			SkillTreeA = "PlayerFlyingA",
			SkillTreeB = "PlayerFlyingB",
			XP = 4675,
			TotalXP = 4675,
			Level = 3,
			MusicTheme = "/Music/MatchMusic3_MC",
			MusicStemName = "Guitars",
			MusicStemValue = 1,
			MaskHue = 345,
			MaskHue2 = 40,
			MaskSaturationAddition = -30,
			MaskSaturationAddition2 = 20,
			MaskValueAddition = 30,
			MaskValueAddition2 = 30,
			SpecialScorePose = "PlayerFlyingScorePoseAlt"
		},
		-- Vorfrit
		{
			Base = 9,
			Bench = 10,
			NilTable = {},
			SetTable = {},
			PlayerAttributeAuraModifier = 0,
			PlayerAttributeRespawnModifier = 0,
			PlayerAttributeSpeedModifier = 0,
			StartingSkills = { "WinningScoreSkill5", "MonsterSprintSkill" },
			Skills = {},
			MatchItems = {},
			MatchSkills = {},
			SkillTreeA = "PlayerMonsterA",
			SkillTreeB = "PlayerMonsterB",
			XP = 4275,
			TotalXP = 4275,
			Level = 3,
			MusicTheme = "/Music/MatchMusic2_MC",
			MusicStemName = "Guitars",
			MusicStemValue = 1,
			MaskHue = 70,
			MaskHue2 = 100,
			MaskSaturationAddition = -40,
			MaskSaturationAddition2 = -60,
			MaskValueAddition = 80,
			MaskValueAddition2 = 70,
			SpecialScorePose = "PlayerMonsterScorePoseAlt"
		},
		-- Palmis
		{
			Base = 8,
			Bench = 10,
			NilTable = {},
			SetTable = {},
			PlayerAttributeAuraModifier = 0,
			PlayerAttributeRespawnModifier = 0,
			PlayerAttributeSpeedModifier = 0,
			StartingSkills = { "PyreLastHitShield10", "DefenderAura" },
			Skills = {},
			MatchItems = {},
			MatchSkills = {},
			SkillTreeA = "PlayerTreeA",
			SkillTreeB = "PlayerTreeB",
			XP = 3875,
			TotalXP = 3875,
			Level = 3,
			MusicTheme = "/Music/MatchMusic2_MC",
			MusicStemName = "Guitars",
			MusicStemValue = 1,
			MaskHue = 70,
			MaskHue2 = 100,
			MaskSaturationAddition = -40,
			MaskSaturationAddition2 = -60,
			MaskValueAddition = 80,
			MaskValueAddition2 = 70
		},
	},
}
CustomRoster.config = config
config.TeamB = config.TeamA

ModUtil.WrapBaseFunction("PrepareLocalMPDraft", function(baseFunc, TeamAid, TeamBid)
		local TeamAbench = League[TeamAid].TeamBench
		local TeamBbench = League[TeamBid].TeamBench
		local nA = #TeamAbench
		local nB = #TeamBbench
		if nA == config.BaseCount and nB == config.BaseCount then
			for i,v in ipairs(config.TeamA) do
				local bench = League[v.Bench]
				local character = DeepCopyTable(bench.TeamBench[v.Base])

				ModUtil.MapNilTable(character,v.NilTable)
				ModUtil.MapSetTable(character,v.SetTable)
				character.StartingSkills = DeepCopyTable(v.StartingSkills)
				character.Skills = DeepCopyTable(v.Skills)
				character.MatchItems = DeepCopyTable(v.MatchItems)
				character.MatchSkills = DeepCopyTable(v.MatchSkills)
				character.CharacterIndex = nA+i
				character.TeamIndex = TeamAid
			
				character.MaskHue = v.MaskHue 
				character.MaskSaturationAddition = v.MaskSaturationAddition
				character.MaskValueAddition = v.MaskValueAddition
				character.MaskHue2 = v.MaskHue2
				character.MaskSaturationAddition2 = v.MaskSaturationAddition2
				character.MaskValueAddition2 = v.MaskValueAddition2
				
				character.SkillTreeA = v.SkillTreeA
				character.SkillTreeB = v.SkillTreeB
				character.PlayerAttributeAuraModifier = v.PlayerAttributeAuraModifier
				character.PlayerAttributeRespawnModifier = v.PlayerAttributeRespawnModifier
				character.PlayerAttributeSpeedModifier = v.PlayerAttributeSpeedModifier
				character.XP = v.XP
				character.TotalXP = v.TotalXP
				character.Level = v.Level
				character.MusicTheme = v.MusicTheme
				character.MusicStemValue = v.MusicStemValue
				
				if i ~= 7 then
					character.SpecialScorePose = v.SpecialScorePose
				end
				UnequipUpgradeItem(character, false)
				ResetArchetypeDefaultAttributes(character)
			
				TeamAbench[character.CharacterIndex] = character
			end
			for i,v in ipairs(config.TeamB) do
				local bench = League[v.Bench]
				local character = DeepCopyTable(bench.TeamBench[v.Base])
				ModUtil.MapNilTable(character,v.NilTable)
				ModUtil.MapSetTable(character,v.SetTable)
				character.StartingSkills = DeepCopyTable(v.StartingSkills)
				character.Skills = DeepCopyTable(v.Skills)
				character.MatchItems = DeepCopyTable(v.MatchItems)
				character.MatchSkills = DeepCopyTable(v.MatchSkills)
				character.CharacterIndex = nB+i
				character.TeamIndex = TeamBid
			
				character.MaskHue = v.MaskHue 
				character.MaskSaturationAddition = v.MaskSaturationAddition
				character.MaskValueAddition = v.MaskValueAddition
				character.MaskHue2 = v.MaskHue2
				character.MaskSaturationAddition2 = v.MaskSaturationAddition2
				character.MaskValueAddition2 = v.MaskValueAddition2
				
				character.SkillTreeA = v.SkillTreeA
				character.SkillTreeB = v.SkillTreeB
				character.PlayerAttributeAuraModifier = v.PlayerAttributeAuraModifier
				character.PlayerAttributeRespawnModifier = v.PlayerAttributeRespawnModifier
				character.PlayerAttributeSpeedModifier = v.PlayerAttributeSpeedModifier
				character.XP = v.XP
				character.TotalXP = v.TotalXP
				character.Level = v.Level
				character.MusicTheme = v.MusicTheme
				character.MusicStemValue = v.MusicStemValue
						
				if i ~= 7 then
					character.SpecialScorePose = v.SpecialScorePose
				end
				UnequipUpgradeItem(character, false)
				ResetArchetypeDefaultAttributes(character)
		
				TeamBbench[character.CharacterIndex] = character
			end
		end
		
		return baseFunc(TeamAid,TeamBid)

end, CustomRoster)
