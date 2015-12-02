#include "x2_inc_itemprop"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);

    if (!IPGetIsRangedWeapon(oWep))
    {
        return TRUE;
    }

    return FALSE;
}
