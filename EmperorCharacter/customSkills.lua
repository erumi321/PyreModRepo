local skills ={
	{
		Name = "EmperorTeamBanishUpSkill",
		Tree = "PlayerEmperorA",
		Tier = 1,
		Prerequisites = { },
		GiveTrait = "PlusStamina05",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_speed_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_speed_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_speed",
	},
	{
		Name = "EmperorStealSpeedSkill",
		Tree = "PlayerEmperorA",
		Tier = 2,
		Prerequisites = { "EmperorTeamBanishUpSkill" },
		PlayerUnitUpgrade = true,
		GiveTrait = "EmperorStealSpeedSkill",
		Side = "Left",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_speed_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_speed_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_speed",
	},
	{
		Name = "EmperorBallStaminaSkill",
		Tree = "PlayerEmperorA",
		Tier = 2,
		Prerequisites = { "EmperorTeamBanishUpSkill" },
		PlayerUnitUpgrade = true,
		Side = "Right",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_evade_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_evade_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_evade",
	},

	{
		Name = "EmperorHeadwindsTauntSkill",
		Tree = "PlayerEmperorA",
		Tier = 3,
		Prerequisites = { "EmperorStealSpeedSkill", "EmperorBallStaminaSkill" },
		PlayerUnitUpgrade = true,
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_pyrehealth_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_pyrehealth_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_pyrehealth",
	},

	-- TREE B
	{
		Name = "EmperorDamageDownSkill",
		Tree = "PlayerEmperorB",
		Tier = 1,
		Prerequisites = { },
		PlayerUnitUpgrade = true,
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_stamina_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_stamina_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_stamina",
	},


	{
		Name = "EmperorTeamStaminaUpSkill",
		Tree = "PlayerEmperorB",
		Tier = 2,
		Prerequisites = { "EmperorDamageDownSkill" },
		PlayerUnitUpgrade = true,
		Side = "Left",
		GiveTrait = "EmperorTeamStaminaUpSkill",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_cast_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_cast_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_cast",
	},
	{
		Name = "EmperorTeamBallStaminaSkill",
		Tree = "PlayerEmperorB",
		Tier = 2,
		Prerequisites = { "EmperorDamageDownSkill" },
		PlayerUnitUpgrade = true,
		Side = "Right",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_respawn_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_respawn_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_respawn",
	},

	{
		Name = "EmperorTeamReviveSkill",
		Tree = "PlayerEmperorB",
		Tier = 3,
		Prerequisites = { "EmperorTeamStaminaUpSkill", "EmperorTeamBallStaminaSkill" },
		PlayerUnitUpgrade = true,
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_banishment_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_banishment_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_banishment",
	},
}
for i,v in ipairs(skills)do
PlayerSkillsTable[v.Name] = v
end
OnAnyLoad{function(triggerArgs)
table.insert(skillsToDistribute,"EmperorTeamBallSkill")
end}