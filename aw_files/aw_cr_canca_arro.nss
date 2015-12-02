#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oArmor = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
    if (!GetIsObjectValid(oArmor) )
        return FALSE;

    return TRUE;
}
