void main()
{
object oPC = GetLastUsedBy();
location lLoc = GetLocation(GetObjectByTag("DHDM_R_1"));
AssignCommand(oPC, JumpToLocation(lLoc));
}
