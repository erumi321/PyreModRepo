ModUtil.RegisterMod( "RestartRiteFix" )

--Author: Irotor
--Based on the original partial fix by Failer.

ModUtil.WrapBaseFunction( "PrepareLocalMPDraft", function(baseFunc, TeamAid, TeamBid)
		local TeamAbench = League[TeamAid].TeamBench
		local TeamBbench = League[TeamBid].TeamBench
		local simulatedCharacterLevel = GetConfigOptionValue({ Name = "LocalMPCharacterLevel" })
		if ForceShortIntro then
			for k,character in pairs(TeamAbench) do
				if simulatedCharacterLevel > 0 then
					character.Level = simulatedCharacterLevel
					character.SkillPoints = character.Level - 1
					character.XP = 0
					SimulateXP(character)
				else
					character.Level = PlayerData.Teams[12].TeamBench[character.CharacterIndex].Level
					character.TotalXP = PlayerData.Teams[12].TeamBench[character.CharacterIndex].TotalXP
					character.XP = GetLevelXp(character)
					character.SkillPoints = 0
				end
				local skills = {}
				local item = character.UpgradeItem
				local treeASkills = GetSkillsInTree(character.SkillTreeA)
				local treeBSkills = GetSkillsInTree(character.SkillTreeB)
				local allSkills = CombineTables(treeASkills, treeBSkills)
				for l,skillName in pairs(allSkills) do
					if HasSkillNotFromItem(character, skillName) then
						table.insert(skills,skillName)
					end
				end
				RemoveNonItemSkills(character)
				UnequipUpgradeItem(character, true)
                if character.FirstName == "Rivals_Nightwing_FirstName" or simulatedCharacterLevel <= 0 then
                    ResetDefaultAttributes(character, PlayerData.Teams[12].TeamBench[character.CharacterIndex])
                else
                    ResetArchetypeDefaultAttributes(character)
                end
				for i = 1,3,1 do
					for l,skillName in pairs(skills) do
						if PlayerSkillsTable[skillName].Tier == i then
							AddSkill(character,skillName)
							character.SkillPoints = character.SkillPoints-1
						end
					end	
				end	
				EquipUpgradeItem(character,item)
			end
			for k,character in pairs(TeamBbench) do
				if simulatedCharacterLevel > 0 then
					character.Level = simulatedCharacterLevel
					character.SkillPoints = character.Level - 1
					character.XP = 0
					SimulateXP(character)
				else
					character.Level = PlayerData.Teams[12].TeamBench[character.CharacterIndex].Level
					character.TotalXP = PlayerData.Teams[12].TeamBench[character.CharacterIndex].TotalXP
					character.XP = GetLevelXp(character)
					character.SkillPoints = 0
				end
				local skills = {}
				local item = character.UpgradeItem
				local treeASkills = GetSkillsInTree(character.SkillTreeA)
				local treeBSkills = GetSkillsInTree(character.SkillTreeB)
				local allSkills = CombineTables(treeASkills, treeBSkills)
				for l,skillName in pairs(allSkills) do
					if HasSkillNotFromItem(character, skillName) then
						table.insert(skills,skillName)
					end
				end
				RemoveAttributeModification(character, "RivalTeamAttitude")
				RemoveAttributeModification(character, "RivalTeamAura")
				RemoveAttributeModification(character, "RivalTeamSpeed")
				RemoveNonItemSkills(character)
				UnequipUpgradeItem(character, true)
                if character.FirstName == "Rivals_Nightwing_FirstName" or simulatedCharacterLevel <= 0 then
                    ResetDefaultAttributes( character, PlayerData.Teams[13].TeamBench[character.CharacterIndex] )
                else
                    ResetArchetypeDefaultAttributes( character )
                end
				for i = 1,3,1 do
					for l,skillName in pairs(skills) do
						if PlayerSkillsTable[skillName].Tier == i then
							AddSkill(character,skillName)
							character.SkillPoints = character.SkillPoints-1
						end
					end	
				end	
				EquipUpgradeItem(character,item)
				if ConstellationActive("RivalTeamAttitude") then
					ModifyAttributeTemporarily( character, "PlayerAttributeRespawn", 8, "RivalTeamAttitude")
				end
				if ConstellationActive("RivalTeamAura") then
					ModifyAttributeTemporarily( character, "PlayerAttributeAura", 8, "RivalTeamAura")
				end
				if ConstellationActive("RivalTeamSpeed") then
					ModifyAttributeTemporarily( character, "PlayerAttributeSpeed", 8, "RivalTeamSpeed")
				end
			end			
		end
		baseFunc(TeamAid,TeamBid)
end, RestartRiteFix)
