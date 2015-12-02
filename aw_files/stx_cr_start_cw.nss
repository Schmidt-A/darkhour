#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oArmor = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    StX_StartCraft(oPC, oArmor);
}
