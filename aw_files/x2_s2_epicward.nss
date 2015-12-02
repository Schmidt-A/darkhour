//::///////////////////////////////////////////////
//:: Epic Ward
//:: X2_S2_EpicWard.
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the caster invulnerable to damage
    (equals damage reduction 50/+20)
    Lasts 1 round per level

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: Aug 12, 2003
//:://////////////////////////////////////////////


#include "nw_i0_spells"

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
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    //Couples of things to stop epic warding in The Hunt
    int nMonster = GetLocalInt(oTarget, "Monster");
    int nHunter = GetLocalInt(oTarget, "Hunter");
    if ( (nMonster < 1) && (nHunter != TRUE) )
    {
    int nDuration = GetCasterLevel(OBJECT_SELF);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    int nLimit = 50*nDuration;
    effect eDur = EffectVisualEffect(495);
    effect eDI1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 50);
    effect eDI2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 50);
    effect eDI3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 50);
    effect eLink = EffectLinkEffects(eDur, eDI1);
    eLink = EffectLinkEffects(eLink, eDI2);
    eLink = EffectLinkEffects(eLink, eDI3);
    eLink = EffectLinkEffects(eLink, eDur);

    // * Brent, Nov 24, making extraodinary so cannot be dispelled
    eLink = ExtraordinaryEffect(eLink);

    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
    //Apply the armor bonuses and the VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    }
}
