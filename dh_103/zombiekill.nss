void main()
{
    //Variables
    object oPC = OBJECT_SELF;
    object oItem = GetFirstItemInInventory(oPC);

    //Add tokens, tally tokens, verify stack counts
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "ZombieKill")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                SetLocalInt(oPC, "zombkill10", 1);
                DestroyObject(oItem);
            }
        }
        if (GetTag(oItem) == "ZK10")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                SetLocalInt(oPC, "zombkill100", 1);
                DestroyObject(oItem);
            }
        }
        if (GetTag(oItem) == "ZKHUNDRED")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                SetLocalInt(oPC, "zombkill1000", 1);
                DestroyObject(oItem);
            }
        }
        if (GetTag(oItem) == "ZKTHOUSAND")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                SetLocalInt(oPC, "zombkill10k", 1);
                DestroyObject(oItem);
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
}
