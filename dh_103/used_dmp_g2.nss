void main()
{
object oPC = GetLastUsedBy();
location lLoc = GetLocation(GetObjectByTag("DHDM_G_1"));
AssignCommand(oPC, JumpToLocation(lLoc));
}
