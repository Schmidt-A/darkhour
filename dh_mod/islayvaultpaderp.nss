void main()
{
    object oPC = GetLastUsedBy();
    object oItem;
oItem = GetItemPossessedBy(oPC, "ReaperToken");

if (GetIsObjectValid(oItem))
{
   DestroyObject(oItem);
   }

    location lLoc = GetLocation(GetWaypointByTag("islayvaultport"));
    AssignCommand(oPC,JumpToLocation(lLoc));
}
