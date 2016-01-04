void main()
{
    object oPC = GetLastUsedBy();
    location lLoc = GetLocation(GetWaypointByTag("Etailors"));
    AssignCommand(oPC,JumpToLocation(lLoc));
}
