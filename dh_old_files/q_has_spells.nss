//::///////////////////////////////////////////////
//:: FileName q_has_spells
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/5/2003 1:25:50 PM
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
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_HARPER, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_BLACKGUARD, GetPCSpeaker()) >= 1))
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
