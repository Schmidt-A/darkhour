int StartingConditional()
{
    int iResult;
    object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oPlaceable2");

    iResult = GetIsObjectValid(oTarget);
    return iResult;
}
