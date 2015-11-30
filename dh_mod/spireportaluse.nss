void main()
{
    object oPC = GetLastUsedBy();
    location lLoc = GetLocation(GetWaypointByTag("spirebottom"));
    AssignCommand(oPC,JumpToLocation(lLoc));
}
