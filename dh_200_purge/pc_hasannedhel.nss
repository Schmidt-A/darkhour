//::///////////////////////////////////////////////
//:: FileName pc_hasannedhel
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/21/2007 7:12:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ANNEDHEL"))
        return FALSE;

    return TRUE;
}
