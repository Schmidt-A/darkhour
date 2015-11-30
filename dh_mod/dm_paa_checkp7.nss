int StartingConditional()
{
    int iResult;
    object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oPlaceable7");

    iResult = GetIsObjectValid(oTarget);
    return iResult;
}
