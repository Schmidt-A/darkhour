#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    aw_StartCraft(oPC, oItem, GetLocalInt(oPC, "nModify"));
}
