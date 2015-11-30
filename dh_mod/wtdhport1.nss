void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("wtdhportroom2");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
