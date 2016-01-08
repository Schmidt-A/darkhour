void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemPossessedBy(oPC, "rotd_wood");

    if (oItem != OBJECT_INVALID)
    {
        DestroyObject(oItem);
        for(int i=0; i< 10; i++)
            CreateItemOnObject("fletcharrow", oPC);
    }
    else
        FloatingTextStringOnCreature("You require wood to make arrows.", oPC, FALSE);
}
