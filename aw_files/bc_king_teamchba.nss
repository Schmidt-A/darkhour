//::///////////////////////////////////////////////
//:: FileName bc_king_teamchba
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 19.2.2005 20:41:10
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetModule(), "TeamChangeBanned") ||
       GetLocalInt(GetModule(), "TeamChangeDisabled") ||
       GetLocalInt(GetPCSpeaker(), "TeamChangeBanned"))
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}
