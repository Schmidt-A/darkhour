////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_wlkwypnt
//  by Don Anderson
//  dandersonru@msn.com
//
//  Walk Waypoints
//  Originally Jasperre's j_ai_walkwaypoin
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_base"

// Run the circuit.
void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0);
// Base for moving round thier waypoints
void WalkWayPoints(int nRun = FALSE, float fPause = 1.0);
// Used in walk waypoints
void RunNextCircuit(int nRun = FALSE, float fPause = 1.0);
// Checks which waypoint they are on, if any valid. TRUE if got any waypoints in range.
int CheckWayPoints(object oWalker = OBJECT_SELF);
//Returns true if the object is walking any waypoints.
int GetIsPostOrWalking(object oWalker = OBJECT_SELF);
// Returns the string to use - depending on day or night.
string GetStringPrefix(string sPrefix, object oWalker = OBJECT_SELF);
//Gets the spawn in condition.Can set things to different ints if you like.

//::///////////////////////////////////////////////
//:: Walk Way Point Path
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows specified person walk a waypoint path
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////

void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)  //Run first circuit
{
    if(CheckWayPoints())
    {
      ClearAllActions();
    }

    string NightWayString;
    string NightPostString;
    string sWay;
    string sPost;

    //The block of code below deals with night and day cycle for postings and walkway points.
    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
      NightWayString = "WN_";
      NightPostString = "NIGHT_";
    }
    else
    {
      NightWayString = "WP_";
      NightPostString = "POST_";
    }

    // We will set what strings to use.
    SetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_DAY", "WP_");
    SetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_NIGHT", NightWayString);
    SetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_DAY", "POST_");
    SetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_NIGHT", NightPostString);

    // Which shall we use? Day or night?
    sWay = GetStringPrefix("NW_GENERIC_WALKWAYS");
    sPost = GetStringPrefix("NW_GENERIC_POSTING");

    //I have now determined what the prefixs for the current walkways and postings are and will use them instead
    // of POST_ and WP_

    if(GetSpawnInCondition(NW_FLAG_STEALTH))
    {
      // Will hide all the time, when they walk
      ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
    }
    else if(GetSpawnInCondition(NW_FLAG_SEARCH))
    {
      // Will search all the time, when they walk, or if we are not going to move.
      ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
    }

    //Test if OBJECT_SELF has waypoints to walk
    string sWayTag = GetTag(OBJECT_SELF);
    sWayTag = sWay + sWayTag + "_01";
    object oWay1 = GetNearestObjectByTag(sWayTag);
    // Get the object, if nearest (IE in area one) is not valid.
    if(!GetIsObjectValid(oWay1))
    {
      oWay1 = GetObjectByTag(sWayTag);
    }

    if(GetIsObjectValid(oWay1))
    {
      int nNth = 1;
      int nTens;
      int nNum;
      object oNearest = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, nNth);
      while (GetIsObjectValid(oNearest))
      {
        string sNearestTag = GetTag(oNearest);
        //removes the first 3 and last three characters from the waypoint's tag
        //and checks it against his own tag.  Waypoint tag format is WP_MyTag_XX.
        if(GetSubString(sNearestTag, 3, GetStringLength(sNearestTag) - 6) == GetTag(OBJECT_SELF))
        {
          string sTens = GetStringRight(GetTag(oNearest), 2);
          nTens = StringToInt(sTens)/10;
          nNum= StringToInt(GetStringRight(GetTag(oNearest), 1));
          oNearest = OBJECT_INVALID;
        }
        else
        {
          nNth++;
          oNearest = GetNearestObject(OBJECT_TYPE_WAYPOINT,OBJECT_SELF,nNth);
        }
      }
      RunCircuit(nTens, nNum, nRun, fPause);
      ActionWait(fPause);
      ActionDoCommand(RunNextCircuit(nRun, fPause));
    }

    //Else go to the post we have set.
    else
    {
      sWayTag = GetTag(OBJECT_SELF);
      sWayTag = sPost + sWayTag;
      oWay1 = GetNearestObjectByTag(sWayTag);
      if(!GetIsObjectValid(oWay1))
      {
        oWay1 = GetObjectByTag(sWayTag);
      }
      if(GetIsObjectValid(oWay1))
      {
        ActionForceMoveToObject(oWay1, nRun, 1.0, 60.0);
        float fFacing = GetFacing(oWay1);
        ActionDoCommand(SetFacing(fFacing));
      }
    }
}

void RunNextCircuit(int nRun = FALSE, float fPause = 1.0)
{
    RunCircuit(0, 1, nRun, fPause);
    ActionWait(fPause);
    ActionDoCommand(RunNextCircuit(nRun, fPause));
}

//::///////////////////////////////////////////////
//:: Run Circuit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calculates the proper path to follow along a
    predetermined set of way points
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////

void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0)
{
    // starting at a given way point, move sequentialy through incrementally
    // increasing points until there are no more valid ones.
    // We will check for day/night in these instead of heartbeats.
    string sWay = GetStringPrefix("NW_GENERIC_WALKWAYS");
    string sNewString;
    object oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) + IntToString(nNum));

    while(GetIsObjectValid(oTargetPoint))
    {
      ActionWait(fPause);
      ActionMoveToObject(oTargetPoint, nRun);
      nNum++;
      if (nNum > 9)
      {
        nTens++;
        nNum = 0;
      }
      // Maybe change string prefix to use.
      sNewString = GetStringPrefix("NW_GENERIC_WALKWAYS");
      if(sNewString != sWay)
      {
        WalkWayPoints(nRun, fPause);
        return;
      }
      oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) + IntToString(nNum));
    }

    // once there are no more waypoints available, decriment back to the last
    // valid point.
    nNum--;
    if (nNum < 0)
    {
      nTens--;
      nNum = 9;
    }

    // start the cycle again going back to point 01
    oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) + IntToString(nNum));
    while(GetIsObjectValid(oTargetPoint))
    {
      ActionWait(fPause);
      ActionMoveToObject(oTargetPoint, nRun);
      nNum--;
      if (nNum < 0)
      {
        nTens--;
        nNum = 9;
      }
      // Maybe change string prefix to use.
      sNewString = GetStringPrefix("NW_GENERIC_WALKWAYS");
      if(sNewString != sWay)
      {
        WalkWayPoints(nRun, fPause);
        return;
      }
      oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) + IntToString(nNum));
    }
}

//::///////////////////////////////////////////////
//:: Check Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function checks the passed in object to
    see if they are supposed to be walking to
    day or night postings.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 26, 2002
//:://////////////////////////////////////////////

int CheckWayPoints(object oWalker)
{
    object oWay1;
    object oWay2;
    object oWay3;
    object oWay4;
    string sTag = GetTag(oWalker);
    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
      oWay2 = GetWaypointByTag("NIGHT_" + sTag);
      oWay4 = GetWaypointByTag("WN_" + sTag + "_01");
    }

    oWay1 = GetWaypointByTag("POST_" + sTag);
    oWay3 = GetWaypointByTag("WP_" + sTag + "_01");

    if(GetIsObjectValid(oWay2) || GetIsObjectValid(oWay4) || GetIsObjectValid(oWay1) || GetIsObjectValid(oWay3))
    {
      return TRUE;
    }
    return FALSE;
}

// Returns the string to use - depending on day or night.
string GetStringPrefix(string sPrefix, object oWalker)
{
    if(GetIsDay() || GetIsDawn())
    {
      return GetLocalString(OBJECT_SELF, sPrefix + "_DAY");
    }
    else
    {
      return GetLocalString(OBJECT_SELF, sPrefix + "_NIGHT");
    }
}

//void main(){}
