//::///////////////////////////////////////////////
//:: Bigby's Crushing Hand
//:: [x0_s0_bigby5]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Similar to Bigby's Grasping Hand.
    If Grapple succesful then will hold the opponent and do 2d6 + 12 points
    of damage EACH round for 1 round/level


   // Mark B's famous advice:
   // Note:  if the target is dead during one of these second-long heartbeats,
   // the DelayCommand doesn't get run again, and the whole package goes away.
   // Do NOT attempt to put more than two parameters on the delay command.  They
   // may all end up on the stack, and that's all bad.  60 x 2 = 120.

*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:

#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "x2_i0_spells"

int nSpellID = 463;
void RunHandImpact(object oTarget, object oCaster)
{

    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(nSpellID,oTarget,oCaster))
    {
        return;
    }

    int nDam = MaximizeOrEmpower(6,4,GetMetaMagicFeat(), 24);
    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_BLUDGEONING);
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    DelayCommand(6.0f,RunHandImpact(oTarget,oCaster));
}

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

    object oTarget = GetSpellTargetObject();

    //--------------------------------------------------------------------------
    // This spell no longer stacks. If there is one hand, that's enough
    //--------------------------------------------------------------------------
    if (GetHasSpellEffect(nSpellID,oTarget) ||  GetHasSpellEffect(462,oTarget)  )
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }

    int nDuration = GetCasterLevel(OBJECT_SELF)/5;
    int nMetaMagic = GetMetaMagicFeat();

    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND) //Duration is +100%
    {
         nDuration = nDuration * 2;
    }

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BIGBYS_CRUSHING_HAND, TRUE));

        //SR
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            int nDiceRoll = d20(1);
            int nCasterRoll = GetCasterAbilityModifier(OBJECT_SELF) + GetCasterLevel(OBJECT_SELF);
            int nTargetRoll = GetAC(oTarget) + d20(1); // :Xarg: Same as previous bugby, d20 added.

            string sCheck = "(" + IntToString(nTargetRoll) + "AC vs. DC: 8 + " +
                                IntToString(nCasterRoll) + " + " + IntToString(nDiceRoll) + " = " +
                                IntToString(11 + nCasterRoll + nDiceRoll) + ")";
            // * grapple HIT succesful,
            if ((8 + nCasterRoll + nDiceRoll) >= nTargetRoll)  // :Xarg: More like DC+8 than +11
            {
                SendMessageToPC(oTarget, "<c.ÍÙ>" +GetName(oTarget) + "</c><cýý> : AC check : *failed* : " + sCheck + "</c>");
                SendMessageToPC(OBJECT_SELF, "<c.ÍÙ>" +GetName(oTarget) + "</c><cýý> : AC check : *failed* : " + sCheck + "</c>");
                // * now must make a GRAPPLE check
                // * hold target for duration of spell

                int nCasterDiceRoll = d20(1);
                nCasterRoll = GetCasterAbilityModifier(OBJECT_SELF)
                    + 19;

                int nTargetDiceRoll = d20(1);
                nTargetRoll = GetBaseAttackBonus(oTarget)
                             + GetSizeModifier(oTarget)
                             + GetAbilityModifier(ABILITY_STRENGTH, oTarget);

                string sCheck = "(" + IntToString(nTargetRoll) + " + " + IntToString(nTargetDiceRoll) + " = " + IntToString(nTargetRoll + nTargetDiceRoll) +
                                " vs. DC: 8 + " + IntToString(nCasterRoll) + " + " + IntToString(nCasterDiceRoll) + " = " + IntToString(8 + nCasterRoll + nCasterDiceRoll) + ")";
                                  // :Xarg: DC+8, not +14
                if ((8 + nCasterRoll + nCasterDiceRoll) >= (nTargetRoll + nTargetDiceRoll))
                {
                    SendMessageToPC(oTarget, "<c.ÍÙ>" +GetName(oTarget) + "</c><cýý> : *Target grappled* : " + sCheck + "</c>");
                    SendMessageToPC(OBJECT_SELF, "<c.ÍÙ>" +GetName(oTarget) + "</c><cýý> : *Target grappled* : " + sCheck + "</c>");

                    effect eKnockdown = EffectParalyze();

                    // creatures immune to paralzation are still prevented from moving
                    if (GetIsImmune(oTarget, IMMUNITY_TYPE_PARALYSIS) ||
                        GetIsImmune(oTarget, IMMUNITY_TYPE_MIND_SPELLS))
                    {
                        eKnockdown = EffectCutsceneImmobilize();
                    }

                    effect eHand = EffectVisualEffect(VFX_DUR_BIGBYS_CRUSHING_HAND);
                    effect eLink = EffectLinkEffects(eKnockdown, eHand);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                        eLink, oTarget,
                                        RoundsToSeconds(nDuration));

                    object oSelf = OBJECT_SELF;
                    RunHandImpact(oTarget, oSelf);
                    FloatingTextStrRefOnCreature(2478, OBJECT_SELF);

                }
                else
                {
                    SendMessageToPC(oTarget, "<c.ÍÙ>" +GetName(oTarget) + "</c><cýý> : *Target evaded grapple* : " + sCheck + "</c>");
                    SendMessageToPC(OBJECT_SELF, "<c.ÍÙ>" +GetName(oTarget) + "</c><cýý> : *Target evaded grapple* : " + sCheck + "</c>");
                    FloatingTextStrRefOnCreature(83309, OBJECT_SELF);
                }
            }
            else
            {
                SendMessageToPC(oTarget, "<c.ÍÙ>" +GetName(oTarget) + "</c><cýý> : AC check : *success* : " + sCheck + "</c>");
                SendMessageToPC(OBJECT_SELF, "<c.ÍÙ>" +GetName(oTarget) + "</c><cýý> : AC check : *success* : " + sCheck + "</c>");
            }
        }
    }
}


