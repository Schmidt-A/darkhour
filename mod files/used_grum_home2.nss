void main()
{
object oPC = GetEnteringObject();
AssignCommand(oPC, ClearAllActions(TRUE));
object oDestination = GetObjectByTag("Grum_Home_WP");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
