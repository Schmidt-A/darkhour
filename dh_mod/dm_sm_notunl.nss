int StartingConditional()
{
    int iResult;

    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    int iMaxUses = GetLocalInt(oWidget, "iMaxUses");

    iResult = (iMaxUses != -1);
    return iResult;
}
