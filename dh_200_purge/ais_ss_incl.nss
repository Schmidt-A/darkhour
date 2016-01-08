//Event based spawn system: if no event preselected fire random event


//configs
const int AISS_DEBUG_MESSAGES = 0;

const int AISS_ENABLE_RANDOM_AREA_EVENTS = 0;//uncompleted feature, do not enable

const float fAISS_DELAYED_CLEAN = 60.0;
//configure loot deletion
const string LOOT_TAG = "Bodybag";
//if the loot doesn't destroy automagically, this can handle for you
const int DESTROY_LOOT_OBJECT = FALSE;

//Area events
//fill area with wandering mobs
const int AISS_WANDERING_MOB_EVENT = 3001;
const int AISS_FIXED_MOB_EVENT = 3002;
const int AISS_RANDOM_PLACED_TRAPS = 3003;
const int AISS_FIXED_PLACED_TRAPS = 3004;
const int AISS_RANDOM_PLACEABLES_EVENT = 3005;
const int AISS_FIXED_PLACEABLES_EVENT = 3006;




/*thanks to kesda for writing these two*/

void DebugMessage(string message)
{
    if(AISS_DEBUG_MESSAGES)
        SendMessageToPC(GetFirstPC(),message);
}

int AISS_TranslateEvent(string sEvent)
{
    if(sEvent=="wandering")
        return AISS_WANDERING_MOB_EVENT;
    else if(sEvent=="fixed")
        return AISS_FIXED_MOB_EVENT;
    else if(sEvent=="rp_traps")
        return AISS_RANDOM_PLACED_TRAPS;
    else if(sEvent=="fp_traps")
        return AISS_FIXED_PLACED_TRAPS;
    else if(sEvent=="rp_plac")
        return AISS_RANDOM_PLACEABLES_EVENT;
    else if(sEvent=="fp_plac")
        return AISS_FIXED_PLACEABLES_EVENT;
    else
        return AISS_WANDERING_MOB_EVENT;
}

int AISS_GetRandomEvent()
{
    return AISS_WANDERING_MOB_EVENT;
}

location RandomLoc(object oArea=OBJECT_SELF, int bFeedback=FALSE)
{
   // First, let's get area size
   float fAreaH = IntToFloat(GetAreaSize(AREA_HEIGHT, oArea));
   float fAreaW = IntToFloat(GetAreaSize(AREA_WIDTH, oArea));

   // Then let's get the maximum allowed area size
   // which we'll be using to calculate the random location
   // using a dice instead of the Random function
   float fMaxAreaSizeH = 32.0;
   float fMaxAreaSizeW = 32.0;

   // Then let's get the scale of the current area for both dimensions,
   // compared to the max allowed size
   float fScaleAreaH = fMaxAreaSizeH/fAreaH;
   float fScaleAreaW = fMaxAreaSizeW/fAreaW;

   // Now let's calculate a random location on a virtual 32*32 area.
   // The calculation might seem complex, but it is necessary to ensure that
   // all values between 1 and 320 have the same chance to be returned
   float fXLoc32 = IntToFloat( ((d8()-1)*4 + (d4()-1))*10 + d10() );
   float fYLoc32 = IntToFloat( ((d8()-1)*4 + (d4()-1))*10 + d10() );

   // Now let's convert the location from the virtual 32*32 area into values that fit
   // inside the current area
   float fXLoc = fXLoc32/fScaleAreaW;
   float fYLoc = fYLoc32/fScaleAreaH;

   // alright good so far, let's make it a vector..
   vector vPosition = Vector(fXLoc, fYLoc, 0.0f);

   // Let's get a random orientation between 0 and 359 degrees
   float fOrientation = IntToFloat( ((d6()-1)*6 +(d6()-1))*10 + (d10()-1) );

   // some feedback for testing purposes. GetFirstPC() will need to be replaced
   // if used in a multiplayer environment
   if (bFeedback)
   {
      DelayCommand(0.1, FloatingTextStringOnCreature("X axis position in the 32*32 virtual area = " + FloatToString(fXLoc32, 5, 2), GetFirstPC()));
      DelayCommand(0.1, FloatingTextStringOnCreature("Y axis position in the 32*32 virtual area = " + FloatToString(fYLoc32, 5, 2), GetFirstPC()));
      DelayCommand(0.3, FloatingTextStringOnCreature("X axis scale compared to the 32*32 virtual area = " + FloatToString(fScaleAreaW, 5, 2), GetFirstPC()));
      DelayCommand(0.3, FloatingTextStringOnCreature("Y axis scale compared to the 32*32 virtual area = " + FloatToString(fScaleAreaH, 5, 2), GetFirstPC()));
      DelayCommand(0.5, FloatingTextStringOnCreature("X axis position in the current area = " + FloatToString(fXLoc, 5, 2), GetFirstPC()));
      DelayCommand(0.5, FloatingTextStringOnCreature("Y axis position in the current area = " + FloatToString(fYLoc, 5, 2), GetFirstPC()));
      DelayCommand(0.7, FloatingTextStringOnCreature("Orientation = " + FloatToString(fOrientation, 5, 2), GetFirstPC()));
   }

   return Location(oArea, vPosition , fOrientation);

}



//type: acid, acid_splash, electrical, fire, frost, gas, holy,
//        negative, sonic, spike, tangle
//level: minor,avarage,strong,deadly,epic

int AISS_TranslateTraps(string trap_type,string trap_level)
{
    if(trap_type == "acid")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_ACID;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_ACID;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_ACID;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_ACID;
        else
            return TRAP_BASE_TYPE_MINOR_ACID;
    }
    else if(trap_type == "acid_splash")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_ACID_SPLASH;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_ACID_SPLASH;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_ACID_SPLASH;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_ACID_SPLASH;
        else
            return TRAP_BASE_TYPE_MINOR_ACID_SPLASH;
    }
    else if(trap_type == "electrical")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_ELECTRICAL;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_ELECTRICAL;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_ELECTRICAL;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_ELECTRICAL;
        else if (trap_level=="epic")
            return TRAP_BASE_TYPE_EPIC_ELECTRICAL;
        else
            return TRAP_BASE_TYPE_MINOR_ELECTRICAL;
    }
    else if(trap_type == "fire")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_FIRE;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_FIRE;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_FIRE;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_FIRE;
        else if (trap_level=="epic")
            return TRAP_BASE_TYPE_EPIC_FIRE;
        else
            return TRAP_BASE_TYPE_MINOR_FIRE;
    }
    else if(trap_type == "frost")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_FROST;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_FROST;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_FROST;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_FROST;
        else if (trap_level=="epic")
            return TRAP_BASE_TYPE_EPIC_FROST;
        else
            return TRAP_BASE_TYPE_MINOR_FROST;
    }
    else if(trap_type == "gas")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_GAS;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_GAS;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_GAS;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_GAS;
        else
            return TRAP_BASE_TYPE_MINOR_GAS;
    }
    else if(trap_type == "holy")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_HOLY;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_HOLY;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_HOLY;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_HOLY;
        else
            return TRAP_BASE_TYPE_MINOR_HOLY;
    }
    else if(trap_type == "negative")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_NEGATIVE;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_NEGATIVE;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_NEGATIVE;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_NEGATIVE;
        else
            return TRAP_BASE_TYPE_MINOR_NEGATIVE;
    }
    else if(trap_type == "sonic")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_SONIC;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_SONIC;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_SONIC;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_SONIC;
        else if (trap_level=="epic")
            return TRAP_BASE_TYPE_EPIC_SONIC;
        else
            return TRAP_BASE_TYPE_MINOR_SONIC;
    }
    else if(trap_type == "spike")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_SPIKE;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_SPIKE;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_SPIKE;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_SPIKE;
        else
            return TRAP_BASE_TYPE_MINOR_SPIKE;
    }
    else if(trap_type == "tangle")
    {
        if(trap_level=="minor")
            return TRAP_BASE_TYPE_MINOR_TANGLE;
        else if (trap_level=="avarage")
            return TRAP_BASE_TYPE_AVERAGE_TANGLE;
        else if (trap_level=="strong")
            return TRAP_BASE_TYPE_STRONG_TANGLE;
        else if (trap_level=="deadly")
            return TRAP_BASE_TYPE_DEADLY_TANGLE;
        else
            return TRAP_BASE_TYPE_MINOR_TANGLE;
    }
    else return TRAP_BASE_TYPE_MINOR_FIRE;
}



//sAISS_resref_group_i = blueprint of i-th spawn group
//iAISS_size_group_i = number of monsters of the i-th blueprint
//bAISS_randomize = randomize monsters group size, from 1 to ais_number_group_i
void AISS_WanderingMonsters(object oArea = OBJECT_SELF)
{
    int i = 1, j = 0;
    int bRandomize = GetLocalInt(oArea,"bAISS_randomize");
    while (GetLocalString(oArea,"sAISS_resref_group_"+IntToString(i))!="")
        i++;
    int iMobGroups = i-1;

    DebugMessage("AISS_WanderingMonsters: found "+IntToString(iMobGroups)+" mob groups");
    for(i=1;i<=iMobGroups;i++)
        DebugMessage("AISS_WanderingMonsters: Group "+IntToString(i)+" resref: "+
            GetLocalString(oArea,"sAISS_resref_group_"+IntToString(i)) + " size: " +
            IntToString(GetLocalInt(oArea,"iAISS_size_group_"+IntToString(i))));

    object oSpawn;
    for(i=1;i<=iMobGroups;i++)
        for(j=0;j<(bRandomize>0?Random(GetLocalInt(oArea,"iAISS_size_group_"+IntToString(i)))+1:GetLocalInt(oArea,"iAISS_size_group_"+IntToString(i)));j++)
        {
            oSpawn = CreateObject(OBJECT_TYPE_CREATURE,GetLocalString(oArea,"sAISS_resref_group_"+IntToString(i)),RandomLoc(oArea));
            SetLocalInt(oSpawn,"bAISS_spawned_mob",1);
            AssignCommand(oSpawn,ActionRandomWalk());
        }
}

//sAISS_plac_resref_group_i
//iAISS_plac_size_group_i

void AISS_RandomPlaceables(object oArea = OBJECT_SELF)
{
    int i = 1, j = 0;
    int bRandomize = GetLocalInt(oArea,"bAISS_randomize");
    while (GetLocalString(oArea,"sAISS_plac_resref_group_"+IntToString(i))!="")
        i++;
    int iPlacGroups = i-1;

    DebugMessage("AISS_RandomPlaceables: found "+IntToString(iPlacGroups)+" placeables groups");
    for(i=1;i<=iPlacGroups;i++)
        DebugMessage("AISS_RandomPlaceables: Group "+IntToString(i)+" resref: "+
            GetLocalString(oArea,"sAISS_plac_resref_group_"+IntToString(i)) + " size: " +
            IntToString(GetLocalInt(oArea,"iAISS_plac_size_group_"+IntToString(i))));

    object oPlac;
    for(i=1;i<=iPlacGroups;i++)
        for(j=0;j<(bRandomize>0?Random(GetLocalInt(oArea,"iAISS_plac_size_group_"+IntToString(i)))+1:GetLocalInt(oArea,"iAISS_plac_size_group_"+IntToString(i)));j++)
        {
            oPlac = CreateObject(OBJECT_TYPE_PLACEABLE,GetLocalString(oArea,"sAISS_plac_resref_group_"+IntToString(i)),RandomLoc(oArea));
            SetLocalInt(oPlac,"bAISS_spawned_plac",1);
        }
}


void AISS_FixedMonsters(object oArea = OBJECT_SELF)
{
     int i = 1, j = 0;
     int spawns = 0;
     int iMobGroups;
     int bRandomize=0;
     //let's find area waypoints and populate them
     object obj = GetObjectByTag("aiss_spawn_"+GetTag(oArea));
     while (GetIsObjectValid(obj))
     {

            //iAISS_resref_group_i = i-th blueprint
            //iAISS_size_group_i = i-th blueprint spawns

            //find spawn composition
            while (GetLocalString(obj,"sAISS_resref_group_"+IntToString(i))!="")
                i++;
            iMobGroups = i-1;



            object oSpawn;
            for(i=1;i<=iMobGroups;i++)
                for(j=0;j<(bRandomize>0?Random(GetLocalInt(obj,"iAISS_size_group_"+IntToString(i)))+1:GetLocalInt(obj,"iAISS_size_group_"+IntToString(i)));j++)
                {
                    oSpawn = CreateObject(OBJECT_TYPE_CREATURE,GetLocalString(obj,"sAISS_resref_group_"+IntToString(i)),GetLocation(obj));
                    SetLocalInt(oSpawn,"bAISS_spawned_mob",1);
                    AssignCommand(oSpawn,ActionRandomWalk());
                }
            //reset conunters
            iMobGroups = 0;
            i=1;
            j=0;

        obj = GetObjectByTag("aiss_spawn_"+GetTag(oArea),++spawns);
     }
}

//iAISS_plac_resref_group_i = i-th blueprint
//iAISS_plac_size_group_i = i-th blueprint spawns

void AISS_FixedPlaceablesGroup(object oArea = OBJECT_SELF)
{
     int i = 1, j = 0;
     int plac = 0;
     int iPlacGroups;
     int bRandomize=0;
     //let's find area waypoints and populate them
     object obj = GetObjectByTag("aiss_plac_spawn_"+GetTag(oArea));
     while (GetIsObjectValid(obj))
     {
            DebugMessage("AISS_FixedPlaceablesGroup: found placeable waypoint");
            //find spawn composition
            while (GetLocalString(obj,"sAISS_plac_resref_group_"+IntToString(i))!="")
                i++;
            iPlacGroups = i-1;

            DebugMessage("AISS_RandomPlaceables: found "+IntToString(iPlacGroups)+" placeables in waypoint");

            object oSpawn;
            for(i=1;i<=iPlacGroups;i++)
                for(j=0;j<(bRandomize>0?Random(GetLocalInt(obj,"iAISS_plac_size_group_"+IntToString(i)))+1:GetLocalInt(obj,"iAISS_plac_size_group_"+IntToString(i)));j++)
                {
                    oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE,GetLocalString(obj,"sAISS_plac_resref_group_"+IntToString(i)),GetLocation(obj));
                    SetLocalInt(oSpawn,"bAISS_spawned_plac",1);
                }
            //reset conunters
            iPlacGroups = 0;
            i=1;
            j=0;

        obj = GetObjectByTag("aiss_plac_spawn_"+GetTag(oArea),++plac);
     }
}


//sAISS_trap_group_type_i: i-th trap type, and type is one of those specified by TranslateTraps
//sAISS_trap_group_level_i: i-th trap level, and level is one of those specified by TranslateTraps
//iAISS_trap_group_size_i: how many traps of i-th resref to place
//fAISS_trap_group_covered_area_i: how large is trap area of effect
//bAISS_trap_group_not_detectable_i: 1 if trap group is not detectable, default 0;
//iAISS_trap_group_detect_dc_i: if detectable, set detect DC, if 0 default trap DC will be used
//bAISS_trap_group_not_disarmable_i: 1 if trap group is not disarmable, default 0;
//bAISS_trap_group_disarm_dc_i: if disarmable, set disarm DC, if 0 default trap DC will be used
//sAISS_trap_group_keytag_i: if set, key with this tag will disarm i-th trap group
//bAISS_trap_group_not_recoverable_i: if set to 1, i-th group trap will not be recoverable
//sAISS_trap_group_disarm_i: script to be associated onDisarm to i-th trap group
//sAISS_trap_group_triggered_i: script to be associated onTrapTriggered to i-th trap group

void AISS_RandomPlacedTraps(object oArea = OBJECT_SELF)
{
    int i = 1, j = 0;
    int bRandomize = GetLocalInt(oArea,"bAISS_randomize");
    while (GetLocalString(oArea,"sAISS_trap_group_type_"+IntToString(i))!="")
        i++;
    int iTrapGroups = i-1;

    DebugMessage("AISS_RandomPlacedTraps: found "+IntToString(iTrapGroups)+" trap groups");

    object oTrap;
    int iTrapCostant;
    for(i=1;i<=iTrapGroups;i++)
    {
        iTrapCostant = AISS_TranslateTraps(
            GetLocalString(oArea,"sAISS_trap_group_type_"+IntToString(i)),
            GetLocalString(oArea,"sAISS_trap_group_level_"+IntToString(i)));

        for(j=0;j<(bRandomize>0?Random(GetLocalInt(oArea,"iAISS_trap_group_size_"+IntToString(i)))+1:GetLocalInt(oArea,"iAISS_trap_group_size_"+IntToString(i)));j++)
        {
            DebugMessage("AISS_RandomPlacedTraps: placing "+
                            GetLocalString(oArea,"sAISS_trap_group_type_"+IntToString(i))+" "+
                            GetLocalString(oArea,"sAISS_trap_group_level_"+IntToString(i))+"trap.");
            oTrap = CreateTrapAtLocation(iTrapCostant,
                        RandomLoc(oArea), //where
                        IntToFloat(Random(5)+1), //physical_size
                        "ais_rp_trap"+IntToString(i), //tag
                        STANDARD_FACTION_HOSTILE, //faction
                        GetLocalString(oArea,"sAISS_trap_group_disarm_"+IntToString(i)),
                        GetLocalString(oArea,"sAISS_trap_group_triggered_"+IntToString(i)));
            SetTrapActive(oTrap);
            if(GetLocalInt(oArea,"bAISS_trap_group_not_detectable_"+IntToString(i))>0)
                SetTrapDetectable(oTrap,FALSE);
            if(GetTrapDetectable(oTrap)&&GetLocalInt(oArea,"iAISS_trap_group_detect_dc_"+IntToString(i))>0)
                SetTrapDetectDC(oTrap,GetLocalInt(oArea,"iAISS_trap_group_detect_dc_"+IntToString(i)));
            if(GetLocalInt(oArea,"bAISS_trap_group_not_disarmable_"+IntToString(i))>0)
                SetTrapDisarmable(oTrap,FALSE);
            if(GetTrapDisarmable(oTrap)&&GetLocalInt(oArea,"iAISS_trap_group_disarm_dc_"+IntToString(i))>0)
                SetTrapDisarmDC(oTrap,GetLocalInt(oArea,"iAISS_trap_group_disarm_dc_"+IntToString(i)));
            if(GetLocalString(oArea,"sAISS_trap_group_keytag_"+IntToString(i))!="")
                SetTrapKeyTag(oTrap,GetLocalString(oArea,"sAISS_trap_group_keytag_"+IntToString(i)));
            if(GetLocalInt(oArea,"bAISS_trap_group_not_recoverable_"+IntToString(i))>0)
                SetTrapRecoverable(oTrap,FALSE);
            SetLocalInt(oTrap,"bAISS_spawned_trap",1);
        }
    }
}

//sAISS_trap_type: i-th trap type, and type is one of those specified by TranslateTraps
//sAISS_trap_level: i-th trap level, and level is one of those specified by TranslateTraps
//fAISS_trap_covered_area: how large is trap area of effect, min 1.0
//bAISS_trap_not_detectable: 1 if trap is not detectable, default 0;
//iAISS_trap_detect_dc: if detectable, set detect DC, if 0 default trap DC will be used
//bAISS_trap_not_disarmable: 1 if trap is not disarmable, default 0;
//bAISS_trap_disarm_dc: if disarmable, set disarm DC, if 0 default trap DC will be used
//sAISS_trap_keytag: if set, key with this tag will disarm i-th trap
//bAISS_trap_not_recoverable: if set to 1, i-th group trap will not be recoverable
//sAISS_trap_disarm: script to be associated onDisarm to i-th trap
//sAISS_trap_triggered: script to be associated onTrapTriggered to i-th trap group

void AISS_FixedPlacedTraps(object oArea = OBJECT_SELF)
{
    int i = 1;
    int traps = 0;
    int bRandomize=0;
    //let's find area waypoints and populate them

    object oTrap;
    int iTrapCostant;

    object obj = GetObjectByTag("aiss_trap_spawn_"+GetTag(oArea));
    while (GetIsObjectValid(obj))
    {
        iTrapCostant = AISS_TranslateTraps(
            GetLocalString(obj,"sAISS_trap_type"),
            GetLocalString(obj,"sAISS_trap_level"));

        oTrap = CreateTrapAtLocation(iTrapCostant,
                    GetLocation(obj), //where
                    GetLocalFloat(obj,"fAISS_trap_covered_area")>1.0?GetLocalFloat(obj,"fAISS_trap_covered_area"):1.0, //physical_size
                    "ais_fp_trap"+IntToString(traps), //tag
                    STANDARD_FACTION_HOSTILE, //faction
                    GetLocalString(oArea,"sAISS_trap_disarm_"+IntToString(i)),
                    GetLocalString(oArea,"sAISS_trap_triggered"));
        SetTrapActive(oTrap);
        if(GetLocalInt(obj,"bAISS_trap_not_detectable")>0)
            SetTrapDetectable(oTrap,FALSE);
        if(GetTrapDetectable(oTrap)&&GetLocalInt(obj,"iAISS_trap_detect_dc_"+IntToString(i))>0)
            SetTrapDetectDC(oTrap,GetLocalInt(obj,"iAISS_trap_detect_dc_"+IntToString(i)));
        if(GetLocalInt(obj,"bAISS_trap_not_disarmable_"+IntToString(i))>0)
            SetTrapDisarmable(oTrap,FALSE);
        if(GetTrapDisarmable(oTrap)&&GetLocalInt(obj,"iAISS_trap_disarm_dc")>0)
            SetTrapDisarmDC(oTrap,GetLocalInt(obj,"iAISS_trap_disarm_dc"));
        if(GetLocalString(obj,"sAISS_trap_keytag")!="")
            SetTrapKeyTag(oTrap,GetLocalString(obj,"sAISS_trap_keytag"));
        if(GetLocalInt(obj,"bAISS_trap_not_recoverable")>0)
            SetTrapRecoverable(oTrap,FALSE);
        SetLocalInt(oTrap,"bAISS_spawned_trap",1);

        obj = GetObjectByTag("aiss_trap_spawn_"+GetTag(oArea),++traps);
    }
}

void AISS_HandleAreaEvents(object oArea = OBJECT_SELF)
{
    switch (GetUserDefinedEventNumber())
     {
          case AISS_WANDERING_MOB_EVENT:
               AISS_WanderingMonsters(oArea);
               break;
          case AISS_FIXED_MOB_EVENT:
               AISS_FixedMonsters(oArea);
               break;
          case AISS_RANDOM_PLACED_TRAPS:
               AISS_RandomPlacedTraps(oArea);
               break;
          case AISS_FIXED_PLACED_TRAPS:
               AISS_FixedPlacedTraps(oArea);
               break;
          case AISS_RANDOM_PLACEABLES_EVENT:
               AISS_RandomPlaceables(oArea);
               break;
          case AISS_FIXED_PLACEABLES_EVENT:
               AISS_FixedPlaceablesGroup(oArea);
               break;
     }
}

int AISSS_GetAreaCurrentPlayersNumber(object oArea)
{
    return GetLocalInt(oArea,"iAISS_PCs_onarea");
}

void AISSS_ClearArea(object oArea = OBJECT_SELF)
{
    //how to clean up everything ;-)
    DebugMessage("AISSS_ClearArea launched!");
    int i = 1, j = 0;

    //no clean way to avoid, must cycle through all area objects
    object oObj = GetFirstObjectInArea(oArea);
    object oLootItem;
    while (GetIsObjectValid(oObj))
    {
        if(GetLocalInt(oObj,"bAISS_spawned_mob") ||
            GetLocalInt(oObj,"bAISS_spawned_trap") ||
            GetLocalInt(oObj,"bAISS_spawned_plac"))
            DestroyObject(oObj);
        //NOTE: the loot tag should be different from creature tag!
        else if(GetTag(oObj)== LOOT_TAG)
        {
            oLootItem = GetFirstItemInInventory(oObj);
            while (GetIsObjectValid(oLootItem))
            {
                //safedestroy
                DestroyObject(oLootItem);
                oLootItem = GetNextItemInInventory();
            }

            //all inventory destroyed, destroy oLoot if required
            if(DESTROY_LOOT_OBJECT)
                DestroyObject(oObj);
        }
        //Here can be added nice things, like deleting items dropped on ground
        //by PGs

        oObj = GetNextObjectInArea(oArea);
    }
    SetLocalInt(OBJECT_SELF,"iAISS_area_inited",0);
    DebugMessage("AISSS_ClearArea: area reset successfully!");
}

void AISSS_CheckClearArea(object oArea = OBJECT_SELF)
{
    if(GetLocalInt(OBJECT_SELF,"iAISS_PCs_onarea")==0 && GetLocalInt(OBJECT_SELF,"bAISS_delayed_clean") && GetLocalInt(OBJECT_SELF,"iAISS_area_inited"))
         AISSS_ClearArea();
}

void AISSS_OnAreaEnter(){
    object oPC=GetEnteringObject();
    if(GetIsPC(oPC)){
        SetLocalInt(OBJECT_SELF,"iAISS_PCs_onarea",1 + GetLocalInt(OBJECT_SELF,"iAISS_PCs_onarea"));
        SetLocalInt(OBJECT_SELF,"bAISS_delayed_clean",0);
        if(GetLocalInt(OBJECT_SELF,"iAISS_PCs_onarea")==1 && GetLocalInt(OBJECT_SELF,"iAISS_area_inited")==0){
            SetLocalInt(OBJECT_SELF,"iAISS_area_inited",1);
            if(GetLocalInt(OBJECT_SELF,"iAISS_selectedEvent")>0)
            {
                int i=1;
                for(i;i<=GetLocalInt(OBJECT_SELF,"iAISS_selectedEvent");i++)
                    SignalEvent(OBJECT_SELF, EventUserDefined(AISS_TranslateEvent(GetLocalString(OBJECT_SELF,"sAISS_selectedEvent_"+IntToString(i)))));
            }
            else if(AISS_ENABLE_RANDOM_AREA_EVENTS)
                SignalEvent(OBJECT_SELF, EventUserDefined(AISS_GetRandomEvent()));
            else
                SignalEvent(OBJECT_SELF, EventUserDefined(AISS_WANDERING_MOB_EVENT));
        }
    }

}

void AISSS_OnAreaExit(){
    object oPC=GetExitingObject();
    if(GetIsPC(oPC)){
        SetLocalInt(OBJECT_SELF,"iAISS_PCs_onarea",-1+GetLocalInt(OBJECT_SELF,"iAISS_PCs_onarea"));
    }
    if(GetLocalInt(OBJECT_SELF,"iAISS_PCs_onarea")==0)
    {
        if(!GetLocalInt(OBJECT_SELF,"bAISS_delayed_clean"))
        {
            SetLocalInt(OBJECT_SELF,"bAISS_delayed_clean",1);
            DelayCommand(fAISS_DELAYED_CLEAN,AISSS_CheckClearArea());
        }
    }
}

//void main() {}

