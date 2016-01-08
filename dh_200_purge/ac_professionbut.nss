void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemPossessedBy(oPC, "FoodRaw");

    if (oItem != OBJECT_INVALID)
    {
        DestroyObject(oItem);
        CreateItemOnObject("preparedmeats", oPC);
        CreateItemOnObject("preparedmeats", oPC);
    }
    else
        FloatingTextStringOnCreature("You have no meats to prepare.", oPC);
}
