#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
      if (!GetIsObjectValid(oItem) || GetPlotFlag(oItem))
        return FALSE;

    return TRUE;
}
