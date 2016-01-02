int StartingConditional()
{
    int iResult;
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    object oPlaceable = GetLocalObject(OBJECT_SELF, "DM_SM_oPlaceable7");

    string sPropList = GetLocalString(oWidget, "sPropList");
    int iHaveThisProp = TestStringAgainstPattern("**." + ObjectToString(oPlaceable) + ".**", sPropList);

    iResult = (!iHaveThisProp) && (oPlaceable != OBJECT_INVALID);
    return iResult;
}
