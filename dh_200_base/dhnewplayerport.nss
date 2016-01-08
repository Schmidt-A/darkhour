void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "darkhourtoken")!= OBJECT_INVALID)
   return;

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("newplayerwaypoint");

lTarget = GetLocation(oTarget);

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

}
