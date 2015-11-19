//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Level the creature up in the specified class
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

void main()
{
object oTarget = GetLocalObject(OBJECT_SELF, "CW_Target");
int nClass = GetLocalInt(OBJECT_SELF, "CW_Class");
int nLevel = StringToInt(GetSpokenString());

LevelUp(oTarget, nClass, nLevel);
TokenList();
}
