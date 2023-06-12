# PyreModRepo
 A collection of the mods made for Pyre. Inside the MPStandard folder is the mods that are installed for Rite Night. Inside Optional are mods not used for Rite Night. And those in MPExperimental are those being tested to add to Rite Night. 
 
 # Installation Requirements
 All mods require installing ModUtil. To install the Music mod (NeverToReturnMP) or any of the character mods (EmperorCharacter, PhantomCharacter, ScribeCharacter) the legacy pyre modimporter must be installed from here: https://github.com/erumi321/sgg-mod-modimporter/tree/map (pyre_modimporter.py). 
 
 # Other Multiplayer Changes
 On top of the Standard Mods there are other hard changes to fix a few bugs they are:
 ### Sapling Nuke Fix
 Find the Pyre folder and go to `Content\Game\Weapons\UrsaWeapons.xml`, Ctrl+F to find "SaplingDetonate" and inside the `Upgrade` element change the `Change` element to: `<Change ValueChangeType="ABSOLUTE" DamageRadius="575"/>`
 ![Image: Text Reads: "<Weapon
	Name="SaplingDetonate"
	InheritFrom="AuraKillDetonate"
	Projectile="SaplingDetonate"
	ClearEffects="true"
	ClearUpgrades="true"
	DestroyUser="true"
	>
	<Upgrade Name="DefenderAura">
		<Change ValueChangeType="ABSOLUTE" DamageRadius="575"/>
	</Upgrade>
</Weapon>"](https://media.discordapp.net/attachments/517503102786469908/536322367002116098/unknown.png)

### Keyboard Salute Fix
Find the file MatchScripts.lua (at `Content\Scripts\MatchScripts.lua`) and find the function `PlayerTaunt`, replace the first if statment with:
```
if not skipInputRule then
    if introMatch then
        return
    end

    --Switch playerIndex for this check. Index 1 becomes 2, and vice-versa
    if (GetConfigOptionValue({ Name = "LocalMPHumanTeamA" })
    and GetConfigOptionValue({ Name = "LocalMPHumanTeamB" })
    and GetConfigOptionValue({ Name = "LocalMPMouseIndex" }) == 0
    and GetNumConnectedControllers({ }) <= 1 )
    or (GetConfigOptionValue({ Name = "LocalMPHumanTeamB" })
    and not GetConfigOptionValue({ Name = "LocalMPHumanTeamA" }))
    then
        if IsControlDown({ Names = { "Sprint", "Jump", "Cast" }, PlayerIndex = 3 - tauntingPlayer }) then
            return
        end
        else
        if IsControlDown({ Names = { "Sprint", "Jump", "Cast" }, PlayerIndex = tauntingPlayer }) then
            return
        end
    end

    if not IsInputAllowed({ PlayerIndex = tauntingPlayer }) then
        return
    end
end
```

### Fell Swoop Lock-on Fix
In `CombatScripts.lua` (`Content\Scripts\CombatScripts.lua`) near Line 1157 replace the line 
```
FireWeaponFromUnit({ Weapon = "DoubleCastDetonate", Id = triggerArgs.triggeredById })
```
with
```
FireWeaponFromUnit({ Weapon = "DoubleCastDetonate", Id = triggerArgs.triggeredById, DestinationId = triggerArgs.triggeredById })
```
