-- Made by C0re

function PrepareLocalMPDraft( playerTeamIndex, opposingTeamIndex )

	local simulatedCharacterLevel = GetConfigOptionValue({ Name = "LocalMPCharacterLevel" })
	local simulatedPlayerMatches = 10
	local simulatedMatchesVsOpponent = 1

	SetLocalMPTeamIndicies( playerTeamIndex, opposingTeamIndex )
	League[playerTeamIndex].MatchesPlayed = simulatedPlayerMatches
	League[opposingTeamIndex].LossesVsPlayer = simulatedMatchesVsOpponent

	if not ForceShortIntro then
		-- Activate everyone
		for k, character in pairs( League[playerTeamIndex].TeamBench ) do
			character.RosterStatus = "Active"
			UnequipUpgradeItem( character, true )
			if simulatedCharacterLevel > 0 then
				character.Level = simulatedCharacterLevel
				character.SkillPoints = character.Level - 1
				character.XP = 0
				SimulateXP( character )
				RemoveNonItemSkills( character )			
				if character.FirstName == "Rivals_Nightwing_FirstName" then	
					ResetDefaultAttributes( character, PlayerData.Teams[12].TeamBench[character.CharacterIndex] )
				else
					ResetArchetypeDefaultAttributes( character )
				end
			else
				character.Level = PlayerData.Teams[12].TeamBench[character.CharacterIndex].Level
				character.TotalXP = PlayerData.Teams[12].TeamBench[character.CharacterIndex].TotalXP
				character.XP = GetLevelXp( character )
				character.SkillPoints = 0
				RemoveNonItemSkills( character )
				ResetDefaultAttributes( character, PlayerData.Teams[12].TeamBench[character.CharacterIndex] )
				if character.StartingSkills ~= nil then
					for k, skillName in pairs( character.StartingSkills ) do
						AddSkill( character, skillName )
					end
				end
			end
			--UnequipUpgradeItem( character, true )
			character.Undraftable = nil
		end
		for k, character in pairs( League[opposingTeamIndex].TeamBench ) do
			character.RosterStatus = "Active"
			UnequipUpgradeItem( character, true )
			if simulatedCharacterLevel > 0 then
				character.Level = simulatedCharacterLevel
				character.SkillPoints = character.Level - 1
				character.XP = 0
				SimulateXP( character )
				RemoveNonItemSkills( character )
				if character.FirstName == "Rivals_Nightwing_FirstName" then
					ResetDefaultAttributes( character, PlayerData.Teams[13].TeamBench[character.CharacterIndex] )	
				else
					ResetArchetypeDefaultAttributes( character )
				end
			else
				character.Level = PlayerData.Teams[13].TeamBench[character.CharacterIndex].Level
				character.TotalXP = PlayerData.Teams[13].TeamBench[character.CharacterIndex].TotalXP
				character.XP = GetLevelXp( character )
				character.SkillPoints = 0
				RemoveNonItemSkills( character )
				ResetDefaultAttributes( character, PlayerData.Teams[13].TeamBench[character.CharacterIndex] )
				if character.StartingSkills ~= nil then
					for k, skillName in pairs( character.StartingSkills ) do
						AddSkill( character, skillName )
					end
				end
			end
			--UnequipUpgradeItem( character, true )
			character.Undraftable = nil
		end

		if GetConfigOptionValue({ Name = "LocalMPUseItems" }) then
			PlayerTeam.TeamQuestStash = {}
			for itemName, storeData in pairs( ItemStoreUpdateData["MegaStore"] ) do
				local itemData = ItemData[itemName]
				if CanUseItemLocalMP( itemData ) then
					if itemData.SkillPower ~= nil and itemData.SkillPowerCap ~= nil then
						itemData.SkillPower = itemData.SkillPowerCap
					end
					local mpItem = CreateItem( itemName )
					mpItem.Cost = 0
					table.insert( PlayerTeam.TeamQuestStash, mpItem )
				end
			end
			for tableName, lootTable in pairs( LootDropTables ) do
				for k, itemName in pairs( lootTable ) do
					local itemData = ItemData[itemName]
					if CanUseItemLocalMP( itemData ) and not HasItem( itemName ) then
						if itemData.SkillPower ~= nil and itemData.SkillPowerCap ~= nil then
							itemData.SkillPower = itemData.SkillPowerCap
						end
						local mpItem = CreateItem( itemName )
						mpItem.Cost = 0
						table.insert( PlayerTeam.TeamQuestStash, mpItem )
					end
				end
			end
			for tableName, lootTable in pairs( InteractiveForageItems ) do
				for k, itemName in pairs( lootTable ) do
					local itemData = ItemData[itemName]
					if CanUseItemLocalMP( itemData ) and not HasItem( itemName ) then
						if itemData.SkillPower ~= nil and itemData.SkillPowerCap ~= nil then
							itemData.SkillPower = itemData.SkillPowerCap
						end
						local mpItem = CreateItem( itemName )
						mpItem.Cost = 0
						table.insert( PlayerTeam.TeamQuestStash, mpItem )
					end
				end
			end

			local uniqueItemNames =
			{
				"UniqueMediumItem01",
				"UniqueLargeItem01",
				"UniqueSmallItem01",
				"UniqueMediumAltItem01",
				"UniqueImpItem01",
				"UniqueTrailItem01",
				"UniqueFlyingItem01",
				"UniqueTreeItem01",
				"UniqueMonsterItem01",
			}
			for k, itemName in ipairs( uniqueItemNames ) do
				local itemData = ItemData[itemName]
				if itemData.SkillPower ~= nil and itemData.SkillPowerCap ~= nil then
					itemData.SkillPower = itemData.SkillPowerCap
				end
				local uniqueItem = CreateItem( itemName )
				uniqueItem.TooltipId = uniqueItem.ItemName.."_LocalMP"
				uniqueItem.Cost = 0
				table.insert( PlayerTeam.TeamQuestStash, uniqueItem )
			end

			local extraItems =
			{
				"PlusSpeedItem",
			}
			for k, itemName in ipairs( extraItems ) do
				local itemData = ItemData[itemName]
				if CanUseItemLocalMP( itemData ) and not HasItem( itemName ) then
					if itemData.SkillPower ~= nil and itemData.SkillPowerCap ~= nil then
						itemData.SkillPower = itemData.SkillPowerCap
					end
					local mpItem = CreateItem( itemName )
					mpItem.Cost = 0
					table.insert( PlayerTeam.TeamQuestStash, mpItem )
				end
			end

			table.sort( PlayerTeam.TeamQuestStash, ItemSortAlphabetical )
			NextTeam.TeamQuestStash = DeepCopyTable( PlayerTeam.TeamQuestStash )

		end
	end

	SetupMatchTeams( PlayerTeam, NextTeam )

	--HideCharactersForDemo( PlayerTeam, NextTeam )

end