int StartingConditional()
{   object oPC = GetPCSpeaker();
    int iResult;

    iResult = (GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, oPC)>= 1);
    return iResult;
}
