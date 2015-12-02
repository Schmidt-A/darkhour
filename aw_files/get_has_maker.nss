#include "stx_inc_craft"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem =  GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
    if  (GetIsAmmoMaker(oItem) ) return FALSE;
    oItem = GetNextItemInInventory(oPC);
    }
   return TRUE;
}
