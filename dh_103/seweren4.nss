void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("ZNRope");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
