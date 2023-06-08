local skills ={
	{
		Name = "PhantomFartherCastSkill",
		Tree = "PlayerPhantomA",
		Tier = 1,
		Prerequisites = { },
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_speed_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_speed_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_speed",
	},
	{
		Name = "PhantomStealEnemyGlory",
		Tree = "PlayerPhantomA",
		Tier = 2,
		Prerequisites = { "PhantomFartherCastSkill" },
		PlayerUnitUpgrade = true,
		Side = "Left",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_speed_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_speed_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_speed",
	},
	{
		Name = "PhantomLingerAuraSkill",
		Tree = "PlayerPhantomA",
		Tier = 2,
		Prerequisites = { "PhantomFartherCastSkill" },
		PlayerUnitUpgrade = true,
		Side = "Right",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_evade_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_evade_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_evade",
	},

	{
		Name = "PhantomBanishFall",
		Tree = "PlayerPhantomA",
		Tier = 3,
		Prerequisites = { "PhantomStealEnemyGlory", "PhantomLingerAuraSkill" },
		PlayerUnitUpgrade = true,
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_pyrehealth_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_pyrehealth_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_pyrehealth",
	},

	-- TREE B
	{
		Name = "PhantomHalfRespawnTimeSkill",
		Tree = "PlayerPhantomB",
		Tier = 1,
		Prerequisites = { },
		PlayerUnitUpgrade = true,
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_stamina_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_stamina_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_stamina",
	},


	{
		Name = "PhantomStaminaDeadSkill",
		Tree = "PlayerPhantomB",
		Tier = 2,
		Prerequisites = { "PhantomHalfRespawnTimeSkill" },
		PlayerUnitUpgrade = true,
		Side = "Left",
		GiveTrait = "PhantomStaminaDeadSkill",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_cast_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_cast_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_cast",
	},
	{
		Name = "PhantomStunBanisherSkill",
		Tree = "PlayerPhantomB",
		Tier = 2,
		Prerequisites = { "PhantomHalfRespawnTimeSkill" },
		PlayerUnitUpgrade = true,
		Side = "Right",
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_respawn_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_respawn_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_respawn",
	},

	{
		Name = "PhantomTauntSwapStatusSkill",
		Tree = "PlayerPhantomB",
		Tier = 3,
		Prerequisites = { "PhantomStaminaDeadSkill", "PhantomStunBanisherSkill" },
		PlayerUnitUpgrade = true,
		UnpickedIcon = "GUI\\Icons\\Skills\\skill_icon_banishment_locked",
		AvailableIcon = "GUI\\Icons\\Skills\\skill_icon_banishment_available",
		PickedIcon = "GUI\\Icons\\Skills\\skill_icon_banishment",
	},
}
for i,v in ipairs(skills)do
PlayerSkillsTable[v.Name] = v
end