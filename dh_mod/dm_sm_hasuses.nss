int StartingConditional()
{
    int iResult;
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    int iCurrentUses = GetLocalInt(oWidget, "iCurrentUses");
    int iMaxUses = GetLocalInt(oWidget, "iMaxUses");
    int iSimUses = GetLocalInt(oWidget, "iSimUses");
    int iCurrentSets = GetLocalInt(oWidget, "iCurrentSets");

    int iHasUses = (iMaxUses == -1) || (iCurrentUses > 0);
    int iHasSets = (iSimUses == -1) || (iCurrentSets < iSimUses);


    iResult = (iHasUses && iHasSets);
    return iResult;
}
