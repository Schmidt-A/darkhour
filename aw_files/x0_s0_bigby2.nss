//::///////////////////////////////////////////////
//:: Bigby's Forceful Hand
//:: [x0_s0_bigby2]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    dazed vs strength check (+14 on strength check); Target knocked down.
    Target dazed down for 1 round per level of caster

*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 01, 2003

#include "x0_i0_spells"
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


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF)/5;
    int nMetaMagic = GetMetaMagicFeat();
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND) //Duration is +100%
    {
         nDuration = nDuration * 1;
    }
        if(!GetIsReactionTypeFriendly(oTarget))
          {
            // Apply the impact effect
            effect eImpact = EffectVisualEffect(VFX_IMP_BIGBYS_FORCEFUL_HAND);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 460, TRUE));
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
            //:Xarg: Load the int for the Reflex Save
             int iSave = ReflexSave(oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_SPELL, OBJECT_SELF);
             if(iSave == 0) //:Xarg: Added the Reflex Save to Bull Rush
             {
                int nCasterDiceRoll = d20(1);
                //int nCasterRoll = d20(1) + 17;
                int nTargetDiceRoll = d20(1);
                int nTargetRoll = GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetSizeModifier(oTarget);
                // * bullrush succesful, knockdown target for duration of spell
                string sCheck = "(" + IntToString(nTargetRoll) + " + " + IntToString(nTargetDiceRoll) + " = " + IntToString(nTargetRoll + nTargetDiceRoll) +
                                " vs. DC: 17 + " + IntToString(nCasterDiceRoll) + " = " + IntToString(17 + nCasterDiceRoll) + ")";

                if ((17 + nCasterDiceRoll) >= (nTargetRoll + nTargetDiceRoll))
                {
                    SendMessageToPC(oTarget, "<cýý>" + GetName(oTarget) + "</c><c.ÍÙ> : *Target grappled* : " + sCheck + "</c>");
                    SendMessageToPC(OBJECT_SELF, "<cýý>" + GetName(oTarget) + "</c><c.ÍÙ> : *Target grappled* : " + sCheck + "</c>");

                    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                    effect eKnockdown = EffectDazed();
                    effect eKnockdown2 = EffectKnockdown();
                    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                    //Link effects
                    effect eLink = EffectLinkEffects(eKnockdown, eDur);
                    eLink = EffectLinkEffects(eLink, eKnockdown2);
                    //Apply the penalty
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(nDuration));
                    // * Bull Rush succesful
    ////////////////////////////////////////////////
                   int nPCTeam = GetLocalInt(oTarget, "nTeam");
                   int nEnemyTeam = 3 - nPCTeam;
                   string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
                   if (GetLocalObject(GetModule(), szEnemyHasFlag) == oTarget)
                   {
                       DropFlag(oTarget);
                       RemoveFlagEffect(oTarget);
                   }


    //////////////////////////////////
                   FloatingTextStrRefOnCreature(8966,OBJECT_SELF, FALSE);
                }
                else
                {
                    SendMessageToPC(oTarget, "<cýý>" + GetName(oTarget) + "</c><c.ÍÙ> : *Target evaded grapple* : " + sCheck + "</c>");
                    SendMessageToPC(OBJECT_SELF, "<cýý>" + GetName(oTarget) + "</c><c.ÍÙ> : *Target evaded grapple* : " + sCheck + "</c>");
                    FloatingTextStrRefOnCreature(8967,OBJECT_SELF, FALSE);
                }
            } //:Xarg: Reflex Save End
        }
    }
}


