int StartingConditional()
{
    int iResult;
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    object oPlaceable = GetLocalObject(OBJECT_SELF, "DM_SM_oPlaceable9");

    iResult = GetIsObjectValid(oPlaceable);
    return iResult;
}
