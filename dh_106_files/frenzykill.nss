void main()
{
    //Variables
    object oPC = OBJECT_SELF;
    object oItem = GetFirstItemInInventory(oPC);

    //Add tokens, tally tokens, verify stack counts
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "FrenzyKill")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                DestroyObject(oItem);
                SetLocalInt(oPC, "frenzykill10", 1);
            }
        }
        if (GetTag(oItem) == "FK10")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                DestroyObject(oItem);
                SetLocalInt(oPC, "frenzykill100", 1);
            }
        }
        if (GetTag(oItem) == "FK100")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                DestroyObject(oItem);
                SetLocalInt(oPC, "frenzykill1000", 1);
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
}
