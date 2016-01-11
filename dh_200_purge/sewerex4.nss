void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("ZNGrate");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
