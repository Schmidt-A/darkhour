/* Intention of this script is to be used in unique areas where we want to 
 * spawn something other than our usual zombies.
 * It's still using the placeable-bases spawning, so this script should go
 * on a zombie spawner placeable heartbeat.
 *
 * The following variables need to be set on the zombie spawner placeable:
 * string sWPTag = tag of the waypoints that you want creatures to spawn at
 * string sBosResRef = if you have a boss baddie that you want to (sometimes)
 *                     spawn in your area, provide its RESREF (not tag) here
 * string sCreature1Ref = resref of the regular creature you want to spawn
 * string sCreature2Ref = resref of an (optional) second variation of creature
 *                        to spawn. If this is provided there's a 50-50 chance
 *                        this creature will spawn over sCreature1. Otherwise
 *                        only sCreature1s will be spawned.
 *
 * We can definitely do this better with a redone system but for now, we
 * can use this to get vault areas operational quickly. */

void main()
{
    int iNumEnemies = 0; // Current number of zombies
    int iNumWPs = 0; // Current number of waypoints

    // Waypoint tags to spawn the zombies at
    string sWTag = GetLocalString(OBJECT_SELF,"sWPTag");

    int iMaxEnemies = GetLocalInt(OBJECT_SELF,"iMaxEnemies");

    string sBossResRef = GetLocalString(OBJECT_SELF, "sBoss");
    int bBossSpawned = FALSE;

    string sCreature1Ref = GetLocalString(OBJECT_SELF, "sCreature1");
    string sCreature2Ref = GetLocalString(OBJECT_SELF, "sCreature2");

    // Take a count on the enemies/WPs in the area
    object oObj = GetFirstObjectInArea();
    string sCurRef;
    while(oObj != OBJECT_INVALID)
    {
        sCurRef = GetResRef(oObj);

        if(sCurRef == sBossResRef || sCurRef == sCreature1Ref ||
           sCurRef == sCreature2Ref)
        {
            iNumEnemies += 1;
            if (sCurRef == sBossResRef)
                bBossSpawned = TRUE;
        }
        // If it's a waypoint, up our waypoint count
        else if (GetTag(oObj) == sWTag)
            iNumWPs += 1;

        oObj = GetNextObjectInArea();
    }

    // Nothing more to do if we don't have to spawn anything
    if(iNumEnemies >= iMaxEnemies)
        return;

    // Spawn another enemy if we don't have enough
    location lSpawnPoint = GetLocation(GetObjectByTag(sWTag, Random(iNumWPs)));
    string sType;

    // Spawn a boss (maybe?) if there's none in the area
    if (sBossResRef != "" && (bBossSpawned == FALSE) && (Random(60) == 1))
        sType = sBossResRef;
    // Otherwise figure out what sort of creature to spawn
    else
    {
        sType = sCreature1Ref;
        if(sCreature2Ref != "")
        {
            int iRandom = Random(100)+1;
            // 50-50 chance of creating one creature over the other.
            if(iRandom > 50)
                sType = sCreature2Ref;
        }
    }

    // Now create the creature at the waypoint
    object oZomb = CreateObject(OBJECT_TYPE_CREATURE, sType, lSpawnPoint);

    // Force creature to move away from his spawn location by the use of WalkGuide placeables
    location lWalk = GetLocation(GetNearestObjectByTag("WalkGuide",oZomb));
    AssignCommand(oZomb, ActionMoveToLocation(lWalk));
    DelayCommand(5.0, AssignCommand(oZomb, ActionRandomWalk()));

    /* I think this gets used to make sure the zombie is destroyed if it
     * follows a player into a different area. */
    DelayCommand(5.0, SetLocalInt(oZomb,"finishcreate",1));
}
