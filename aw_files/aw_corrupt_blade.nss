#include "x2_i0_spells"
//added dragon bane properties - riddler 2005-4-25
void main()
{

    int nCasterLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD);

    if (nCasterLevel == 0)
    {
      FloatingTextStringOnCreature("You are not a blackguard",OBJECT_SELF,FALSE);
      return;
    }
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);

    float fDuration = TurnsToSeconds(nCasterLevel/3);

    int nBonus = IP_CONST_DAMAGEBONUS_1d4;
    if (nCasterLevel >= 20) nBonus = IP_CONST_DAMAGEBONUS_1d10;
    else if (nCasterLevel >= 15 ) nBonus = IP_CONST_DAMAGEBONUS_1d8;
    else if (nCasterLevel >= 10 ) nBonus = IP_CONST_DAMAGEBONUS_1d6;

    IPSafeAddItemProperty(oWep, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON, IP_CONST_DAMAGETYPE_MAGICAL,nBonus),fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
    IPSafeAddItemProperty(oWep, ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,7),fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
    IPSafeAddItemProperty(oWep, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_NEGATIVE,nBonus),fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
    IPSafeAddItemProperty(oWep, ItemPropertyVisualEffect(ITEM_VISUAL_EVIL), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);

    effect eVis = EffectVisualEffect(246);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
}
