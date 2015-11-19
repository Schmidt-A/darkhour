void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("SewerEnt2");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
