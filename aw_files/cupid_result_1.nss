int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC,"ValentineResult") == 1);
    DeleteLocalInt(oPC,"ValentineResult");
    return iResult;
}
