#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oArmor = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
   if (!GetIsObjectValid(oArmor))
        return FALSE;

    return TRUE;
}
