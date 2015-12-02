#include "stx_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "nModify") == 2)
    {
    ExecuteScript("ammo_abort",oPC);
    DeleteLocalObject(oPC, "STX_CR_ITEM");
    DeleteLocalString(oPC, "NewItemName");
    DeleteLocalInt(oPC, "nModify");
    }
    else
    {
    aw_StopCraft(oPC, GetLocalInt(oPC, "nModify"));
     //makes the penguin walk again
    }
     if (!GetIsPC(OBJECT_SELF)) ActionRandomWalk();
}
