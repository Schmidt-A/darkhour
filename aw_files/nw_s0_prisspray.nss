//New Primsatic Spray
//Added ST vs Fort or be petrified to random case
//By Eva01goneBerserk

int ApplyPrismaticEffect(int nEffect, object oTarget);
int GetEffectStatus(int nEffect);

#include "X0_I0_SPELLS"
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
    object oTarget;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nRandom,nRE;
    int nHD;
    int nVisual;
    effect eVisual;
    int bTwoEffects;
    int nLoop;
    int nEffect;
    //Set the delay to apply to effects based on the distance to the target
    //Get first target in the spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 11.0, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PRISMATIC_SPRAY));
            //Make an SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
            {
                //Blind the target if they are less than 9 HD
                nHD = GetHitDice(oTarget);
                if (nHD <= 8)
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oTarget, RoundsToSeconds(nCasterLevel));
                }
                nLoop=1;
                nEffect=0;
                while(nLoop>0 && nEffect<127)
                {
                    //Determine if 1 or 2 effects are going to be applied
                    nRandom = d8();
                    nRE=GetEffectStatus(nRandom);
                    if(nRandom == 8)
                    {
                        nLoop++;
                        //Get the visual effect
//                        nVisual = ApplyPrismaticEffect(Random(7) + 1, oTarget);
//                        nVisual = ApplyPrismaticEffect(Random(7) + 1, oTarget);
                    }
                    else if(!(nRE & nEffect))
                    {
                        //Get the visual effect
                        nVisual = ApplyPrismaticEffect(nRandom, oTarget);
                        nLoop--;
                        nEffect=nEffect | nRE;
                    }
                }
                //Set the visual effect
                if(nVisual != 0)
                {
                    eVisual = EffectVisualEffect(nVisual);
                    //Apply the visual effect
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget));
                }
            }
        }
        //Get next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, GetSpellTargetLocation());
    }
}

///////////////////////////////////////////////////////////////////////////////
//  ApplyPrismaticEffect
///////////////////////////////////////////////////////////////////////////////
/*  Given a reference integer and a target, this function will apply the effect
    of corresponding prismatic cone to the target.  To have any effect the
    reference integer (nEffect) must be from 1 to 7.*/
///////////////////////////////////////////////////////////////////////////////
//  Created By: Aidan Scanlan On: April 11, 2001
///////////////////////////////////////////////////////////////////////////////

int ApplyPrismaticEffect(int nEffect, object oTarget)
{
    int nDamage;
    effect ePrism;
    effect eVis;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink;
    int nVis;
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
    //Based on the random number passed in, apply the appropriate effect and set the visual to
    //the correct constant
    switch(nEffect)
    {
        case 1://fire
            nDamage = 20;
            nVis = VFX_IMP_FLAME_S;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_FIRE);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 2: //Acid
            nDamage = 40;
            nVis = VFX_IMP_ACID_L;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_ACID);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 3: //Electricity
            nDamage = 80;
            nVis = VFX_IMP_LIGHTNING_S;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_ELECTRICITY);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 4: //Poison
            {
                if (!GetIsImmune(oTarget,IMMUNITY_TYPE_POISON) && !MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_POISON))
                {
                    if(!GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH))
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget));
                    }
                    else
                    {
                        ePrism=EffectAbilityDecrease(ABILITY_CONSTITUTION,d6());
                        eLink=EffectVisualEffect(VFX_IMP_POISON_L);
                        eLink=EffectLinkEffects(eLink,ePrism);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget));
                    }
                }
            }
        break;
        case 5: //Petrify

            {
                 if (!/*Fort Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                DelayCommand(fDelay,DoPetrification(GetCasterLevel(OBJECT_SELF),OBJECT_SELF,oTarget,GetSpellId(),GetSpellSaveDC()));
            }
        break;
        case 6: //Confusion
            {
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                {
                    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                    ePrism = EffectConfused();
                    eLink = EffectLinkEffects(eMind, ePrism);
                    eLink = EffectLinkEffects(eLink, eDur);
                    nVis = VFX_IMP_CONFUSION_S;
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(10)));
                }
            }
        break;
        case 7: //Death
            {
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, SupernaturalEffect(EffectDeath()), oTarget));
                }
            }
        break;
    }
    return nVis;
}

int GetEffectStatus(int nEffect)
{
    int nValue;
    switch(nEffect)
    {
        case 1:
            nValue=1;
            break;
        case 2:
            nValue=2;
            break;
        case 3:
            nValue=4;
            break;
        case 4:
            nValue=8;
            break;
        case 5:
            nValue=16;
            break;
        case 6:
            nValue=32;
            break;
        case 7:
            nValue=64;
            break;
    }
    return nValue;
}
