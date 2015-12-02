void main()
{
object oPC = GetClickingObject();
object oWaypoint = GetWaypointByTag("GoodShipExit");
location lWaypoint = GetLocation(oWaypoint);
int nTeam = GetLocalInt(oPC, "nTeam");
if (nTeam == 1)
{
    AssignCommand(oPC, ActionJumpToLocation(lWaypoint));
}
else
{
    FloatingTextStringOnCreature("Only the good team can use this ship.", oPC);
}
}
