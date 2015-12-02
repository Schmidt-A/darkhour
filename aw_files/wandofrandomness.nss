#include "inc_bs_module"
void main()
{
    int nRand = d6();
    object oPC = GetItemActivatedTarget();
    object oActivator = GetItemActivator();


    BroadcastMessage("<cëLÊ>"+GetName(oActivator)+" used the Wand of Randomness!</c>");

    if (oPC != oActivator)
    {
        FloatingTextStringOnCreature(GetName(oActivator) + " used the Wand of Randomness on you",oPC, FALSE);
    }

    if (GetIsPC(oPC))
    {
            float nDuration = IntToFloat(d100() * 2);

            if (nRand == 1)  //apply d8 bonus to all stats
            {
                effect e1 = EffectAbilityIncrease(ABILITY_STRENGTH,d8());
                effect e2 = EffectAbilityIncrease(ABILITY_DEXTERITY,d8());
                effect e3 = EffectAbilityIncrease(ABILITY_CONSTITUTION,d8());
                effect e4 = EffectAbilityIncrease(ABILITY_WISDOM,d8());
                effect e5 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,d8());
                effect e6 = EffectAbilityIncrease(ABILITY_CHARISMA,d8());

                effect eLink = EffectLinkEffects(e1,e2);
                eLink = EffectLinkEffects(eLink,e3);
                eLink = EffectLinkEffects(eLink,e4);
                eLink = EffectLinkEffects(eLink,e5);
                eLink = EffectLinkEffects(eLink,e6);


                effect eVisual = EffectVisualEffect(VFX_BEAM_SILENT_HOLY);

                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,nDuration);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oPC);
            }
            else if (nRand == 2) //apply random polymorph
            {
                 int nPolyRand = d6();
                 int nPoly = 0;

                 if (nPolyRand == 1)
                 {
                    nPoly = POLYMORPH_TYPE_CHICKEN;
                 }
                 else if (nPolyRand == 2)
                 {
                    nPoly = POLYMORPH_TYPE_COW;
                 }
                 else if (nPolyRand == 3)
                 {
                    nPoly = POLYMORPH_TYPE_RED_DRAGON;
                 }
                 else if (nPolyRand == 4)
                 {
                    nPoly = POLYMORPH_TYPE_IRON_GOLEM;
                 }
                 else if (nPolyRand == 5)
                 {
                    nPoly = POLYMORPH_TYPE_DIRE_BADGER;
                 }
                 else if (nPolyRand == 6)
                 {
                    nPoly = POLYMORPH_TYPE_ANCIENT_BLUE_DRAGON;
                 }

                 effect ePoly = EffectPolymorph(nPoly);
                 effect eVisual =  EffectVisualEffect(VFX_DUR_ICESKIN);

                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePoly,oPC,nDuration);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oPC);
            }
            else if (nRand == 3)
            {
                 effect e1 = EffectAbilityDecrease(ABILITY_STRENGTH,d6());
                 effect e2 = EffectAbilityDecrease(ABILITY_DEXTERITY,d6());
                 effect e3 = EffectAbilityDecrease(ABILITY_CONSTITUTION,d6());
                 effect e4 = EffectAbilityDecrease(ABILITY_WISDOM,d6());
                 effect e5 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,d6());
                 effect e6 = EffectAbilityDecrease(ABILITY_CHARISMA,d6());

                 effect eLink = EffectLinkEffects(e1,e2);
                 eLink = EffectLinkEffects(eLink,e3);
                 eLink = EffectLinkEffects(eLink,e4);
                 eLink = EffectLinkEffects(eLink,e5);
                 eLink = EffectLinkEffects(eLink,e6);


                 effect eVisual = EffectVisualEffect(VFX_BEAM_BLACK);

                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,nDuration);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oPC);
            }
            else if (nRand == 4)
            {
                 effect eDamageReduction = EffectDamageReduction(15,DAMAGE_POWER_PLUS_SIX,d100()*3);
                 effect eShield = EffectDamageShield(d20(2),DAMAGE_BONUS_2d12,DAMAGE_TYPE_POSITIVE);

                 effect eLink = EffectLinkEffects(eDamageReduction,eShield);
                 effect eVisual = EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE);
                 eLink = EffectLinkEffects(eLink,eVisual);

                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,nDuration);
            }
            else if (nRand == 5)
            {
                  effect eDeath = EffectDeath(TRUE);
                  effect eVisual =  EffectVisualEffect(VFX_IMP_RAISE_DEAD);
                  int nTarget = Random(3);
                  object oTarget;
                  if (nTarget == 1)
                  {
                       oTarget = oPC;
                  }
                  else oTarget = oActivator;
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDeath,oTarget,nDuration);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oTarget);
            }
            else if (nRand == 6)
            {
                  effect e1 = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
                  effect e2 = EffectEthereal();
                  effect e3 = EffectMovementSpeedIncrease(99);
                  effect e4 = EffectRegenerate(5,3.0);
                  effect e5 = EffectSpellResistanceIncrease(d100());

                  effect eLink = EffectLinkEffects(e1,e2);
                  eLink =EffectLinkEffects(eLink,e3);
                  eLink =EffectLinkEffects(eLink,e4);
                  eLink =EffectLinkEffects(eLink,e5);

                  effect eVisual = EffectVisualEffect(VFX_BEAM_ODD);

                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,nDuration);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oPC);
            }

    }

}
