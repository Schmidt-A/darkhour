void main()
{
object oDamager = GetLastAttacker();
object oTarget = GetWaypointByTag("amalgpunish");
location lLocation = GetLocation(oTarget);
SendMessageToPC(oDamager, "Upon attacking the Amalgamator, you found yourself instantly ripped from his home.");
AssignCommand(oDamager, ClearAllActions(TRUE));
DelayCommand(0.5, AssignCommand(oDamager, ActionJumpToLocation(lLocation)));
}
