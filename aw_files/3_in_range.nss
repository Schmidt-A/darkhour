int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult;
    iResult = (GetLocalInt(oPC,"ValentinesCount") >= 3);
    return iResult;
}
