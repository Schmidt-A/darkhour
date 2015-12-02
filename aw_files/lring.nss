#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oArmor = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
    if (!GetIsObjectValid(oArmor) || GetPlotFlag(oArmor))
        return FALSE;

    if (GetIsDM(oPC)) return TRUE;


    return TRUE;
}
