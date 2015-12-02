#include "stx_inc_craft"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    object oArmor = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    if (!GetIsObjectValid(oArmor) || GetPlotFlag(oArmor)) {
        oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
        if (!GetIsObjectValid(oArmor) || GetPlotFlag(oArmor)) {
            SetCustomToken(STX_CR_TOKENBASE+4, "You do not have any armor or helmet equipped to modify");
            return TRUE;
        }
    }

    if (GetIsDM(oPC)) return FALSE;

    string sRequired;
    if (GetBaseItemType(oArmor)==BASE_ITEM_HELMET) {
        sRequired = "STX_CR_HELMET";
    } else {
        int iAC = StringToInt(Get2DAString("parts_chest", "ACBONUS", GetItemAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_TORSO)));
        if (iAC==0)           sRequired = "STX_CR_CLOTH";
        if (iAC>=1 && iAC<=3) sRequired = "STX_CR_LEATHER";
        if (iAC>=4 && iAC<=5) sRequired = "STX_CR_SCALE";
        if (iAC>=6 && iAC<=8) sRequired = "STX_CR_METAL";
    }

    return FALSE;
}
