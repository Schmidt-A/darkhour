#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (!GetIsObjectValid(oWeapon) || !StX_GetIsWeapon(oWeapon) || StX_GetIsAmmo(oWeapon) )
        return FALSE;
   else return TRUE;
}

