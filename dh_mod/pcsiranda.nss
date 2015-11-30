//::///////////////////////////////////////////////
//:: FileName pcsiranda
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/1/2007 7:41:43 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_FIGHTER, GetPCSpeaker()) >= 1)
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	// Restrict based on the player's alignment
	if(GetAlignmentGoodEvil(GetPCSpeaker()) != ALIGNMENT_GOOD)
		return FALSE;

	return TRUE;
}
