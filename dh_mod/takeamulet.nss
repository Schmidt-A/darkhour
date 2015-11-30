void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC) == FALSE)
    {
    return;
    }
if(GetCampaignInt(GetName(GetModule()), "wasinworking", oPC) != 0)
    {
    int iGP = GetGold(oPC);
    TakeGoldFromCreature(iGP, oPC, TRUE);
    int iGold = GetCampaignInt(GetName(GetModule()), "craftinggold", oPC);
    GiveGoldToCreature(oPC, iGold);
    }
object oAmmy = GetItemPossessedBy(oPC, "CraftingNecklace");
if(oAmmy != OBJECT_INVALID)
    {
    DestroyObject(oAmmy);
    }
ExecuteScript("subdualenter", oPC);
}
