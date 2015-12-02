#include "x2_inc_itemprop"

int StartingConditional()
{
   object oPC = GetLastSpeaker();
   object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
   if (GetIsObjectValid(oWeapon))
   return TRUE;

   else return FALSE;
}
