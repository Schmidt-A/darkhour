#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    int nModify = GetLocalInt(oPC, "nModify") ;
    aw_StartCraft(oPC, oItem, nModify);
    if(nModify == 0)
    {
      StX_SetPart(oPC, STX_CR_PART_CLOAK, 2220);
    }
}