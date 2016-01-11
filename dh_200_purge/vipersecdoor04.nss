void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("ViperSecDoor03");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
