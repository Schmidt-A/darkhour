//::///////////////////////////////////////////////
//:: Name: pc has at least one gold piece
//:: FileName: td_sc_has1gold
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Thales Darkshine (Russ Henson)
//:: Created On:
//:://////////////////////////////////////////////
int StartingConditional()
{
    if (GetGold(GetPCSpeaker()) < 1) return FALSE;

    return TRUE;
}

