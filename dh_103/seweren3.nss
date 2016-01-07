void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("SewerExit3");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
