void main()
{
object oPC = GetEnteringObject();
object oDestination = GetWaypointByTag("MilitiaJailWP2");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
