#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (!GetIsObjectValid(oWeapon) || GetPlotFlag(oWeapon) || IPGetIsIntelligentWeapon(oWeapon) || !StX_GetIsWeapon(oWeapon)) {
        oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
        if (!GetIsObjectValid(oWeapon) || GetPlotFlag(oWeapon) || !StX_GetIsShield(oWeapon)) {
            SetCustomToken(STX_CR_TOKENBASE+5, "You do not have any weapon or shield equipped to modify");
            return TRUE;
        }
    }

    if (GetIsDM(oPC)) return FALSE;


    return FALSE;
}

