void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("STTele1");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
