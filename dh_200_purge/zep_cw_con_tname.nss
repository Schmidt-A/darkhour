//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set the target's name as a conversation token
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
string sName = GetName(oTarget);

SetCustomToken(300, sName);
}
