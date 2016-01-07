void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("ViperSecDoor02");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
