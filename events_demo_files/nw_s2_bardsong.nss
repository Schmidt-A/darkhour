//::///////////////////////////////////////////////
//:: Bard Song
//:: NW_S2_BardSong
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spells applies bonuses to all of the
    bard's allies within 30ft for a set duration of
    10 rounds.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 25, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller Oct 1, 2003
/*
bugfix by Kovi 2002.07.30
- loosing temporary hp resulted in loosing the other bonuses

Updated Dec 2015 for Dark Hour by Tweek.
- removed <= level 8 options;
- duration increased;
- buffs dependent on feat selections.
*/

#include "x0_i0_spells"
#include "_cls_bard"

void UnlinkedSongEffects(object oTarget, int nDuration, int nHP, int nHeal, int bCanHaste)
{
    if (nHP > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectTemporaryHitpoints(nHP), oTarget,
                            RoundsToSeconds(nDuration));
    }
    if(nHeal > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectHeal(nHeal), oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_IMP_HEALING_S), oTarget);
    }
    if(bCanHaste)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedIncrease(50),
            oTarget, RoundsToSeconds(GetHasteDuration(OBJECT_SELF)));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_IMP_HASTE), oTarget);
    }
}

void main()
{
    // Can't use this when silenced.
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF);
        return;
    }

    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_BARD);
    int nRanks = GetSkillRank(SKILL_PERFORM);
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nPerform = nRanks;
    int nDuration = 10 + (nChr * 3);

    object oBardToken = GetItemPossessedBy(OBJECT_SELF, "bard_boosts");

    effect eAttack;
    effect eDamage;

    int nAttack = 0;
    int nDamage = 0;
    int nWill   = 0;
    int nFort   = 0;
    int nReflex = 0;
    int nHP     = 0;
    int nAC     = 0;
    int nSkill  = 0;
    int nHeal   = 0;

    // This is ugly - maybe refactor to DB later.
    if(nPerform >= 15 && nLevel >= 8)
    {
        nAttack = 2;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 8;
        nSkill = 1;
    }
    else if(nPerform >= 12 && nLevel >= 6)
    {
        nAttack = 1;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nSkill = 1;
    }
    else if(nPerform >= 9 && nLevel >= 3)
    {
        nAttack = 1;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
    }
    else if(nPerform >= 6 && nLevel >= 2)
    {
        nAttack = 1;
        nDamage = 1;
        nWill = 1;
    }
    else if(nPerform >= 3 && nLevel >= 1)
    {
        nAttack = 1;
        nDamage = 1;
    }

    if(CanBoost(oBardToken, "bOffense", nPerform))
    {
        nAttack += 2;
        nDamage += 2;
    }
    if(CanBoost(oBardToken, "bDefense", nPerform))
    {
        nAC += 2;
        nFort += 2;
        nWill += 2;
        nReflex += 2;
    }
    if(CanBoost(oBardToken, "bHeal", nPerform))
        nHeal = GetHealValue(OBJECT_SELF);
    if(CanBoost(oBardToken, "bSkills", nPerform))
        nSkill += 5;

    effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

    eAttack = EffectAttackIncrease(nAttack);
    eDamage = EffectDamageIncrease(nDamage, DAMAGE_TYPE_BLUDGEONING);
    effect eLink = EffectLinkEffects(eAttack, eDamage);

    if(nWill > 0)
    {
        effect eWill = EffectSavingThrowIncrease(SAVING_THROW_WILL, nWill);
        eLink = EffectLinkEffects(eLink, eWill);
    }
    if(nFort > 0)
    {
        effect eFort = EffectSavingThrowIncrease(SAVING_THROW_FORT, nFort);
        eLink = EffectLinkEffects(eLink, eFort);
    }
    if(nReflex > 0)
    {
        effect eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nReflex);
        eLink = EffectLinkEffects(eLink, eReflex);
    }
    if(nAC > 0)
    {
        effect eAC = EffectACIncrease(nAC, AC_DODGE_BONUS);
        eLink = EffectLinkEffects(eLink, eAC);
    }
    if(nSkill > 0)
    {
        effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nSkill);
        eLink = EffectLinkEffects(eLink, eSkill);
    }

    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL,
                                           GetLocation(OBJECT_SELF));

    effect eHP = ExtraordinaryEffect(eHP);
    eLink = ExtraordinaryEffect(eLink);

    while(GetIsObjectValid(oTarget))
    {
        if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) &&
           !GetHasSpellEffect(GetSpellId(),oTarget))
        {
            // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
            if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) &&
                !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
            {
                if(oTarget == OBJECT_SELF)
                {
                    effect eLinkBard = EffectLinkEffects(eLink, eVis);
                    eLinkBard = ExtraordinaryEffect(eLinkBard);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinkBard,
                                        oTarget, RoundsToSeconds(nDuration));
                    UnlinkedSongEffects(oTarget, nDuration, nHP, nHeal,
                                        CanBoost(oBardToken, "bSpeed", nPerform));
                }
                else if(!GetIsEnemy(oTarget))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,
                                        RoundsToSeconds(nDuration));
                    UnlinkedSongEffects(oTarget, nDuration, nHP, nHeal,
                                        CanBoost(oBardToken, "bSpeed", nPerform));
                }
            }
        }
        // Bards with lingering song can re-apply their healing
        // (if they have SF:Heal)
        else if(CanBoost(oBardToken, "bLingering", nPerform))
            UnlinkedSongEffects(oTarget, 0, 0, nHeal, FALSE);

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL,
                                       GetLocation(OBJECT_SELF));
    }
    if(CanBoost(oBardToken, "bBoth", nPerform))
        DoCurseSong(FALSE);
}

