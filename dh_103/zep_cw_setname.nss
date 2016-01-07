//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set the name of the creature to the new name
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

void main()
{
object oTarget = GetLocalObject(OBJECT_SELF, "CW_Target");
string sName = GetSpokenString();

SetName(oTarget, sName);
}
