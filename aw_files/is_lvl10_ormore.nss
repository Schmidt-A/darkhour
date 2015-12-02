int StartingConditional()
{    object oPC = GetPCSpeaker();
    int iResult;

    iResult = ((GetHitDice(oPC) > 1) && (GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, oPC)== 0)) ;
    return iResult;
}
