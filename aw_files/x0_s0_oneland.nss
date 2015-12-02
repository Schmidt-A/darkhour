//::///////////////////////////////////////////////
//:: One with the Land
//:: x0_s0_oneland.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
 bonus +3: animal empathy, move silently, search, hide
 Duration: 1 hour/level
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: July 19, 2002
//:://////////////////////////////////////////////
//:: Last Update By: Andrew Nobbs May 01, 2003
#include "NW_I0_SPELLS"

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
if (GetLocalInt(OBJECT_SELF, "Land") != TRUE)
{
FloatingTextStringOnCreature("You may use this ability again in 60 seconds.", OBJECT_SELF);
SetLocalInt(OBJECT_SELF, "Land", TRUE);
DelayCommand(RoundsToSeconds(10), DeleteLocalInt(OBJECT_SELF, "Land"));
effect eConceal = EffectConcealment(20);
effect eVis = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConceal, OBJECT_SELF, RoundsToSeconds(10));
ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    object oAlly = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oAlly))
    {
        if(GetIsFriend(oAlly))
        {

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConceal, oAlly, RoundsToSeconds(10));
        }
        oAlly = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
}
else
{

    //Declare major variables
    object oTarget = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    int nMetaMagic = GetMetaMagicFeat();

    effect eSkillAnimal = EffectSkillIncrease(SKILL_ANIMAL_EMPATHY, 4);
    effect eHide = EffectSkillIncrease(SKILL_HIDE, 4);
    effect eMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 4);
    effect eSearch = EffectSkillIncrease(SKILL_SET_TRAP, 4);

    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eSkillAnimal, eMove);
    eLink = EffectLinkEffects(eLink, eHide);
    eLink = EffectLinkEffects(eLink, eSearch);

    eLink = EffectLinkEffects(eLink, eDur);

    int nDuration = GetCasterLevel(OBJECT_SELF); // * Duration 1 hour/level
     if (nMetaMagic == METAMAGIC_EXTEND)    //Duration is +100%
    {
         nDuration = nDuration * 2;
    }

    //Fire spell cast at event for target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 420, FALSE));
    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
 }
}





