void main()
{
object oPC = GetLastUsedBy();
location lLoc = GetLocation(GetObjectByTag("DHDM_B_1"));
AssignCommand(oPC, JumpToLocation(lLoc));
}
