int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC, "HuntVote") == 0);
    iResult = (GetLocalInt(GetModule(), "NoHunt") == TRUE);
    return iResult;
}
