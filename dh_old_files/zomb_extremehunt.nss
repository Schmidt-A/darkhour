//Siranda Spawner. Grants a +6 Bonus to Str, Dex, and Con. Use in areas far from
//Sispara.

// This script is called from the OnHeartbeat of different placeables in all of the old-world Ronin-made
// areas.
// Created by Ronin_DM on Unknown
// Commenting by Zunath on July 22, 2007
// This applies to Zombie (Hunter)s. - Phosphorus

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
    int nBAT = FALSE;
    // Effects to apply to the zombies
    effect eHaste = EffectHaste();
    effect eSpot = EffectSkillIncrease(SKILL_SPOT,10);
    effect eListen = EffectSkillIncrease(SKILL_LISTEN,10);
    effect eAnger = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);

    // Cycle through the area looking at all objects and if they are zombies, behemoths
    // or specified waypoints, take the following actions
    object oObj = GetFirstObjectInArea();
    while (oObj != OBJECT_INVALID)
    {
        // If the current object is a zombie do this
        if (GetStringLeft(GetTag(oObj),9) == "dh_hunter")
        {
            // Increase the current number of zombies
            nZNum += 1;

            // If it's a behemoth, set nBAT to true
            if (GetTag(oObj) == "dh_hunter")
            {
                nBAT = TRUE;
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
            sType = "dh_hunter1";
        }
        else
        {
            // Set sType to the resref of the zombies to be created
            int nWhich = Random(12);
            sType = "dh_hunter";
            if (nWhich < 10)
            {
                sType = "dh_hunter1";
            }
            else
            {
                sType = "dh_hunter1";
            }
        }
        // Now create the zombie at the waypoint
        object oZomb = CreateObject(OBJECT_TYPE_CREATURE,sType,lSpot);
        //Apply Buffs
        object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oZomb);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,d2(8)),oSkin);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,d2(6)),oSkin);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,d2(8)),oSkin);

        // Force zombie to move away from his spawn location by the use of WalkGuide placeables
        location lGetOut = GetLocation(GetNearestObjectByTag("WalkGuide",oZomb));
        AssignCommand( oZomb, ActionMoveToLocation(lGetOut) );
        DelayCommand(5.0, AssignCommand( oZomb, ActionRandomWalk()));

        // Set "finishcreate" to 1 on the zombie - Possibly used in other scripts???
        DelayCommand(5.0, SetLocalInt(oZomb,"finishcreate",1));
    }
}
