int StartingConditional()
{
    int iResult;
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    object oPlaceable = GetLocalObject(OBJECT_SELF, "DM_SM_oPlaceable7");
    int iHaveThisProp = GetLocalInt(oWidget, "iProp" + ObjectToString(oPlaceable));

    iResult = (!iHaveThisProp) && (oPlaceable != OBJECT_INVALID);
    return iResult;
}
