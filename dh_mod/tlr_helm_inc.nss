//::///////////////////////////////////////////////
//:: MIL_TAILOR Helmet Include
//:://////////////////////////////////////////////
/*
//:://////////////////////////////////////////////
//:: Created By: stacy_19201325
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
*/

const int    PART_NEXT  = 0;
const int    PART_PREV  = 1;
const int    HELMET = 8888;

void StartHelm(object oModel, object oItem) {
    SetLocalObject(oModel, "ITEM", oItem);
}

void RemakeHelm(object oModel, object oItem, int nMode) {

    int nCurrApp, nSlot;
    object oNew;
    SetLocalObject(oModel, "ITEM", oItem);
    object oItem = GetLocalObject(oModel, "ITEM");

        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_HELMET));

        do {
            if (nMode == PART_NEXT) {
                if (++nCurrApp>nMax) nCurrApp = nMin;
            } else {
                if (--nCurrApp<nMin) nCurrApp = nMax;
            }

            oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0, nCurrApp, TRUE);
            } while (!GetIsObjectValid(oNew));
            nSlot = INVENTORY_SLOT_HEAD;


    if (GetIsObjectValid(oNew)) {
        DestroyObject(oItem);
        AssignCommand(oModel, ClearAllActions(TRUE));
        AssignCommand(oModel, ActionEquipItem(oNew, nSlot));
    }
        object oPC = GetPCSpeaker();
        SendMessageToPC(oPC, "New Appearance: " + IntToString(nCurrApp));
}
