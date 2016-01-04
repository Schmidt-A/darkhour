//::///////////////////////////////////////////////
//:: x0_skctrap_con_b
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the player have at least one Negative
    trap component?
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

#include "x0_inc_skills"

int StartingConditional()
{
    int iResult;

    iResult = skillCTRAPGetHasComponent(SKILL_CTRAP_NEGATIVECOMPONENT, GetPCSpeaker(), SKILL_TRAP_MINOR) == TRUE;
    return iResult;
}