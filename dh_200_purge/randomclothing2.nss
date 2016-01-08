void main()
{
    int nChoice = Random(4) + 1;
    string sClothing;

    if (nChoice == 1)
    {
        sClothing = "sirandarobe";
    }
    else if (nChoice == 2)
    {
        sClothing = "sirandaarmor";
    }
    else if (nChoice == 3)
    {
        sClothing = "sirandaplate";
    }

    object oWear = CreateItemOnObject(sClothing);
    SetDroppableFlag(oWear,FALSE);
    ActionEquipItem(oWear,INVENTORY_SLOT_CHEST);
}
