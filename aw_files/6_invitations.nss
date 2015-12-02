int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult =  (GetLocalInt(oPC,"ValidInviters") == 6);
    return iResult;
}
