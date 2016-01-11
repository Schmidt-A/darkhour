void RemoveProperty(object oItem, int nProperty)
{
    itemproperty ipLoop=GetFirstItemProperty(oItem);

    //Loop for as long as the ipLoop variable is valid
    while (GetIsItemPropertyValid(ipLoop))
        {
        //If ipLoop is a true seeing property, remove it
        if (GetItemPropertyType(ipLoop)==nProperty)
        RemoveItemProperty(oItem, ipLoop);

        //Next itemproperty on the list...
        ipLoop=GetNextItemProperty(oItem);
        }
}
void main()
{
object oCleanPC = GetEnteringObject();
object oItem = GetFirstItemInInventory(oCleanPC);
if(GetCampaignInt("FixedCrafting",GetName(oCleanPC),oCleanPC)==TRUE)
{
return;
}
while(oItem != OBJECT_INVALID)
    {
    if(GetTag(oItem)=="crafted")
        {
        if(GetSubString(GetResRef(oItem),0,2)=="cr")
            {
                if(GetBaseItemType(oItem)==BASE_ITEM_HELMET)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,2),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SHORTBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_ARMOR)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_ARROW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BASTARDSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BATTLEAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BELT)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_BONUS_FEAT);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,2),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BOLT)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BOOTS)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_SKILL_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,2),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_QUARTERSTAFF)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BULLET)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_CLOAK)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HIDE,2),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SHORTSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DAGGER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DART)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_RAPIER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_GREATAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_GREATSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HALBERD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HANDAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HEAVYCROSSBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KAMA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KATANA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LARGESHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LIGHTCROSSBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SMALLSHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SCIMITAR)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_THROWINGAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_TOWERSHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_WARHAMMER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SLING)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
            }
        else if(GetSubString(GetResRef(oItem),0,2)=="mw")
            {
                if(GetBaseItemType(oItem)==BASE_ITEM_HELMET)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_DARKVISION);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,2),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SHORTBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_ARMOR)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_ARROW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyExtraRangeDamageType(IP_CONST_DAMAGETYPE_PIERCING),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BASTARDSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BATTLEAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BELT)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_BONUS_FEAT);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,2),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BOLT)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyExtraRangeDamageType(IP_CONST_DAMAGETYPE_PIERCING),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BOOTS)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_SKILL_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,2),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_QUARTERSTAFF)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BULLET)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyExtraRangeDamageType(IP_CONST_DAMAGETYPE_BLUDGEONING),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_CLOAK)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HIDE,2),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SHORTSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DAGGER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DART)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_RAPIER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_GREATAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_GREATSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HALBERD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HANDAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HEAVYCROSSBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MASSIVE_CRITICALS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KAMA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KATANA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LARGESHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LIGHTCROSSBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MASSIVE_CRITICALS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SMALLSHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SCIMITAR)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_THROWINGAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_TOWERSHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_WARHAMMER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SLING)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
            }
        }
    oItem = GetNextItemInInventory(oCleanPC);
    }
oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,oCleanPC);
if(GetSubString(GetResRef(oItem),0,2)=="cr")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,2),oItem);
            }
else if(GetSubString(GetResRef(oItem),0,2)=="mw")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_DARKVISION);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,2),oItem);
            }
oItem = GetItemInSlot(INVENTORY_SLOT_BELT,oCleanPC);
if(GetSubString(GetResRef(oItem),0,2)=="cr")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_BONUS_FEAT);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,2),oItem);
            }
else if(GetSubString(GetResRef(oItem),0,2)=="mw")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_BONUS_FEAT);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,2),oItem);
            }
oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS,oCleanPC);
if(GetSubString(GetResRef(oItem),0,2)=="cr")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_SKILL_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,2),oItem);
            }
else if(GetSubString(GetResRef(oItem),0,2)=="mw")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_SKILL_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,2),oItem);
            }
oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oCleanPC);
if(GetSubString(GetResRef(oItem),0,2)=="cr")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
            }
else if(GetSubString(GetResRef(oItem),0,2)=="mw")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),oItem);
            }
oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK,oCleanPC);
if(GetSubString(GetResRef(oItem),0,2)=="cr")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HIDE,2),oItem);
            }
else if(GetSubString(GetResRef(oItem),0,2)=="mw")
            {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HIDE,2),oItem);
            }
oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCleanPC);
if(GetSubString(GetResRef(oItem),0,2)=="cr")
            {
                if(GetBaseItemType(oItem)==BASE_ITEM_SHORTBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BASTARDSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BATTLEAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_QUARTERSTAFF)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SHORTSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DAGGER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DART)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_RAPIER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_GREATAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_GREATSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HALBERD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HANDAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HEAVYCROSSBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KAMA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KATANA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LIGHTCROSSBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SCIMITAR)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_THROWINGAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_WARHAMMER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SLING)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
            }
else if(GetSubString(GetResRef(oItem),0,2)=="mw")
            {
                if(GetBaseItemType(oItem)==BASE_ITEM_SHORTBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BASTARDSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BATTLEAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_QUARTERSTAFF)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SHORTSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DAGGER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DART)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_RAPIER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_GREATAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_GREATSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HALBERD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HANDAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HEAVYCROSSBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MASSIVE_CRITICALS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KAMA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KATANA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LIGHTCROSSBOW)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MASSIVE_CRITICALS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SCIMITAR)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_THROWINGAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_WARHAMMER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SLING)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_MIGHTY);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),oItem);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),oItem);
                }
            }
oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oCleanPC);
if(GetSubString(GetResRef(oItem),0,2)=="cr")
            {
                if(GetBaseItemType(oItem)==BASE_ITEM_BASTARDSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BATTLEAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SHORTSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DAGGER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_RAPIER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HANDAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KAMA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KATANA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LARGESHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SCIMITAR)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_WARHAMMER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_TOWERSHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                }
            }
else if(GetSubString(GetResRef(oItem),0,2)=="mw")
            {
                if(GetBaseItemType(oItem)==BASE_ITEM_BASTARDSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_BATTLEAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_QUARTERSTAFF)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SHORTSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_DAGGER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_RAPIER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_HANDAXE)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KAMA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_KATANA)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LARGESHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_LONGSWORD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SMALLSHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_SCIMITAR)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_TOWERSHIELD)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_AC_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),oItem);
                }
                else if(GetBaseItemType(oItem)==BASE_ITEM_WARHAMMER)
                {
                    RemoveProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS);
                    RemoveProperty(oItem,ITEM_PROPERTY_DAMAGE_BONUS);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(1),oItem);
                }
            }
SetCampaignInt("FixedCrafting",GetName(oCleanPC),TRUE,oCleanPC);
}
