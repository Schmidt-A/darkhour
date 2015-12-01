int StartingConditional()
{
    int iResult;
    int iOffset = GetLocalInt(OBJECT_SELF, "DM_PAA_iOffset");

    iResult = iOffset > 10;
    return iResult;
}
