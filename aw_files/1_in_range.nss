int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult;
    iResult = (GetLocalInt(oPC,"ValentinesCount") >= 1);
    return iResult;
}