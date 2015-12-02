int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC,"ValentineResult") == 4);
    DeleteLocalInt(oPC,"ValentineResult");
    return iResult;

}
