void main()
{
object oDamager = OBJECT_SELF;
object oTarget = GetWaypointByTag("amalgsave");
location lLocation = GetLocation(oTarget);
SendMessageToPC(oDamager, "The Amalgamator had mercy on your soul, but you dare not attack him again.");
AssignCommand(oDamager, ClearAllActions(TRUE));
DelayCommand(0.5, AssignCommand(oDamager, ActionJumpToLocation(lLocation)));
}
