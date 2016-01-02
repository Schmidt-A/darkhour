void AgeFood()
{
    int nCharges;
    int nNumberSpoiled = 0;
    object oFood = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oFood))
    {
        if (GetTag(oFood) == "Food")
        {
            nCharges = GetItemCharges(oFood);
            if (nCharges <= 1)
            {
                if (GetName(oFood) != "Purified Food")
                {
                    nNumberSpoiled += 1;
                }
                DestroyObject(oFood);
            }
            else
            {
                SetItemCharges(oFood,(nCharges - 1));
            }
        }
        else if (GetTag(oFood) == "SpoiledFood")
        {
            nCharges = GetItemCharges(oFood);
            if (nCharges <= 1)
            {
                DestroyObject(oFood);
            }
            else
            {
                SetItemCharges(oFood,(nCharges - 1));
            }
        }
        oFood = GetNextItemInInventory(OBJECT_SELF);
    }
    while (nNumberSpoiled > 0)
    {
        CreateItemOnObject("spoiledfood",OBJECT_SELF);
        nNumberSpoiled -= 1;
    }
}

void main()
{
    int nCounter = GetLocalInt(OBJECT_SELF,"foodcounter") + 1;
    if (nCounter >= 80)
    {
        AgeFood();
        nCounter = 0;
    }
    SetLocalInt(OBJECT_SELF,"foodcounter",nCounter);
}
