#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oHelmet = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    StX_StartCraft(oPC, oHelmet);
    StX_SetPart(oPC, STX_CR_HELMET, 182);
}
