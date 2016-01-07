void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("SewerEnt3");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
