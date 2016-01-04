int StartingConditional()
{
    int iResult;
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    string sDesc = GetDescription(oWidget, FALSE, FALSE);
    int iIsDM = GetIsDM(OBJECT_SELF) || GetIsDMPossessed(OBJECT_SELF);

    iResult = (sDesc == "EMPTY") && iIsDM;
    return iResult;
}
