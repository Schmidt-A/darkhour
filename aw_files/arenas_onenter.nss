#include "aw_include"
void main()
{
    object oPC = GetEnteringObject();
    effect eEthereal =EffectEthereal();
    effect eSpellImmunity = EffectSpellImmunity(SPELL_ALL_SPELLS);
    effect eMindImmunity = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);

    if(GetIsPC(oPC))
        {
        effect eLink = EffectLinkEffects(eEthereal, eSpellImmunity);
        eLink = ExtraordinaryEffect(EffectLinkEffects(eLink, eMindImmunity));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 7.0f);
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 6.0f));
        ExploreAreaForPlayer(OBJECT_SELF, oPC);
        DelayCommand(2.0f,FloatingTextStringOnCreature("You are invisible and immune for 7 seconds to move away from the spawn",oPC,FALSE));
        }
    int nLevel = GetHitDice(oPC);
    effect eAB;
    effect eDisc;
    int nAmount;


    if (nLevel >= 26)
    {
        nAmount = 0;
    }
    else if (nLevel >= 24)
    {
        nAmount = 1;
        DelayCommand(3.0, FloatingTextStringOnCreature("Low-level attack bonus: +1", oPC));
    }
    else if (nLevel >= 22)
    {
        nAmount = 2;
        DelayCommand(3.0, FloatingTextStringOnCreature("Low-level attack bonus: +2", oPC));
    }
    else if (nLevel >= 20)
    {
        nAmount = 3;
        DelayCommand(3.0, FloatingTextStringOnCreature("Low-level attack bonus: +3", oPC));
    }
    else if (nLevel >= 18)
    {
        nAmount = 4;
        DelayCommand(3.0, FloatingTextStringOnCreature("Low-level attack bonus: +4", oPC));
    }
    else if (nLevel >= 16)
    {
        nAmount = 5;
        DelayCommand(3.0, FloatingTextStringOnCreature("Low-level attack bonus: +5", oPC));
    }
    else if (nLevel >= 14)
    {
        nAmount = 6;
        DelayCommand(3.0, FloatingTextStringOnCreature("Low-level attack bonus: +6", oPC));
    }
    else if (nLevel >= 12)
    {
        nAmount = 7;
        DelayCommand(3.0, FloatingTextStringOnCreature("Low-level attack bonus: +7", oPC));
    }
    else if (nLevel >= 10)
    {
        nAmount = 8;
        DelayCommand(3.0, FloatingTextStringOnCreature("Low-level attack bonus: +8", oPC));
    }
    eAB = EffectAttackIncrease(nAmount);
    eDisc = EffectSkillIncrease(SKILL_DISCIPLINE, nAmount);
    eAB = EffectLinkEffects(eAB, eDisc);
    eAB = ExtraordinaryEffect(eAB);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oPC, HoursToSeconds(24));
}
