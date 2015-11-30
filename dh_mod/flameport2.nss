void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("Flameportal1");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
SendMessageToPC(oPC, "You pass through the flame unharmed and your new surroundings fade into view.");
}
