#include "x2_inc_itemprop"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    //don't have a weapon equipped
   if( ( oWep == OBJECT_INVALID))
   {
        return TRUE;
    }
    return FALSE;
}
