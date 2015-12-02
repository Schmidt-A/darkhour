///::///////////////////////////////////////////////
//:: Improved Invisibility
//:: NW_S0_ImprInvis.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target creature can attack and cast spells while
    invisible
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook
int nRound = GetLocalInt(GetModule(), "nRound");
if (nRound >= 999)
{
    object oTarget = OBJECT_SELF;
    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_MIND);

    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);

    effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eCover = EffectConcealment(50);
    effect eLink = EffectLinkEffects(eDur, eCover);
    eLink = EffectLinkEffects(eLink, eVis);
    int nDuration = 24;
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget, TurnsToSeconds(nDuration));

    if ( GetLocalInt(oTarget, "Louse") != TRUE)
    {
    FloatingTextStringOnCreature("You may make your allies invisible again in 18 seconds.", OBJECT_SELF);
    effect eInvisA = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    eInvisA = EffectLinkEffects(eInvisA, eVis);
    SetLocalInt(OBJECT_SELF, "Louse", TRUE);
    DelayCommand(RoundsToSeconds(3), DeleteLocalInt(OBJECT_SELF, "Louse"));
    object oAlly = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oAlly))
    {
        if(GetIsFriend(oAlly))
        {

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvisA, oAlly, HoursToSeconds(24));
        }
        oAlly = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
    }
}
else
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_MIND);

    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nConceal;
    if (GetLastSpellCastClass() != CLASS_TYPE_INVALID)
    {
        nConceal = 10 + nDuration;
    }
    else
    {
        nConceal = 10 + GetHitDice(OBJECT_SELF);
    }
    effect eCover = EffectConcealment(nConceal);
    effect eLink = EffectLinkEffects(eDur, eCover);
    eLink = EffectLinkEffects(eLink, eVis);


    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPROVED_INVISIBILITY, FALSE));
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget, TurnsToSeconds(nDuration));
}
}


