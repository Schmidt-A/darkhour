void main()
{
    object oPC = GetLastUsedBy();
    int nAlign = GetAlignmentGoodEvil(oPC);
    location lLoc;
    if (nAlign == ALIGNMENT_EVIL)
    {
        lLoc = GetLocation(GetWaypointByTag("GoToHell"));
    }
    else if (nAlign == ALIGNMENT_GOOD)
    {
        lLoc = GetLocation(GetWaypointByTag("GoToHeaven"));
    }
    else
    {
        lLoc = GetLocation(GetWaypointByTag("GoToLimbo"));
    }
    AssignCommand(oPC,JumpToLocation(lLoc));
}
