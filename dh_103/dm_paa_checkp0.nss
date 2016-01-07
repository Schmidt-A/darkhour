int StartingConditional()
{
    int iResult;
    object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oPlaceable0");

    iResult = GetIsObjectValid(oTarget);
    return iResult;
}
