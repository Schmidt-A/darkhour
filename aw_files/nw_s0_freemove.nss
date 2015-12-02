//::///////////////////////////////////////////////
//:: Freedom of Movement
//:: NW_S0_FreeMove.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The target creature gains immunity to the
    Entangle, Slow and Paralysis effects
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 21, 2001
#include "inc_bs_module"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
    effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
    effect eVis = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Link effects
    effect eLink = EffectLinkEffects(eParal, eEntangle);
    eLink = EffectLinkEffects(eLink, eSlow);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eMove);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FREEDOM_OF_MOVEMENT, FALSE));

    //Search for and remove the above negative effects
    effect eLook = GetFirstEffect(oTarget);
    // controlla che il caster non sia in possesso della bandiera
     ///Aggiunti//
    int nPCTeam = GetLocalInt(OBJECT_SELF, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);   // fine aggiunti///

    if (GetLocalObject(GetModule(), szEnemyHasFlag) == OBJECT_SELF && oTarget == OBJECT_SELF)
    {
    FloatingTextStringOnCreature("You can't use this spell when you hold the flag!",OBJECT_SELF , FALSE);
    }  ///fine aggiunta
    else {


    while(GetIsEffectValid(eLook))
        {
        if(GetEffectType(eLook) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eLook) == EFFECT_TYPE_ENTANGLE ||
            GetEffectType(eLook) == EFFECT_TYPE_SLOW ||
            GetEffectType(eLook) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
        {
            RemoveEffect(oTarget, eLook);
        }
        eLook = GetNextEffect(oTarget);
    }
    //Meta-Magic Checks
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    //Apply Linked Effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    }
}

