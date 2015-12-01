void main()
{
object oPC = GetLastUsedBy();
location lLoc = GetLocation(GetObjectByTag("DHDM_R_2"));
AssignCommand(oPC, JumpToLocation(lLoc));
}
