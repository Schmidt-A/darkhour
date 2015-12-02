int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC, "HuntVote") == 1);
    return iResult;
}
