void PortToWaypoint(object oPC, string sWPTag)
{
    location lTarget = GetLocation(GetWaypointByTag(sWPTag));

    // Make sure we've got a valid port target.
    if(GetAreaFromLocation(lTarget) == OBJECT_INVALID)
    {
        WriteTimestampedLogEntry("ERROR: Waypoint " + sWPTag + " jump failed.");
	    return;
    }

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lTarget));
}
