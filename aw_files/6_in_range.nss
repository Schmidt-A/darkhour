int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult;
    iResult = (GetLocalInt(oPC,"ValentinesCount") >= 6);
    return iResult;
}
