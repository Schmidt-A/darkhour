void main()
{
    object oPC = GetLastUsedBy();
    location lLoc = GetLocation(GetWaypointByTag("Xtailors"));
    AssignCommand(oPC,JumpToLocation(lLoc));
}
