void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("TSTPortal1");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
