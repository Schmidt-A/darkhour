void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("SUNDESSTART");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
