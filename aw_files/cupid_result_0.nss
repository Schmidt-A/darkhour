int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC,"ValentineResult") == 0);
    DeleteLocalInt(oPC,"ValentineResult");
    return iResult;

}
