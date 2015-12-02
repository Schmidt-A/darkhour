int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult =  (GetLocalInt(oPC,"ValidInviters") == 2);
    return iResult;
}
