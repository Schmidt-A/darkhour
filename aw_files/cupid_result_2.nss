int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC,"ValentineResult") == 2);
    DeleteLocalInt(oPC,"ValentineResult");
    return iResult;

}
