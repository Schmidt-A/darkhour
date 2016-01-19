void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemPossessedBy(oPC, "FoodRaw");

    if (GetItemPosseossedBy(oPC, "FoodRaw") != OBJECT_INVALID)
    {
        DestroyObject(oItem);
        CreateItemOnObject("cookedfood", oPC);
    }
    else if(GetItemPossessedBy(oPC, "preparedmeats") != OBJECT_INVALID)
    {
        DestroyItem(GetItemPossessedBy(oPC, "preparedmeats"));
        CreateItemOnObject("cookedfood", oPC);
    }
    else
        FloatingTextStringOnCreature("You have no food to cook.", oPC, FALSE);
}
