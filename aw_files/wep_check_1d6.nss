#include "item_enhancement"

int StartingConditional()
{
    object oWep = GetLocalObject(GetPCSpeaker(),"copy");
    if (Is_1d6(GetBaseItemType(oWep)) || Is_1d8(GetBaseItemType(oWep)) || Is_1d10(GetBaseItemType(oWep))  || Is_1d12(GetBaseItemType(oWep)))
    {
        return TRUE;
    }
    else return FALSE;
}
