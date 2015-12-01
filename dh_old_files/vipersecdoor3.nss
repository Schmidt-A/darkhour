void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetWaypointByTag("ViperSecDoorWP002");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
