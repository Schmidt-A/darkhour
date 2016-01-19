// By: Craig Johnson
// Date: July 13, 2008
void main()
{
    // Variables
    object oPC = GetLastOpenedBy();
    object oChest = OBJECT_SELF;
    if(GetLocalInt(OBJECT_SELF, "LOADED") != 1)
        {
        SetLocalInt(OBJECT_SELF, "LOADED", 1);
        }
    else
        {
        return;
        }
    location lLocation = GetLocation(oPC);
    string sModName = GetName(GetModule());
    // End script if these are not valid (prevents accidental NPC openings)
    //if (!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC) || GetIsPossessedFamiliar(oPC)) return;
    // Retrieve the Dummy NPC from the database
    object oCommunitychest = RetrieveCampaignObject(sModName, "community_chest" + GetTag(oChest), lLocation);
    //DeleteCampaignVariable(sModName, "community_chest" + GetTag(oChest));
    // Move through and retrieve our items from the stored inventory
    object oItem = GetFirstItemInInventory(oCommunitychest);
    while (GetIsObjectValid(oItem))
    {
        // Copy the item into the chest
        object oNew = CopyItem(oItem, oChest, TRUE);
        SetDescription(oNew, GetLocalString(oItem, "DESC"), TRUE);
        // Destroy the original (we can recall it later)
        DestroyObject(oItem);

        // Next item
        oItem = GetNextItemInInventory(oCommunitychest);
    }
    // Destroy the Dummy NPC
    DestroyObject(oCommunitychest);
}
