void main()
{
object oPC = GetLastUsedBy();

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("dh_respawnpoint");
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToLocation(lTarget));
}
