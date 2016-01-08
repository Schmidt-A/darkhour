//::///////////////////////////////////////////////
//:: FileName prof_barricheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/3/2007 4:40:05 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has this item in their inventory
    if(!HasItem(GetPCSpeaker(), "rotd_wood"))
        return FALSE;

    return TRUE;
}
