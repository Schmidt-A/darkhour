void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("wtdhportroom1");
location lLocation = GetLocation(oDestination);
AssignCommand(oPC, JumpToLocation(lLocation));
}
