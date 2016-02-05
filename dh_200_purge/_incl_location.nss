#include "nwnx_funcs"
#include "_incl_rndloc"

location GetRandomWalkableLocation(location lCenter, int iMinRange, int iMaxRange)
{
    location lRandom = RndLoc(lCenter, iMaxRange, iMinRange);
    while(!GetIsWalkableLocation(lRandom))
        lRandom = RndLoc(lCenter, iMaxRange, iMinRange);

    return lRandom;
}

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

void PortToLocation(object oPC, location lLocation)
{
    // Make sure we've got a valid port target.
    if(GetAreaFromLocation(lLocation) == OBJECT_INVALID)
    {
        WriteTimestampedLogEntry("ERROR: lLocation jump failed.");
        return;
    }

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lLocation));
}

int PortToWPIfAreaIsEmpty(object oPC, string sWPTag)
{
    location lLoc   = GetLocation(GetWaypointByTag(sWPTag));
    object oArea    = GetAreaFromLocation(lLoc);
    object oObj     = GetFirstObjectInArea(oArea);
    int bHasPlayer  = FALSE;

    // See if there are any players in the area we're attempting to jump to
    while(GetIsObjectValid(oObj))
    {
        if(GetIsPC(oObj) && !GetIsDM(oObj))
        {
            hasPlayer = TRUE;
            break;
        }
        oObj = GetNextObjectInArea(oArea);
    }
    if(!hasPlayer)
    {
        PortToWaypoint(oPC, lLoc);
        return TRUE;
    }
    return FALSE;
}
