#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    StX_StartCraft(oPC, oShield);
    StX_SetPart(oPC, STX_CR_SHIELD, 57);
}
