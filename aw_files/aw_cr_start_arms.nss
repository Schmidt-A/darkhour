#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    int nModify = GetLocalInt(oPC, "nModify") ;
    aw_StartCraft(oPC, oItem, nModify);
    if(nModify == 0)
    {
        if (GetBaseItemType(oItem)  == BASE_ITEM_GLOVES) StX_SetPart(oPC, STX_CR_PART_GLOVES, 7672);
        else if (GetBaseItemType(oItem)  == BASE_ITEM_BRACER) StX_SetPart(oPC, STX_CR_PART_BRACER, 6746);
    }
}
