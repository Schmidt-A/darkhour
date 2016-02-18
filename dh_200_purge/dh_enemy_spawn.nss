/* This script is meant to replace our normal spawning scripts. It will spawn zombies based on demographics.
 * It's still using the placeable-bases spawning, so this script should go
 * on a zombie spawner placeable heartbeat.
 *
 * The following variables need to be set on the zombie spawner placeable:
 * int    iMaxEnemies = numeric cap on how many enemies should spawn at a given
 *                      time.
 * string sWPTag = tag of the waypoints that you want creatures to spawn at
 * string sCreatureXRef = Resref of the creature you want to spawn
 * string sCreatureXChance = spawn percentage of the creature you want to spawn
 */

 #include "_incl_probability"
 #include "_incl_enemies"

void main()
{
    int iNumEnemies = 0; // Current number of monsters
    int iNumWPs = 0; // Current number of waypoints

    // Waypoint tags to spawn the zombies at
    string sWTag = GetLocalString(OBJECT_SELF,"sWPTag");

    int iMaxEnemies = GetLocalInt(OBJECT_SELF,"iMaxEnemies");

    // Take a count on the enemies/WPs in the area
    object oObj = GetFirstObjectInArea();
    string sCurRef;
    while(oObj != OBJECT_INVALID)
    {
        sCurRef = GetResRef(oObj);

        //This should be refactored, it's inefficient - Aez (2/16/16)
        if (LocalContains(OBJECT_SELF, sCurRef))
            iNumEnemies += 1;
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

    object oZomb = FindRandomRef(OBJECT_SELF, OBJECT_TYPE_CREATURE, OBJECT_SELF, lSpawnPoint);    

    //Do we want to apply buffs this way? Maybe with local vars?
    //or maybe 
    //BuffEnemy(oZomb, GetItemInSlot(INVENTORY_SLOT_CARMOUR,oZomb), 3, 2, 4);

    //Spawn surprise round so zombies don't automurder
    SpawnSurprise(oZomb);

    // Force zombie to move away from his spawn location by the use of WalkGuide placeables
    RandomWalkItOut(oZomb, "WalkGuide", 5.0f);

    /* I think this gets used to make sure the zombie is destroyed if it
     * follows a player into a different area. */
    DelayCommand(5.0, SetLocalInt(oZomb,"finishcreate",1));
}
