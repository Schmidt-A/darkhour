//::///////////////////////////////////////////////
//:: FileName pc_hasthreegems
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/21/2007 7:12:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "gemofvalor"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "gemofshadow"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "gemofcorruption"))
        return FALSE;

    return TRUE;
}
