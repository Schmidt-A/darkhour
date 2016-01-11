#include "x2_i0_spells"

void SetupBoost(object oBardToken, string sBoost)
{
    int iActiveBoosts = GetLocalInt(oBardToken, "iBoosts");
    int iMaxBoosts = GetLocalInt(oBardToken, "iMaxBoosts");

    if(iActiveBoosts < iMaxBoosts)
    {
        SetLocalInt(oBardToken, sBoost, TRUE);
        SetLocalInt(oBardToken, "iBoosts", iActiveBoosts+1);
    }
}

void SetBardBoosts(object oPC, object oBardToken)
{
    if(GetHasFeat(FEAT_ARTIST, oPC) && GetLocalInt(oBardToken, "bSpeed") == FALSE)
        SetupBoost(oBardToken, "bSpeed");

    if(GetHasFeat(FEAT_SKILL_FOCUS_PERFORM, oPC) && GetLocalInt(oBardToken, "bBoth") == FALSE)
        SetupBoost(oBardToken, "bBoth");

    if(GetHasFeat(FEAT_SKILL_FOCUS_INTIMIDATE, oPC) && GetLocalInt(oBardToken, "bOffense") == FALSE)
        SetupBoost(oBardToken, "bOffense");

    if(GetHasFeat(FEAT_SKILL_FOCUS_TUMBLE, oPC) && GetLocalInt(oBardToken, "bDefense") == FALSE)
        SetupBoost(oBardToken, "bDefense");

    if(GetHasFeat(FEAT_SKILL_FOCUS_HEAL, oPC) && GetLocalInt(oBardToken, "bHeal") == FALSE)
        SetupBoost(oBardToken, "bHeal");

    if(GetHasFeat(FEAT_SKILL_FOCUS_SEARCH, oPC) && GetLocalInt(oBardToken, "bSkills") == FALSE)
        SetupBoost(oBardToken, "bSkills");

    if(GetHasFeat(FEAT_SPELL_FOCUS_NECROMANCY, oPC) && GetLocalInt(oBardToken, "bCurse") == FALSE)
        SetupBoost(oBardToken, "bCurse");

    if(GetHasFeat(FEAT_LINGERING_SONG, oPC) && GetLocalInt(oBardToken, "bLingering") == FALSE)
        SetupBoost(oBardToken, "bLingering");
}

void SetupNewBard(object oPC)
{
    object oBardToken = CreateItemOnObject("bard_boosts", oPC);
    if(GetRacialType(oPC) == RACIAL_TYPE_HUMAN)
        SetLocalInt(oBardToken, "iMaxBoosts", 2);
    else
        SetLocalInt(oBardToken, "iMaxBoosts", 1);

    // Bard boosts are restricted to those who have a base cha of 14
    if(GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE) < 14)
        SetLocalInt(oBardToken, "iMaxBoosts", 0);

    SetLocalInt(oBardToken, "iBardLevel", 1);

    SetBardBoosts(oPC, oBardToken);
}

// Make sure the bard can at LEAST cast the lowest tier bardsong before boosting.
int CanBoost(object oBardtoken, string sBoost, int nPerform)
{
    if(GetLocalInt(oBardtoken, sBoost)&& nPerform >= 3)
        return TRUE;
    return FALSE;
}

int GetHealValue(object oPC)
{
    int iBardLevels = GetLevelByClass(CLASS_TYPE_BARD, oPC);
    return d8(iBardLevels) + iBardLevels;
}

int GetHasteDuration(object oPC)
{
    return 2 + (GetAbilityModifier(ABILITY_CHARISMA, oPC) * 3);
}

void DoCurseSong(int bDecrementUses)
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
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nPerform = nRanks;
    int nDuration = 10 + (nChr * 3);

    object oBardToken = GetItemPossessedBy(OBJECT_SELF, "bard_boosts");

    effect eAttack;
    effect eDamage;
    effect eWill;
    effect eFort;
    effect eReflex;
    effect eHP;
    effect eAC;
    effect eSkill;

    int nAttack = 0;
    int nDamage = 0;
    int nWill   = 0;
    int nFort   = 0;
    int nReflex = 0;
    int nHP     = 0;
    int nAC     = 0;
    int nSkill  = 0;

    if(CanBoost(oBardToken, "bLingering", nPerform))
        nDuration += 15;

    else if(nPerform >= 15 && nLevel >= 8)
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
    if(CanBoost(oBardToken, "bCurse", nPerform))
    {
        nHP += d4(nLevel) + nLevel;
        nAC += 1;
        nDamage += 2;
    }

    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);

    eAttack = EffectAttackDecrease(nAttack);
    eDamage = EffectDamageDecrease(nDamage, DAMAGE_TYPE_SLASHING);
    effect eLink = EffectLinkEffects(eAttack, eDamage);

    if(nWill > 0)
    {
        eWill = EffectSavingThrowDecrease(SAVING_THROW_WILL, nWill);
        eLink = EffectLinkEffects(eLink, eWill);
    }
    if(nFort > 0)
    {
        eFort = EffectSavingThrowDecrease(SAVING_THROW_FORT, nFort);
        eLink = EffectLinkEffects(eLink, eFort);
    }
    if(nReflex > 0)
    {
        eReflex = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, nReflex);
        eLink = EffectLinkEffects(eLink, eReflex);
    }
    if(nHP > 0)
    {
        eHP = EffectDamage(nHP, DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL);
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
                // Bards with lingering song can re-apply their damage
                // (if they have SF:Necromancy)
                else if(CanBoost(oBardToken, "bLingering", nPerform))
                    DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHP, oTarget));
            }
            else
            {
                   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
            }
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }

    if(bDecrementUses)
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
}
