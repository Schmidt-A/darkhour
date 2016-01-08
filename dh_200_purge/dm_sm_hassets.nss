int StartingConditional()
{
    int iResult;
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    int iCurrentSets = GetLocalInt(oWidget, "iCurrentSets");

    iResult = iCurrentSets;
    return iResult;
}
