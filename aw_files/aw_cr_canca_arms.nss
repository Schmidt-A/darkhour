#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oArmor = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    if (!GetIsObjectValid(oArmor) || GetPlotFlag(oArmor))
        return FALSE;

    return TRUE;
}
