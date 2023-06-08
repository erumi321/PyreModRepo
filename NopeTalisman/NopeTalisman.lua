ModUtil.RegisterMod("NopeTalisman")

OnAnyLoad{function (triggerArgs)
    if ItemData["OnDeathStunItem"] == nil then
        ItemData["OnDeathStunItem"] = {
            Type = "Upgrade", SkillName = "OnDeathStunItem",
            SkillPowerCap = 1,
            Cost = 75, Icon = "GUI\\Icons\\Items\\nope", Useable = false, RefundFraction = 0.5,
            PickupSound = "/SFX/Menu Sounds/TalismanRockUp", DropSound = "/SFX/Menu Sounds/TalismanRockDown", EquipSound = "/SFX/Menu Sounds/TalismanRockEquip",
        }
        ItemStoreUpdateData["MegaStore"]["OnDeathStunItem"] = { MatchesPlayed = 6 }
    end
end}