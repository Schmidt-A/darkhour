string OOC_ITEM_DUMP_TAG = "OOCItemDump";

// Currently the zombification case
void DestroyAllItems(object oPC, int bEquipped=FALSE, int bGold=TRUE)
{
    // This means we want to destroy equipped items too
    if(bEquipped)
    {
        object oEquipped;
        int iSlot;

        // Iterate over non-creature equipped items
        for(iSlot=0; iSlot<14; iSlot++)
        {
            oEquipped = GetItemInSlot(iSlot, oPC);
            AssignCommand(oPC, ActionUnequipItem(oEquipped));
        }
    }

    object oItem = GetFirstItemInInventory(oPC);
    object oNextItem;
    string sTag;

    while(GetIsObjectValid(oItem))
    {
        // Grab this here since deletion in lists is weird
        oNextItem = GetNextItemInInventory(oPC);

        // Destroy all undroppable items
        if(!GetItemCursedFlag(oItem))
            DestroyObject(oItem);

        oItem = oNextItem;
    }

    if(bGold)
    {
        object oGoldDump = GetObjectByTag(OOC_ITEM_DUMP_TAG);
        AssignCommand(oGoldDump, TakeGoldFromCreature(GetGold(oPC), oPC));
    }
}

// Used for death case - could probably get used elsewhere
void TransferAllItems(object oPC, object oTarget, int bDestroyShurikan=TRUE,
        int bGold=TRUE, int bEquipped=FALSE)
{
    object oItem;
    object oNextItem;
    string sTag;

    if(bDestroyShurikan)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        if(GetTag(oItem) == "kishuriken")
            DestroyObject(oItem);
    }

    oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        sTag = GetTag(oItem);
        oNextItem = GetNextItemInInventory(oPC);

        if(sTag == "kishuriken")
            DestroyObject(oItem);
        // Tweek: what is that NW_ item?
        else if(!GetItemCursedFlag(oItem) && sTag != "NW_WBWSL001")
            AssignCommand(oTarget, ActionTakeItem(oItem, oPC));

        oItem = oNextItem;
    }

    if(bGold)
        AssignCommand(oTarget, TakeGoldFromCreature(GetGold(oPC), oPC));
}
