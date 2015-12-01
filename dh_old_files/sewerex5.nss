void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("IHGrate");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
