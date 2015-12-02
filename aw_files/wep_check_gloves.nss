int StartingConditional()
{
    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS,GetPCSpeaker());

    if (GetBaseItemType(oGloves) != BASE_ITEM_GLOVES)
        return FALSE;

    return TRUE;
}
