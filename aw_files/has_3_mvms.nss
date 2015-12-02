int StartingConditional()
{
    int nMvms = 0;

    object oPC = GetPCSpeaker();

    object oItem = GetFirstItemInInventory(oPC);

    //count mvms in inventory
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "specialitem" || GetTag(oItem) == "specialitemf")
            nMvms++;
        oItem = GetNextItemInInventory(oPC);
    }

    if (nMvms >= 3)
        return TRUE;
    else
        return FALSE;

}
