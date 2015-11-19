void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("STTele5");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
