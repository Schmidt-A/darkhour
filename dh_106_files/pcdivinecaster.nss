//::///////////////////////////////////////////////
//:: FileName pcdivinecaster
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/27/2007 11:40:38 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_BARD, GetPCSpeaker()) >= 1)
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_CLERIC, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_DRUID, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
