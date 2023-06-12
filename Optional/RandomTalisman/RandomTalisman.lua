ModUtil.WrapBaseFunction("EquipUpgradeItem", function(baseFunc, character, upgradeItem)
    if upgradeItem.UpgradeName ~= "RandomTalismanModItem" then
        return baseFunc(character, upgradeItem)
    end


    -- local uniqueItemNames =
    -- {
    --     "UniqueMediumItem01",
    --     "UniqueLargeItem01",
    --     "UniqueSmallItem01",
    --     "UniqueMediumAltItem01",
    --     "UniqueImpItem01",
    --     "UniqueTrailItem01",
    --     "UniqueFlyingItem01",
    --     "UniqueTreeItem01",
    --     "UniqueMonsterItem01",
    -- }

    local possibleUpgrades = {
        "PlusRespawnItem",
        "PlusSpeedItem",
        "PlusAuraItem",
        "CursedItem01",
        "CursedItem02",
        "CursedItem03",
        "SetItem01",
        "SetItem02",
        "CarrySpeedItem",
        "TossChargeTimeItem",
        "AuraCastRangeItem",
        "PyreDamageItem",
        "SacrificeDamageItem",
        "ThrowDamageItem",
        "LosingScoreItem",
        "WinningScoreItem",
        "SacrificeScoreRespawnItem",
        "PyreLastHitShieldItem",
        "GoalHealItem",
        "PyreHealthItem",
        "PyrePreDamageItem",
        "QuickRespawnItem",
        "KillsRegenerateStaminaItem",
        "KillsRespawnFriendsItem",
        "PassOnDeathItem",
        "TeamStaminaRechargeItem",
        "StaminaOnBallPickupItem",
        "GoalLifeStealItem",
        "AuraSpikeKillItem",
        "JumpBashItem",
        "RespawnWeaponItem",
        "TeamHeadwindsItem",
        "PowerUpDropOnKillItem",
        "KillDetonateItem",
        "TossDistanceItem",
        "EnemyRespawnIncreaseItem",
    }

    local itemName = possibleUpgrades[math.random(#possibleUpgrades)]
    local newItem = DeepCopyTable(CreateItem("RandomTalismanModItem"))
    local otherItem = DeepCopyTable(CreateItem(itemName))
    print("Applied " .. itemName .. " instead")
    newItem.UpgradeName = otherItem.UpgradeName
    newItem.SkillName = otherItem.SkillName
    newItem.TraitName = otherItem.TraitName

    newItem.SkillValue = nil
	newItem.SkillValuePercent = nil
	newItem.SkillValuePercentInverse = nil
	newItem.SkillValuePercentMultiplier = nil

	if otherItem.SkillPower == nil then
		return baseFunc(character, upgradeItem)
	end
    if otherItem.SkillPowerCap ~= nil then
        otherItem.SkillPower = otherItem.SkillPowerCap
    end

	local base = otherItem.SkillPowerBase or 0
	local multiplier = otherItem.SkillPowerMultiplier or 1

	newItem.SkillValue = base + (otherItem.SkillPower * multiplier)
	if otherItem.RoundSkillValue then
		newItem.SkillValue = math.floor( newItem.SkillValue )
	end
	newItem.SkillValuePercent = round( newItem.SkillValue * 100 )
	newItem.SkillValuePercentInverse = round( 100 - newItem.SkillValuePercent )
	newItem.SkillValuePercentMultiplier = round( newItem.SkillValuePercent - 100 )

	RemoveItemSkillPowerPreview( newItem )

    return baseFunc(character, newItem)

end, RandomTalisman)

-- CreateItem = function( name, doSetup )

-- 	local itemTemplate = ItemData[name]
--     if doSetup == nil or doSetup == true then
-- 	    SetupItem( itemTemplate, name)
--     end
-- 	local createdItem = ShallowCopyTable( itemTemplate )
-- 	createdItem.GridPage = -1
-- 	createdItem.GridLocationX = -1
-- 	createdItem.GridLocationY = -1
-- 	if createdItem.CostMin ~= nil and createdItem.CostMax ~= nil then
-- 		createdItem.Cost = math.random(createdItem.CostMin, createdItem.CostMax)
-- 	end
-- 	return createdItem

-- end