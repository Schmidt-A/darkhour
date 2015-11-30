//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set the description of the creature to the new
    description
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

void main()
{
object oTarget = GetLocalObject(OBJECT_SELF, "CW_Target");
SetDescription(oTarget, GetSpokenString());
}
