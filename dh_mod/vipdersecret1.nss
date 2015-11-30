void main()
{
object oPC = GetEnteringObject();
if(GetItemPossessedBy(oPC, "ViperLeaderKey") != OBJECT_INVALID)
    {
    object oDestination = GetWaypointByTag("vipersecretwp1");
    location lLocation = GetLocation(oDestination);
    AssignCommand(oPC, JumpToLocation(lLocation));
    }
}
