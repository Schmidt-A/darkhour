#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oHelmet = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    if (!GetIsObjectValid(oHelmet) || GetPlotFlag(oHelmet))
        return FALSE;

    if (GetIsDM(oPC)) return TRUE;

    return TRUE;
}

