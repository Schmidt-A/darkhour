//::///////////////////////////////////////////////
//:: Heal
//:: [NW_S0_Heal.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Heals the target to full unless they are undead.
//:: If undead they reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: Aug 1, 2001

#include "NW_I0_SPELLS"
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
  effect eKill, eHeal;
  int nDamage, nHeal, nModify, nMetaMagic, nTouch;
  effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);


   /// ANTIWORLD HEAL FROM ITEMS =  NUMBER RESTRICTION ////
  if (GetIsObjectValid(GetSpellCastItem()) && OBJECT_SELF == oTarget) // spell cast from item?
    {
          int nHealByRings = GetLocalInt(OBJECT_SELF,"nHeal");
          if( nHealByRings >= 3)
            {
            FloatingTextStringOnCreature("<c.͎>You cannot Heal Self by an item more than this!</c>",OBJECT_SELF,FALSE);
            return;
            }
           if( nHealByRings == 2)
            {
            FloatingTextStringOnCreature("<c.͎>Last use of this spell on Self and from an item!</c>",OBJECT_SELF,FALSE);
            }
    SetLocalInt(OBJECT_SELF,"nHeal",GetLocalInt(OBJECT_SELF,"nHeal")+1);
    }


    //Check to see if the target is an undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));
            //Make a touch attack
            if (TouchAttackMelee(oTarget))
            {
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    //Roll damage
                    nModify = d4();
                    nMetaMagic = GetMetaMagicFeat();
                    //Make metamagic check
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nModify = 1;
                    }
                    //Figure out the amount of damage to inflict
                    nDamage =  GetCurrentHitPoints(oTarget)/2 - nModify;
                    //Set damage
                    eKill = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, oTarget);
                }
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));
        if (OBJECT_SELF == oTarget)  /// antiworld heal self /2
          {
          //Figure out how much to heal
          nHeal = GetMaxHitPoints(oTarget)/2;
          //Set the heal effect
          if (nHeal > 200) nHeal = 200;
          eHeal = EffectHeal(nHeal);
          //Apply the heal effect and the VFX impact
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
          }
        else
          {
          //Figure out how much to heal
          nHeal = GetMaxHitPoints(oTarget);
          //Set the heal effect
          if (nHeal > 400) nHeal = 400;
          eHeal = EffectHeal(nHeal);
          //Apply the heal effect and the VFX impact
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        }
    }

}
