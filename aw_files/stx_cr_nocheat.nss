void StX_PurifyItem(object oItem) {
    if (GetLocalInt(oItem, "STX_CR_TEMPITEM")) {
        PrintString("Destroyed: "+GetName(oItem));
        DestroyObject(oItem);
    }
}

void main() {
    object oPC = GetEnteringObject();
    if (GetLocalInt(oPC, "STX_CR_STARTED")) {
        StX_PurifyItem(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
        StX_PurifyItem(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
        StX_PurifyItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
        StX_PurifyItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
        object oItem = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oItem)) {
            StX_PurifyItem(oItem);
            oItem = GetNextItemInInventory(oPC);
        }
        DeleteLocalInt(oPC, "STX_CR_STARTED");
    }
}
