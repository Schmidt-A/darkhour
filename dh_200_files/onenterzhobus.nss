object oDeny;

void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetXP(oPC)==0)
   {
   oDeny = GetWaypointByTag("newplayerwaypointgogo");

   AssignCommand(oPC, JumpToObject(oDeny));

   return;
   }

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("ZHOBUSSPAWN");

lTarget = GetLocation(oTarget);

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

}

