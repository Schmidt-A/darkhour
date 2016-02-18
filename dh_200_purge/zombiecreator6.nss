//Easy Spawner. Use in Non-Siranda Location. Grants No bonus to zombies.
// This script is called from the OnHeartbeat of different placeables in all of the old-world Ronin-made
// areas.
// Created by Ronin_DM on Unknown
// Commenting by Zunath on July 22, 2007

#include "_incl_enemies"

void main()
{
    //PrintString("zombiecreator: " + GetName(OBJECT_SELF) + " In: " + GetName(GetArea(OBJECT_SELF))); // Debug - find out wtf this script is called from
    // CURRENT number of zombies
    int nZNum = 0;
    // CURRENT number of waypoints
    int nWNum = 0;
    // Waypoint tags to spawn the zombies at
    string sWTag = GetLocalString(OBJECT_SELF,"wpt");
    // MAX number of zombies as indicated on the local int of this placeable
    int nZExpected = GetLocalInt(OBJECT_SELF,"noz");
    // MAX number of behemoths as indicated on the local int of this placeable
    int nBehemoth = GetLocalInt(OBJECT_SELF,"beh");
    int nHunter = GetLocalInt(OBJECT_SELF,"hunt");
    int nLeaper = GetLocalInt(OBJECT_SELF,"leap");
    int nGLeaper = GetLocalInt(OBJECT_SELF, "leap2");
    int nBAT = FALSE;
    int nHUN = FALSE;
    int nLEP = FALSE;
    int nLEP2 = FALSE;

    // Cycle through the area looking at all objects and if they are zombies, behemoths
    // or specified waypoints, take the following actions
    object oObj = GetFirstObjectInArea();
    while (oObj != OBJECT_INVALID)
    {
        // If the current object is a zombie do this
        if (GetStringLeft(GetTag(oObj),9) == "ZN_ZOMBIE")
        {
            // Increase the current number of zombies
            nZNum += 1;

            // If it's a behemoth, set nBAT to true
            if (GetTag(oObj) == "ZN_ZOMBIEB")
            {
                nBAT = TRUE;
            }
            if (GetTag(oObj) == "dh_hunter")
            {
                nHUN = TRUE;
            }
            if (GetTag(oObj) == "dh_leaper")
            {
                nLEP = TRUE;
            }
            if (GetTag(oObj) == "dh_gleaper")
                {
                nLEP2 = TRUE;
                }
        }
        // Otherwise if it's a waypoint with the same tag as indicated on this object's
        // variables, increase the current waypoints by 1
        else if (GetTag(oObj) == sWTag)
        {
            nWNum += 1;
        }
        // Done with this object, move to the next object in the area.
        oObj = GetNextObjectInArea();
    }

    // If the current amount of zombies is less than the MAX number of zombies,
    // create a random zombie and cause it to walk randomly
    if (nZNum < nZExpected)
    {
        oObj = GetObjectByTag(sWTag,Random(nWNum));
        location lSpot = GetLocation(oObj);
        string sType;
        // When all conditions for creation of zombie behemoths are right,
        // set the sType to the resref of the behemoth.
        if ((nBehemoth == 1) && (nBAT == FALSE) && (Random(60) == 1))
        {
            sType = "zn_zombie017";
        }
        else if ((nHunter == 1) && (nHUN == FALSE) && (Random(60) == 1))
        {
            sType = "dh_hunter1";
        }
        else if ((nLeaper == 1) && (nLEP == FALSE) && (Random(60) == 1))
        {
            sType = "dh_hunter004";
        }
        else if ((nGLeaper == 1) && (nLEP2 == FALSE) && (Random(60) == 1))
        {
            sType = "dh_hunter005";
        }
        else
        {
            // Set sType to the resref of the zombies to be created
            int nWhich = Random(12);
            sType = "zn_zombie0";
            if (nWhich < 10)
            {
                sType = sType + "0" + IntToString(nWhich);
            }
            else
            {
                sType = sType + IntToString(nWhich);
            }
        }
        // Now create the zombie at the waypoint
        object oZomb = CreateObject(OBJECT_TYPE_CREATURE,sType,lSpot);

        //Spawn surprise round so zombies don't automurder
        SpawnSurprise(oZomb);

        // Force zombie to move away from his spawn location by the use of WalkGuide placeables
        RandomWalkItOut(oZomb, "WalkGuide", 5.0f);

        // Set "finishcreate" to 1 on the zombie - Possibly used in other scripts???
        DelayCommand(5.0, SetLocalInt(oZomb,"finishcreate",1));
    }
}
