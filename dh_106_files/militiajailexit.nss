void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetWaypointByTag("MilitiaJailWP1");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
