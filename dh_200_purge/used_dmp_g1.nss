void main()
{
object oPC = GetLastUsedBy();
location lLoc = GetLocation(GetObjectByTag("DHDM_G_2"));
AssignCommand(oPC, JumpToLocation(lLoc));
}
