int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult;
    iResult = (GetLocalInt(oPC,"ValentinesCount") >= 4);
    return iResult;
}
