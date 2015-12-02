#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
    SetLocalInt(oPC,"nSlot",INVENTORY_SLOT_BOOTS);
    int  nModify = GetLocalInt(oPC, "nModify");
    aw_StartCraft(oPC, oItem, GetLocalInt(oPC, "nModify"));
}
