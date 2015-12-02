#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();
    object oWep =  GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    StartCrafting(oPC,oWep);




}

