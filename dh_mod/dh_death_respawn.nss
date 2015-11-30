void main()
{
object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetHitDice(oPC) == 1)
{
SetXP(oPC, 0);
}
else if (GetHitDice(oPC) == 2)
{
SetXP(oPC, 0);
}
else if (GetHitDice(oPC) == 3)
{
SetXP(oPC, 1000);
}
else if (GetHitDice(oPC) == 4)
{
SetXP(oPC, 3000);
}
else if (GetHitDice(oPC) == 5)
{
SetXP(oPC, 6000);
}
object oTarget;
location lTarget;
oTarget = GetWaypointByTag("dh_respawnpoint");
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToLocation(lTarget));
}
