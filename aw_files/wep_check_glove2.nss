int StartingConditional()
{
    object oPC = GetPCSpeaker();

    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);

    if (GetBaseItemType(oGloves) != BASE_ITEM_GLOVES)
    {
        if (GetLocalObject(oPC,"copy") != OBJECT_INVALID)
        {
            DestroyObject( GetLocalObject(oPC,"copy"));
        }
        return TRUE;
    }

    return FALSE;
}
