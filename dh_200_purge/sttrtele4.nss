void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("STTele4");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
