int StartingConditional()
{
    int iResult;
    object oMore = GetLocalObject(OBJECT_SELF, "DM_PAA_oMore");

    iResult = GetIsObjectValid(oMore);
    return iResult;
}
