//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Change alignment to neutral
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

void main()
{
struct CW2da data = Get2daData();
object oTarget = data.target;

AdjustAlignment(oTarget, ALIGNMENT_NEUTRAL, 100);
ExecuteScript("zep_cw_con_talig", OBJECT_SELF);
}
