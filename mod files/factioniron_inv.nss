//::///////////////////////////////////////////////
//:: FileName factioniron_inv
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/19/2007 6:28:17 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "professionmerchant"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "professionpocket"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "professionthug"))
		return FALSE;

	return TRUE;
}
