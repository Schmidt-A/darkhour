void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("SewerExit2");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
