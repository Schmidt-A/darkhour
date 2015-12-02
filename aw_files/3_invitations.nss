int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult =  (GetLocalInt(oPC,"ValidInviters") == 3);
    return iResult;
}
