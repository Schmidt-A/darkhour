//::///////////////////////////////////////////////
//:: Deadly Fire Trap
//:: NW_T1_FireDeadC
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does 14d6 damage to all within 10 ft.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 4th, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 27, 2001
#include "NW_I0_SPELLS"
#include "inc_bs_module"

void main()
{
    //Declare major variables
    int bValid;
    object oCreator = GetTrapCreator(OBJECT_SELF);
    object oTarget = GetEnteringObject();
    location lTarget = GetLocation(oTarget);
    int nDamage;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;
    int nSaveDC = 26;
    int nSave = 0;
    //Get first object in the target area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget);
    //Cycle through the target area until all object have been targeted
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {

            //Roll damage
            nDamage = d6(25);

            //Adjust the trap damage based on the feats of the target
            if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nSaveDC, SAVING_THROW_TYPE_TRAP))
            {
                if (GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
                {
                    nDamage /= 2;
                }
            }
            else if (GetHasFeat(FEAT_EVASION, oTarget) || GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
            {
                nDamage = 0;
                nSave = 1;
            }
            else
            {
                nDamage /= 2;
            }
            if ( !GetKillRangeResult(oCreator, oTarget) )
            {
               //Roll damage
               nDamage = 0;
            }
            if (nDamage > 0)
            {
                //Set damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                if (nDamage > 0)
                {
                    //Apply effects to the target.
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

                //if target is dead save the trap creator to be a killer
                if ( ( GetIsDead(oTarget) || GetCurrentHitPoints(oTarget) <= 0 ) && GetKillRangeResult(oCreator, oTarget) ) SetLocalObject(oTarget,"sKiller",oCreator);

                }
            }
            else if (!nSave) //they are out of range and failed the save
            {
            //apply some slow effect
             ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(), oTarget, 8.0f);
             ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE,20), oTarget, 8.0f);
             ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FLAME_S),oTarget, 8.0f);
            }
        }
        //Get next target in shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget);
        nSave = 0;
    }
}

