#include "item_enhancement"
void main()
{
    object oPC = GetPCSpeaker();
    object oWep =  GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    StartCrafting(oPC,oWep);


}
