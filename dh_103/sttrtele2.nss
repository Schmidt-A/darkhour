void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("STTele2");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
