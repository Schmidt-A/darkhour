int StartingConditional()
{
    int iResult;
    object oDM = GetPCSpeaker();
    iResult = GetIsDM(oDM);
    return iResult;
}
