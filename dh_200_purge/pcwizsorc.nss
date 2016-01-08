//::///////////////////////////////////////////////
//:: FileName pcwizsorc
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/15/2007 12:17:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 1)
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
