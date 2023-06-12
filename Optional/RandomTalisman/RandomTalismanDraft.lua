ModUtil.RegisterMod("RandomTalisman")

ItemData["RandomTalismanModItem"] = {
    Type = "Upgrade", UpgradeName = "RandomTalismanModItem", SkillPowerCap = 1,
    Cost = 45, Icon = "GUI\\Portraits\\Anon_01B", Useable = false, RefundFraction = 0.5,
    PickupSound = "/SFX/Menu Sounds/TalismanGlassUp", DropSound = "/SFX/Menu Sounds/TalismanGlassDown", EquipSound = "/SFX/Menu Sounds/TalismanGlassEquip",
}

ModUtil.WrapBaseFunction("PrepareLocalMPDraft", function(baseFunc, ...)
    local a = baseFunc(...)

    local mpItem = CreateItem( "RandomTalismanModItem" )
    mpItem.Cost = 0
    table.insert( PlayerTeam.TeamQuestStash, mpItem )

    return a
end, RandomTalisman)