// By: Craig Johnson
// Date: July 13, 2008
void main()
{
    // Variables
    object oPC = GetLastClosedBy();
    object oChest = OBJECT_SELF;
    location lLocation = GetLocation(oPC);
    string sModName = GetName(GetModule());
    int nCount;
    object oItem = GetFirstItemInInventory(oChest);
    //Do this while until we run out of items (invalid)
    while (GetIsObjectValid(oItem))
    {
        // Item enumeration, counts how many items we have tallied, and keeps us on track
        nCount++;
        // Check if item is a container (bad!)
        if (GetHasInventory(oItem))
        {
            // Send a message to the player telling them that a container cannot be stored (exploit prevention)
            FloatingTextStringOnCreature("<cø>Containers/bags are NOT allowed to be stored." + "\nPlease remove the container/bag.</c>", oPC);
            return;
        }
        else if (nCount > 100)
        {
            // Send a message to the player telling them that only 100 items can be stored (lag prevention)
            FloatingTextStringOnCreature("<cø>Only a maximum of 100 items are allowed to be stored." + "\nPlease remove the excess items.</c>", oPC);
            return;
        }
        // Next item
        oItem = GetNextItemInInventory(oChest);
    }
    // We have finished testing item validity, now to store them
    object oCommunitychest = CreateObject(OBJECT_TYPE_CREATURE, "persist_storage", lLocation, FALSE);
    // Move through all items in the chest and copy them into
    // the Dummy NPCs inventory and destroy the originals (will remake them when the chest is opened)
    oItem = GetFirstItemInInventory(oChest);
    while (GetIsObjectValid(oItem))
    {
        // Make sure nothing went wrong, and that our Dummy NPC is validly working
        if (!GetIsObjectValid(oCommunitychest))
        {
            return;
        }
        // Copy item to the Dummy NPC
        CopyItem(oItem, oCommunitychest, TRUE);
        // Destroy original (we will recall it when the chest is opened)
        DestroyObject(oItem);
        // Next item
        oItem = GetNextItemInInventory(oChest);
    }
    // Save the Dummy NPC into the database
    StoreCampaignObject(sModName, "community_chest" + GetTag(oChest), oCommunitychest);
    // Destroy Dummy NPC
    DestroyObject(oCommunitychest);
}
