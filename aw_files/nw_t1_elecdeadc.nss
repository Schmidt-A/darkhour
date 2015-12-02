//::///////////////////////////////////////////////
//:: Electrical Trap
//:: NW_T1_ElecDeadC.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The creature setting off the trap is struck by
    a strong electrical current that arcs to 6 other
    targets doing 30d6 damage.  Can make a Reflex
    save for half damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 30, 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    object oCreator = GetTrapCreator(OBJECT_SELF);
    // that works //if(GetPCPlayerName(oCreator) == "Jantima") SendMessageToPC( oCreator, "Your Trap has been triggered");

    int nRogueLevels = GetLevelByClass(CLASS_TYPE_ROGUE,oCreator);
    int nAssassinLevels = GetLevelByClass(CLASS_TYPE_ASSASSIN,oCreator);
    int nRogueInt = GetAbilityModifier(ABILITY_INTELLIGENCE ,oCreator);
    int nSkillModifier = GetSkillRank(SKILL_SET_TRAP,oCreator)/20;
    if (nSkillModifier < 0 )
        nSkillModifier = 1;
    int creatorLevel =  nRogueLevels + nAssassinLevels;
    int finalLevel =  creatorLevel - ( GetHitDice(oCreator) -  creatorLevel);
    if (finalLevel < 0 )
    {
        finalLevel = 0;
    }
    int nSaveDC = 20+ finalLevel/2 + d4(nSkillModifier) + d6();

    // 1. the damage, previously it was d6(30) - now:  d2(GetSkillRank(SKILL_SET_TRAP,oCreator)
    // 2. nSaveDC (reflex save) original = 28
    // 3. how many people around are also hurt = orig nSecondary 6
    TrapDoElectricalDamage(d3(GetSkillRank(SKILL_SET_TRAP,oCreator)),nSaveDC,nSkillModifier + d2(), oCreator);

}

