void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemPossessedBy(oPC, "FoodRaw");

    if (GetItemPossessedBy(oPC, "FoodRaw") != OBJECT_INVALID)
    {
        DestroyObject(oItem);
        CreateItemOnObject("cookedfood", oPC);
    }
    else if(GetItemPossessedBy(oPC, "preparedmeats") != OBJECT_INVALID)
    {
        DestroyObject(GetItemPossessedBy(oPC, "preparedmeats"));
        CreateItemOnObject("cookedfood", oPC);
    }
    else
        FloatingTextStringOnCreature("You have no food to cook.", oPC, FALSE);
}
