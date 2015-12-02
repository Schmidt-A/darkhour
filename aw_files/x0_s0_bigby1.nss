//::///////////////////////////////////////////////
//:: Bigby's Interposing Hand
//:: [x0_s0_bigby1]
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Grants -10 to hit to target for 1 round / level
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:
#include "nw_i0_spells"

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


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel/4;
    int nMetaMagic = GetMetaMagicFeat();
    int nPenalty = nCasterLevel/5;
    if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
    {
        nPenalty = nPenalty + 2;
    }



    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF,
                                              SPELL_BIGBYS_INTERPOSING_HAND,
                                              TRUE));
        //Check for metamagic extend
        if (nMetaMagic == METAMAGIC_EXTEND) //Duration is +100%
        {
             nDuration = nDuration * 2;
        }
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
        //:Jantima: [Helfest] Load the int for the Will Save
        int iSave = WillSave(oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_SPELL, OBJECT_SELF);
        if(iSave == 0) //:Xarg: Added the Reflex Save to Bull Rush
        {
        effect eAC1 = EffectAttackDecrease(10, AC_DODGE_BONUS);
        effect eVis = EffectVisualEffect(VFX_DUR_BIGBYS_INTERPOSING_HAND);
        effect eLink = EffectLinkEffects(eAC1, eVis);


        //Apply the TO HIT PENALTIES bonuses and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            eLink,
                            oTarget,
                            RoundsToSeconds(nDuration));
        }
        }
    }
}

