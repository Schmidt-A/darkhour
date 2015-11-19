void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("STTele3");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
