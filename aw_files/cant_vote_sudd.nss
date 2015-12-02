int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC, "SudVote") == 1);
    return iResult;
}
