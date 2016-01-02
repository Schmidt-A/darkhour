void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("SewerEnt1");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
