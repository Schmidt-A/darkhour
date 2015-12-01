void main()
{
object oTarget;
location lTarget;
oTarget = GetWaypointByTag("ladderdownsundes");

lTarget = GetLocation(oTarget);

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

}
