//::///////////////////////////////////////////////
//:: Etherealness
//:: x0_s0_ether.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Like sanctuary except almost always guaranteed
    to work.
    Lasts one turn per level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "inc_bs_module"
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

///Antiworld CTF G Sanct with flag Prevention ///
    int nPCTeam = GetLocalInt(OBJECT_SELF, "nTeam");
    int nEnemyTeam = 3-nPCTeam;
    string szEnemyHasFlag = "oHasFlag_"+IntToString(nEnemyTeam);

    if(GetLocalObject(GetModule(),szEnemyHasFlag) == OBJECT_SELF)
    {
    FloatingTextStringOnCreature("You can't use this spell when you hold the flag!",OBJECT_SELF);
    }
    else {   /// end of aw thing ///

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSanc = EffectSanctuary(GetSpellSaveDC());

    effect eLink = EffectLinkEffects(eVis, eSanc);
    eLink = EffectLinkEffects(eLink, eDur);

    int nDuration = GetCasterLevel(OBJECT_SELF)/4;
    //Enter Metamagic conditions
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ETHEREALNESS, FALSE));
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    }
}


