int StartingConditional()
{
    int iResult;
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    int iPropIndex = GetLocalInt(oWidget, "iPropIndex");

    iResult = iPropIndex > 0;
    return iResult;
}
