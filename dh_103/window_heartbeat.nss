void main()
{
    int iBreakInTime = GetLocalInt(OBJECT_SELF, "BreakInTime");
    int iBarricade = GetLocalInt(OBJECT_SELF, "Barricade");
    // Get the number of PCs currently in the area
    int iPCInArea = GetLocalInt(GetArea(OBJECT_SELF), "PCInArea");
    int iZombiesToSpawn;

    // If there's no PC in the area, just stop here.
    if (iPCInArea == 0) {return;}

    else if (iBarricade == 0 && iBreakInTime != 0)
    {
        iBreakInTime = iBreakInTime - 1;
        SetLocalInt(OBJECT_SELF, "BreakInTime", iBreakInTime);
    }

    else if (iBarricade == 0 && iBreakInTime == 0)
    {
        string sExtra0, sZombieResref;
        // Get the location of the nearest BreakIn_WP waypoint
        location lLocation = GetLocation(GetNearestObjectByTag("BreakIn_WP", OBJECT_SELF));
        // Reset the Break In Time
        SetLocalInt(OBJECT_SELF, "BreakInTime", 100);
        // Reset the Wood and Nails required
        SetLocalInt(OBJECT_SELF, "Wood", GetLocalInt(OBJECT_SELF, "WoodMax"));
        SetLocalInt(OBJECT_SELF, "Nails", GetLocalInt(OBJECT_SELF, "NailsMax"));

        int iCurrentZombie;

        // If the number of PCs in the area is 2-4, spawn 1 zombies
        if (iPCInArea > 1 && iPCInArea <= 4)
        {iZombiesToSpawn = 1;}
        // If the number of PCs in the area is 5-7, spawn 2 zombies
        else if (iPCInArea >= 5)
        {iZombiesToSpawn = 2;}

        // Plays a sound of glass breaking
        PlaySound("as_cv_glasbreak3");

        while (iZombiesToSpawn >= iCurrentZombie)
        {
            // There are 15 normal zombie types, so pick one of them.
            int iRandom = Random(15) + 1;

            if (iRandom < 10)
            {sExtra0 = "00";}
            // Otherwise, look for a tag with one 0.
            else if (iRandom > 9 && iRandom < 100)
            {sExtra0 = "0";}

            // Now we have our zombie picked out, let's set his resref
            sZombieResref = "zn_zombie" + sExtra0 + IntToString(iRandom);

            // Create the zombie at the nearest waypoint
            object oZombie = CreateObject(OBJECT_TYPE_CREATURE, sZombieResref, lLocation);
            // Knock the zombie down for 4.0 seconds, just so players can get ready to kill them
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oZombie, 4.0);
            iCurrentZombie = iCurrentZombie + 1;
        }
    }
    //SendMessageToPC(GetFirstPC(), "iBarricade: " + IntToString(iBarricade));  // DEBUG
    //SendMessageToPC(GetFirstPC(), "iBreakInTime: " + IntToString(iBreakInTime)); // DEBUG
    //SendMessageToPC(GetFirstPC(), "iZombiesToSpawn: " + IntToString(iZombiesToSpawn)); // DEBUG
    //SendMessageToPC(GetFirstPC(), "iPCInArea: " + IntToString(iPCInArea)); // DEBUG
}
