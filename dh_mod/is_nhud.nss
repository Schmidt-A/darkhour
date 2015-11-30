void main()
{
    object oItem = GetFirstObjectInArea();
    int nPlayerInArea = FALSE;
    object oInside;
    int nDecay;
    while (oItem != OBJECT_INVALID)
    {
//      if ((GetTag(oItem) == "Food") || (GetTag(oItem) == "Spoiled"))
        if (GetObjectType(oItem) == OBJECT_TYPE_ITEM)
        {
            DestroyObject(oItem);
        }
        if ((GetObjectType(oItem) == OBJECT_TYPE_PLACEABLE) && ((GetName(oItem) == "Remains") || (GetName(oItem) == "Player Corpse")))
        {
            nDecay = GetLocalInt(oItem,"decay") + 1;
            if (nDecay >= 1440)
            {
                oInside = GetFirstItemInInventory(oItem);
                while (oInside != OBJECT_INVALID)
                {
                    DestroyObject(oInside);
                    oInside = GetNextItemInInventory(oItem);
                }
                DestroyObject(oItem);
            }
            else
            {
                SetLocalInt(oItem,"decay",nDecay);
            }
        }
        if (GetIsPC(oItem))
        {
            nPlayerInArea = TRUE;
        }
        oItem = GetNextObjectInArea();
    }
    if (nPlayerInArea == FALSE)
    {
        SetLocked(GetObjectByTag("SanctuaryToNHouse"),FALSE);
        SetLocked(GetObjectByTag("NHouseToSanctuary"),FALSE);
    }
}
