#include "mali_string_fns"


int StartingConditional()
{
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    int iSets = GetLocalInt(oWidget, "iCurrentSets");

    return (iSets == 1);
}
