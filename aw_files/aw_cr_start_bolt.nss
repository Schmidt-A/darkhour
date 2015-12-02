#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
    SetLocalInt(oPC,"nSlot",INVENTORY_SLOT_BOLTS);
    int nModify = GetLocalInt(oPC, "nModify") ;
    aw_StartCraft(oPC, oItem, nModify);
    if(nModify == 0)
    {
        StX_SetPart(oPC, STX_CR_PART_BOLTS, 6758);
    }
}
