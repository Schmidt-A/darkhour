void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("IHRope");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
