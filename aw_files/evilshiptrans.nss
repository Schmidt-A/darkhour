void main()
{
object oPC = GetClickingObject();
object oWaypoint = GetWaypointByTag("EvilShipExit");
location lWaypoint = GetLocation(oWaypoint);
int nTeam = GetLocalInt(oPC, "nTeam");
if (nTeam == 2)
{
    AssignCommand(oPC, ActionJumpToLocation(lWaypoint));
}
else
{
    FloatingTextStringOnCreature("Only the evil team can use this ship.", oPC);
}
}
