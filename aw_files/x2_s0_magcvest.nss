//::///////////////////////////////////////////////
//:: Magic Vestment
//:: X2_S0_MagcVest
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Grants a +1 AC bonus to armor touched per 3 caster
  levels (maximum of +5).
*/
//Now applies armor AC as a character buff. -Moff
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 28, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 09, 2003
//:: 2003-07-29: Rewritten, Georg Zoeller

#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"

void main()
{

    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
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
    effect eVis = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    object oTarget = GetSpellTargetObject();
    int nDuration  = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nAmount = GetCasterLevel(OBJECT_SELF)/5;
    if (nAmount <0)
    {
        nAmount =1;
    }
    else if (nAmount>5)
    {
        nAmount =5;
    }

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    effect eAC = EffectACIncrease(nAmount, AC_ARMOUR_ENCHANTMENT_BONUS);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, HoursToSeconds(nDuration));
    DelayCommand(1.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, HoursToSeconds(nDuration));
}
