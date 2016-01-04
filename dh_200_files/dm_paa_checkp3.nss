int StartingConditional()
{
    int iResult;
    object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oPlaceable3");

    iResult = GetIsObjectValid(oTarget);
    return iResult;
}
