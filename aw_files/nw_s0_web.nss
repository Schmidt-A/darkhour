//::///////////////////////////////////////////////
//:: Web
//:: NW_S0_Web.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a mass of sticky webs that cling to
    and entangle target who fail a Reflex Save
    Those caught can make a new save every
    round.  Movement in the web is 1/6 normal.
    The higher the creatures Strength the faster
    they move out of the web.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 8, 2001
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


    //Declare major variables including Area of Effect Object
    effect eAOE = EffectVisualEffect(VFX_DUR_WEB_MASS);
    effect eWeb = EffectEntangle();
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    effect eLink = EffectLinkEffects(eWeb, eVis);

    location lTarget = GetSpellTargetLocation();
    int nDuration = 3;
    object oCaught = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    while(GetIsObjectValid(oCaught))
    {
        if ( (GetLocalInt(oCaught, "Caught") != TRUE) && (oCaught != OBJECT_SELF))
        {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCaught, RoundsToSeconds(3));
        SetLocalInt(oCaught, "Caught", TRUE);
        DelayCommand(RoundsToSeconds(9), DeleteLocalInt(oCaught, "Caught"));
        }
        oCaught = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));

}
else
{
    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_WEB);

    location lTarget = GetSpellTargetLocation();
    int nDuration = GetCasterLevel(OBJECT_SELF) / 2;
    int nMetaMagic = GetMetaMagicFeat();
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
}

