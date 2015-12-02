#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
    SetLocalInt(oPC,"nSlot",INVENTORY_SLOT_ARROWS);
    int nModify = GetLocalInt(oPC, "nModify") ;
    aw_StartCraft(oPC, oItem, nModify);
    if(nModify == 0)
    {
        if (GetBaseItemType(oItem)  == BASE_ITEM_ARROW) StX_SetPart(oPC, STX_CR_PART_ARROWS, 6757);
    }
}
