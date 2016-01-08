int StartingConditional()
{
    int iResult;
    object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");

    iResult = !GetIsObjectValid(oTarget);
    return iResult;
}
