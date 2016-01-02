int StartingConditional()
{
    int iResult;
    object oMore = GetLocalObject(OBJECT_SELF, "DM_SM_oMore");

    iResult = GetIsObjectValid(oMore);
    return iResult;
}
