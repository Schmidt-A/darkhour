//::///////////////////////////////////////////////
//:: FileName convo_pcmale
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/31/2007 2:55:58 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Add the gender restrictions
	if(GetGender(GetPCSpeaker()) != GENDER_MALE)
		return FALSE;

	return TRUE;
}
