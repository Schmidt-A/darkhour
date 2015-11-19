void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("ViperSecDoor01");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
