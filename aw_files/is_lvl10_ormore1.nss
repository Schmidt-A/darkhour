int StartingConditional()
{    object oPC = GetPCSpeaker();
    int iResult;

    iResult = (GetHitDice(oPC) > 1)  ;
    return iResult;
}
