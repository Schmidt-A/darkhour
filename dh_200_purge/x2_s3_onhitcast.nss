//::///////////////////////////////////////////////
//:: User Defined OnHitCastSpell code
//:: x2_s3_onhitcast
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This file can hold your module specific
    OnHitCastSpell definitions

    How to use:
    - Add the Item Property OnHitCastSpell: UniquePower (OnHit)
    - Add code to this spellscript (see below)

   WARNING!
   This item property can be a major performance hog when used
   extensively in a multi player module. Especially in higher
   levels, with each player having multiple attacks, having numerous
   of OnHitCastSpell items in your module this can be a problem.

   It is always a good idea to keep any code in this script as
   optimized as possible.


*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-22
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "_incl_pc_data"

void main()
{

    object oItem;        // The item casting triggering this spellscript
    object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
    object oSpellOrigin; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor

    // fill the variables
    oSpellOrigin = OBJECT_SELF;
    oSpellTarget = GetSpellTargetObject();
    oItem        =  GetSpellCastItem();
    if ((GetIsObjectValid(oItem)) && (GetIsPC(oSpellTarget)) &&
            (GetIsPossessedFamiliar(oSpellTarget) == FALSE))
    {
        // Make sure we don't slow/disease if they're sanctuary'd
        int nSanct = FALSE;
        effect eCheck = GetFirstEffect(oSpellTarget);
        while (GetEffectType(eCheck) != EFFECT_TYPE_INVALIDEFFECT)
        {
            if (GetEffectType(eCheck) == EFFECT_TYPE_SANCTUARY)
                nSanct = TRUE;
            eCheck = GetNextEffect(oSpellTarget);
        }
        if (nSanct == FALSE)
        {
            int iPCClass = GetClassByPosition(1, oSpellTarget);
            if (iPCClass != CLASS_TYPE_PALADIN || !GetHasFeat(FEAT_DIVINE_HEALTH, oSpellTarget))
            {
                if (FortitudeSave(oSpellTarget,9,SAVING_THROW_TYPE_DISEASE) == 0)
                {
                    int iDisease = PCDGetDiseaseValue(oSpellTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DISEASE_S),oSpellTarget);
                    PCDSetDiseaseValue(oSpellTarget, iDisease+1);
                    FloatingTextStringOnCreature("You have been diseased!",oSpellTarget,FALSE);
                }
            }
            if (iPCClass != CLASS_TYPE_MONK || !GetHasFeat(FEAT_MONK_AC_BONUS, oSpellTarget))
            {
                if (FortitudeSave(oSpellTarget,7) == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_SLOW),oSpellTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedDecrease(50),oSpellTarget,15.0);
                }
            }
        }
    }
}
