int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC,"ValentineResult") == 3);
    DeleteLocalInt(oPC,"ValentineResult");
    return iResult;

}
