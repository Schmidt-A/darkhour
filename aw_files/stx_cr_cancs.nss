#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    if (!GetIsObjectValid(oShield) || GetPlotFlag(oShield)/* || !StX_GetIsShield(oShield) */)
        return FALSE;

    if (GetIsDM(oPC)) return TRUE;



    return TRUE;
}

