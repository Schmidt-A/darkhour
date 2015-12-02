//::///////////////////////////////////////////////
//:: Bard Song
//:: NW_S2_BardSong
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//Sept 08: Scaled back song effects due to bards being overpowered. (Moff)
#include "x0_i0_spells"

void main()
{
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }
    string sTag = GetTag(OBJECT_SELF);

    if (sTag == "x0_hen_dee" || sTag == "x2_hen_deekin")
    {
        // * Deekin has a chance of singing a doom song
        // * same effect, better tune
        if (Random(100) + 1 > 80)
        {
            // the Xp2 Deekin knows more than one doom song
            if (d3() ==1 && sTag == "x2_hen_deekin")
            {
                DelayCommand(0.0, PlaySound("vs_nx2deekM_050"));
            }
            else
            {
                DelayCommand(0.0, PlaySound("vs_nx0deekM_074"));
                DelayCommand(5.0, PlaySound("vs_nx0deekM_074"));
            }
        }
    }


    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_BARD);
    int nRanks = GetSkillRank(SKILL_PERFORM);
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
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

    // lingering song
    if(GetHasFeat(424)) // lingering song
    {
        nDuration += 5;
    }

    //SpeakString("Level: " + IntToString(nLevel) + " Ranks: " + IntToString(nRanks));

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

    effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

    eAttack = EffectAttackIncrease(nAttack);
    eDamage = EffectDamageIncrease(nDamage, DAMAGE_TYPE_BLUDGEONING);
    effect eLink = EffectLinkEffects(eAttack, eDamage);

    if(nSaves > 0)
    {
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
        eLink = EffectLinkEffects(eLink, eSaves);
    }
    if(nHP > 0)
    {
        //SpeakString("HP Bonus " + IntToString(nHP));
        eHP = EffectTemporaryHitpoints(nHP);
//        eLink = EffectLinkEffects(eLink, eHP);
    }
    if(nAC > 0)
    {
        eAC = EffectACIncrease(nAC, AC_DODGE_BONUS);
        eLink = EffectLinkEffects(eLink, eAC);
    }
    if(nSkill > 0)
    {
        eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nSkill);
        eLink = EffectLinkEffects(eLink, eSkill);
    }
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

    eHP = ExtraordinaryEffect(eHP);
    eLink = ExtraordinaryEffect(eLink);

    while(GetIsObjectValid(oTarget))
    {
        if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
        {
             // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
             if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
             {
                if(oTarget == OBJECT_SELF)
                {
                    effect eLinkBard = EffectLinkEffects(eLink, eVis);
                    eLinkBard = ExtraordinaryEffect(eLinkBard);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinkBard, oTarget, RoundsToSeconds(nDuration));
                    if (nHP > 0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
                    }
                }
                else if(GetIsFriend(oTarget))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    if (nHP > 0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
                    }
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

