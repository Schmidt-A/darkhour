int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult;

    iResult = (GetLocalInt(oPC,"initialLevel")!= 0 && GetLocalInt(oPC,"initialLevel")!= GetXP(oPC));
    return iResult;
}
