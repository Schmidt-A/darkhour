int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult;
    iResult = (GetLocalInt(oPC,"ValentinesCount") >= 7);
    return iResult;
}
