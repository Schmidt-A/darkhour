int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult =  (GetLocalInt(oPC,"ValidInviters") == 1);
    return iResult;
}
