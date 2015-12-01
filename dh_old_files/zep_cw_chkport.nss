//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Check to see if the portrait is being edited
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

int StartingConditional()
{
struct CW2da data = Get2daData();
string sChange = data.change;
int nResult = 0;

if(sChange == "portrait")
    {
    nResult = 1;
    }

return nResult;
}
