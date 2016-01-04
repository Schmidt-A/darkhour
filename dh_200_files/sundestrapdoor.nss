void main()
{
object oPC = GetLastUsedBy();
location lTarget;
object oTarget;
oTarget = GetWaypointByTag("SunDesSecret");

lTarget = GetLocation(oTarget);

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));
}
