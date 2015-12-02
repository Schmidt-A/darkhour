#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (!GetIsObjectValid(oWeapon) && ( GetBaseItemType(oWeapon) == BASE_ITEM_SHURIKEN ||  GetBaseItemType(oWeapon) == BASE_ITEM_DART) )
        return FALSE;

    if (GetIsDM(oPC)) return TRUE;

    return TRUE;
}

