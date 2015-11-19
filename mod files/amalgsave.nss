void main()
{
object oDamager = GetLastUsedBy();
object oTarget = GetWaypointByTag("amalgsave");
location lLocation = GetLocation(oTarget);
SendMessageToPC(oDamager, "Though you survived, you now know not to attack the Amalgamator.");
AssignCommand(oDamager, ClearAllActions(TRUE));
DelayCommand(0.5, AssignCommand(oDamager, ActionJumpToLocation(lLocation)));
}
