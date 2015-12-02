//::///////////////////////////////////////////////
//:: Tymora's Smile
//:: x0_s2_HarpSmile
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    +2 luck bonus on all saving throws for 5 turns.

    past 5
    Gain an additional +2 on saving throws vs. spells every 3levels (6, 9, 12 et cetera )
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2002
//:: Updated On: Jul 21, 2003 Georg -
//                            Epic Level progession
//:://////////////////////////////////////////////
#include "nw_i0_spells"

void main()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_HARPER, oCaster);
    effect eMind = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    effect eMindVis = EffectLinkEffects(eMind, eVis);
    eMindVis = ExtraordinaryEffect(eMindVis);

    //Apply the effects (mind immunity and visual effect).
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMindVis, oCaster, RoundsToSeconds(15));
}
