//::///////////////////////////////////////////////
//:: Bigby's Grasping Hand
//:: [x0_s0_bigby3]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    make an attack roll. If succesful target is held for 1 round/level


*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:

#include "x0_i0_spells"
#include "inc_bs_module"
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
    int nDuration = GetCasterLevel(OBJECT_SELF)/5;
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);

    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND) //Duration is +100%
    {
         nDuration = nDuration * 1;
    }

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 461, TRUE));

        // Check spell resistance
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            // Check caster ability vs. target's AC

            int nDiceRoll = d20(1);
            //:Xarg: Bigby's Waaayyyy off balance... + GetCasterLevel(OBJECT_SELF) + 10 + -1;
            int nCasterRoll = GetCasterAbilityModifier(OBJECT_SELF) + GetCasterLevel(OBJECT_SELF);
            int nTargetDiceRoll = d20(1);
            int nTargetRoll = GetAC(oTarget);


            string sCheck = "(" + IntToString(nTargetRoll) + IntToString(nTargetDiceRoll) + "AC vs. DC: " +
                                IntToString(nCasterRoll) + " + " + IntToString(nDiceRoll) + " = " +
                                IntToString(nCasterRoll + nDiceRoll) + ")";

            // * grapple HIT succesful,
            if ((nCasterRoll + nDiceRoll) >= nTargetRoll + nTargetDiceRoll)
            {
                SendMessageToPC(oTarget, "<c��>" + GetName(oTarget) + "</c><c.��> : AC check : *failed* : " + sCheck + "</c>");
                SendMessageToPC(OBJECT_SELF, "<c��>" + GetName(oTarget) + "</c><c.��> : AC check : *failed* : " + sCheck + "</c>");

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

                // * now must make a GRAPPLE check to
                // * hold target for duration of spell
                // * check caster ability vs. target's size & strength
                nDiceRoll = d20(1);
                nCasterRoll = GetCasterAbilityModifier(OBJECT_SELF) + 25;
                nTargetDiceRoll = d20(1);
                nTargetRoll = GetAbilityModifier(ABILITY_STRENGTH) + GetBaseAttackBonus(oTarget);

                sCheck = "(" + IntToString(nTargetRoll) + IntToString(nTargetDiceRoll) + " vs. DC: " +
                        IntToString(nCasterRoll) + " + " + IntToString(nDiceRoll) + " = " +
                        IntToString(nCasterRoll + nDiceRoll) + ")";

                if ((nCasterRoll + nDiceRoll) >= nTargetRoll + nTargetDiceRoll)
                {
                    SendMessageToPC(oTarget, "<c��>" + GetName(oTarget) + "</c><c.��> : *Target grappled* : " + sCheck + "</c>");
                    SendMessageToPC(OBJECT_SELF, "<c��>" + GetName(oTarget) + "</c><c.��> : *Target grappled* : " + sCheck + "</c>");
                        // Hold the target paralyzed
                    effect eKnockdown = EffectParalyze();

                    // creatures immune to paralzation are still prevented from moving
                    if (GetIsImmune(oTarget, IMMUNITY_TYPE_PARALYSIS) ||
                        GetIsImmune(oTarget, IMMUNITY_TYPE_MIND_SPELLS))
                    {
                        eKnockdown = EffectCutsceneImmobilize();
                    }

                    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                    effect eHand = EffectVisualEffect(VFX_DUR_BIGBYS_GRASPING_HAND);
                    effect eLink = EffectLinkEffects(eKnockdown, eDur);
                    eLink = EffectLinkEffects(eHand, eLink);
                    eLink = EffectLinkEffects(eVis, eLink);

                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                        eLink, oTarget,
                                        RoundsToSeconds(nDuration));


    //                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
    //                                        eVis, oTarget,RoundsToSeconds(nDuration));
                    FloatingTextStrRefOnCreature(2478, OBJECT_SELF);
                }
                else
                {
                    SendMessageToPC(oTarget, "<c.��>" + GetName(oTarget) + "</c><c��> : *Target evaded grapple* : " + sCheck + "</c>");
                    SendMessageToPC(OBJECT_SELF, "<c.��>" + GetName(oTarget) + "</c><c��> : *Target evaded grapple* : " + sCheck + "</c>");
                    FloatingTextStrRefOnCreature(83309, OBJECT_SELF);
                }
            }
            else
            {
                SendMessageToPC(oTarget, "<c.��>" + GetName(oTarget) + "</c><c��> : AC check : *success* : " + sCheck + "</c>");
                SendMessageToPC(OBJECT_SELF, "<c.��>" + GetName(oTarget) + "</c><c��> : AC check : *success* : " + sCheck + "</c>");
            }
        }
    }
}

