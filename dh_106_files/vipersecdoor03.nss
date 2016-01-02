void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("ViperSecDoor04");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
