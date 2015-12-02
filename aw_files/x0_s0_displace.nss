//::///////////////////////////////////////////////
//:: Displacement
//:: x0_s0_displace
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target gains a 50% concealment bonus.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////

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
if (GetLocalInt(OBJECT_SELF, "Throw") != TRUE)
{
object oArea = GetArea(OBJECT_SELF);
location lThrow = GetRandomLocation(oArea, OBJECT_SELF, 10.0);
object oTarget = GetSpellTargetObject();
effect eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
SetLocalInt(OBJECT_SELF, "Throw", TRUE);
DelayCommand(RoundsToSeconds(2), DeleteLocalInt(OBJECT_SELF, "Throw"));
FloatingTextStringOnCreature("You may fling an opponent again in 12 seconds.", OBJECT_SELF);
effect eDam = EffectDamage(d10(3), DAMAGE_TYPE_DIVINE);
effect eKD = EffectKnockdown();
DelayCommand(0.2, AssignCommand(oTarget, ActionJumpToLocation(lThrow)));
DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKD, oTarget, RoundsToSeconds(1)));
}
}
else
{

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDisplace;
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);


    int nMetaMagic = GetMetaMagicFeat();
    int nRaise = GetCasterLevel(OBJECT_SELF) / 2;
    int nDuration = GetCasterLevel(OBJECT_SELF);

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    eDisplace = EffectConcealment(50);
    if (GetEffectType(eDisplace) != EFFECT_TYPE_INVALIDEFFECT)
    {
        effect eLink = EffectLinkEffects(eDisplace, eDur);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPLACEMENT, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}
}




