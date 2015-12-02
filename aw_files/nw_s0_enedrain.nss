//New Energy Drain
//Ranged Touch Attack or lose 2d4 Negative Levels
//By Eva01goneBerserk
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
   if (!X2PreSpellCastCode())
   {
   // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
   return;
   }
   // End of Spell Cast Hook
   //Declare major variables
   effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
   object oTarget = GetSpellTargetObject();
   //Check that the target is undead
   if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
   {
   //Figure out the amount of damage to heal
   int nHeal=d4(2)*5;
   //Set the heal effect
   effect eHeal = EffectHeal(nHeal);
   //Apply heal effect and VFX impact
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_G), oTarget);
   //Fire cast spell at event for the specified target
   SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM, FALSE));
   }
   else
   {
   int nMetaMagic = GetMetaMagicFeat();
   int nDrain = d4(2);
   int nDuration = GetCasterLevel(OBJECT_SELF);
   //Enter Metamagic conditions
   if (nMetaMagic == METAMAGIC_MAXIMIZE)
   {
   nDrain = 8;//Damage is at max
   }
   else if (nMetaMagic == METAMAGIC_EMPOWER)
   {
   nDrain = nDrain + (nDrain/2); //Damage/Healing is +50%
   }
   effect eDrain = EffectNegativeLevel(nDrain);
   eDrain = SupernaturalEffect(eDrain);
   if(!GetIsReactionTypeFriendly(oTarget))
   {
   //Fire cast spell at event for the specified target
   SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_DRAIN));
   if(!MyResistSpell(OBJECT_SELF, oTarget))
   {
   int nResult = TouchAttackRanged(oTarget, TRUE);
   if (nResult > 0)
   {
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrain, oTarget, RoundsToSeconds(nDuration/3));
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
   }
   }
   }
   }
   }
