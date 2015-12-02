//::///////////////////////////////////////////////
//:: Curse Song
//:: X2_S2_CurseSong
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//Sept 08: Scaled back song effects due to bards being overpowered. (Moff)

#include "x2_i0_spells"

void main()
{

   if (!GetHasFeat(FEAT_BARD_SONGS, OBJECT_SELF))
   {
        FloatingTextStrRefOnCreature(85587,OBJECT_SELF); // no more bardsong uses left
        return;
   }

    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }


    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_BARD);
    int nRanks = GetSkillRank(SKILL_PERFORM);
    int nPerform = nRanks;
    int nDuration = 10; //+ nChr;

    effect eAttack;
    effect eDamage;
    effect eSaves;
    effect eHP;
    effect eAC;
    effect eSkill;

    int nAttack;
    int nDamage;
    int nSaves;
    int nHP;
    int nAC;
    int nSkill;
    //Check to see if the caster has Lasting Impression and increase duration.
    if(GetHasFeat(870))
    {
        nDuration *= 10;
    }

    if(GetHasFeat(424)) // lingering song
    {
        nDuration += 5;
    }

    if(nPerform >= 100 && nLevel >= 40)
    {
        nAC = 3;
        nAttack = 3;
        nDamage = 3;
        nSaves = 3;
        nHP = 40;
        nSkill = 10;
    }
    else if(nPerform >= 90 && nLevel >= 38)
    {
        nAC = 2;
        nAttack = 3;
        nDamage = 3;
        nSaves = 3;
        nHP = 35;
        nSkill = 9;
    }
    else if(nPerform >= 80 && nLevel >= 36)
    {
        nAC = 2;
        nAttack = 3;
        nDamage = 3;
        nSaves = 2;
        nHP = 30;
        nSkill = 8;
    }
    else if(nPerform >= 72 && nLevel >= 33)
    {
        nAC = 2;
        nAttack = 2;
        nDamage = 3;
        nSaves = 2;
        nHP = 30;
        nSkill = 7;
    }
    else if(nPerform >= 64 && nLevel >= 30)
    {
        nAC = 2;
        nAttack = 2;
        nDamage = 2;
        nSaves = 2;
        nHP = 30;
        nSkill = 6;
    }
    else if(nPerform >= 56 && nLevel >= 27)
    {
        nAC = 1;
        nAttack = 2;
        nDamage = 2;
        nSaves = 2;
        nHP = 20;
        nSkill = 5;
    }
    else if(nPerform >= 44 && nLevel >= 24)
    {
        nAC = 1;
        nAttack = 2;
        nDamage = 2;
        nSaves = 2;
        nHP = 15;
        nSkill = 4;
    }
    else if(nPerform >= 38 && nLevel >= 21)
    {
        nAC = 1;
        nAttack = 2;
        nDamage = 2;
        nSaves = 1;
        nHP = 15;
        nSkill = 4;
    }
    else if(nPerform >= 32 && nLevel >= 18)
    {
        nAC = 1;
        nAttack = 1;
        nDamage = 2;
        nSaves = 1;
        nHP = 10;
        nSkill = 3;
    }
    else if(nPerform >= 26 && nLevel >= 15)
    {
        nAC = 1;
        nAttack = 1;
        nDamage = 1;
        nSaves = 1;
        nHP = 10;
        nSkill = 2;
    }
    else if(nPerform >= 18 && nLevel >= 10)
    {
        nAC = 0;
        nAttack = 1;
        nDamage = 1;
        nSaves = 1;
        nHP = 5;
        nSkill = 1;
    }
    else if(nPerform >= 8 && nLevel >= 5)
    {
        nAC = 0;
        nAttack = 1;
        nDamage = 1;
        nSaves = 0;
        nHP = 5;
        nSkill = 1;
    }
    else if(nPerform >= 4 && nLevel >= 1)
    {
        nAC = 0;
        nAttack = 1;
        nDamage = 0;
        nSaves = 0;
        nHP = 0;
        nSkill = 0;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);

    eAttack = EffectAttackDecrease(nAttack);
    eDamage = EffectDamageDecrease(nDamage, DAMAGE_TYPE_SLASHING);
    effect eLink = EffectLinkEffects(eAttack, eDamage);

    if(nSaves > 0)
    {
        eSaves = EffectSavingThrowDecrease(SAVING_THROW_ALL, nSaves);
        eLink = EffectLinkEffects(eLink, eSaves);
    }
    if(nHP > 0)
    {
        //SpeakString("HP Bonus " + IntToString(nHP));
        eHP = EffectDamage(nHP, DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL);
//        eLink = EffectLinkEffects(eLink, eHP);
    }
    if(nAC > 0)
    {
        eAC = EffectACDecrease(nAC, AC_DODGE_BONUS);
        eLink = EffectLinkEffects(eLink, eAC);
    }
    if(nSkill > 0)
    {
        eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nSkill);
        eLink = EffectLinkEffects(eLink, eSkill);
    }
    effect eDur  = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(507);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

    eHP = ExtraordinaryEffect(eHP);
    eLink = ExtraordinaryEffect(eLink);

    if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur2, OBJECT_SELF, RoundsToSeconds(nDuration));
    }
    float fDelay;
    while(GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
             // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
            if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
            {
                if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
                {
                    if (nHP > 0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SONIC), oTarget);
                        DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHP, oTarget));
                    }

                    if (!GetIsDead(oTarget))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                        DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                   }
                }
            }
            else
            {
                   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
            }
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
}
