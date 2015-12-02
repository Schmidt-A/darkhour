int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult =  (GetLocalInt(oPC,"ValidInviters") == 4);
    return iResult;
}
