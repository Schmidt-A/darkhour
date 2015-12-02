//::///////////////////////////////////////////////
//:: x2_OnUnEquip
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script is the global XP2
    OnUnEquip script that fires wheneever
    an item is unequipped.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:: Editted By: Aez (02/07/09)
//:://////////////////////////////////////////////

void main()
{
    object oItem = GetPCItemLastUnequipped();
    object oPC = GetPCItemLastUnequippedBy();
    string sItemTag = GetTag(oItem);

int iCharge;
iCharge = GetItemCharges(oItem);
if (iCharge == 0){return;}

if((iCharge == 30) ||  //Dexer AC armor
        (iCharge == 31) ||
        (iCharge == 32) ||
        (iCharge == 33))
        {
        effect eEffect;
        eEffect = GetFirstEffect(oPC);
            //Search for Permanent Supernatural dodge AC
        while(GetIsEffectValid(eEffect))
            {
            if (GetEffectType(eEffect) == EFFECT_TYPE_AC_INCREASE)
                {
                if(GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT)
                    {
                    if(GetEffectSubType(eEffect) == SUBTYPE_SUPERNATURAL)
                        {
                        RemoveEffect(oPC, eEffect);
                        }
                    }
                }
            eEffect = GetNextEffect(oPC);
            }
        }

}
