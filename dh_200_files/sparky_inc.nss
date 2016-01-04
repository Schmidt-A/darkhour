// --------------------------------------------------------
// sparky_inc         Sparky Spawner v2 include file
//
// original version by Sparky1479
// recode and expansion by Malishara
//
// 10/28/2009    Malishara: added SMS encounter type
// 10/29/2009    Malishara: added static encounter type
//                          added music encounter type
// 11/10/2009    Malishara: added disable encounter type
// 11/14/2009    Malishara: added equip and unequip encounter types
// 11/20/2009    Malishara: added ability to store encounters on,
//                          and spawn from, a trigger
// --------------------------------------------------------

#include "mali_string_fns"
#include "mcs_inc"
#include "x0_i0_position"
#include "dm_sm_inc"


int WhichSlot(string sSlot)
{   if (sSlot == "head")
    { return INVENTORY_SLOT_HEAD; }
    if (sSlot == "lefthand")
    { return INVENTORY_SLOT_LEFTHAND; }
    if (sSlot == "righthand")
    { return INVENTORY_SLOT_RIGHTHAND; }
    if (sSlot == "cloak")
    { return INVENTORY_SLOT_CLOAK; }
    if (sSlot == "arms")
    { return INVENTORY_SLOT_ARMS; }
    if (sSlot == "belt")
    { return INVENTORY_SLOT_BELT; }
    if (sSlot == "boots")
    { return INVENTORY_SLOT_BOOTS; }
    if (sSlot == "rightring")
    { return INVENTORY_SLOT_RIGHTRING; }
    if (sSlot == "leftring")
    { return INVENTORY_SLOT_LEFTRING; }
    if (sSlot == "arrows")
    { return INVENTORY_SLOT_ARROWS; }
    if (sSlot == "bolts")
    { return INVENTORY_SLOT_BOLTS; }
    if (sSlot == "bullets")
    { return INVENTORY_SLOT_BULLETS; }
    if ((sSlot == "neck") || (sSlot == "necklace") || (sSlot == "amulet"))
    { return INVENTORY_SLOT_NECK; }
    if ((sSlot == "chest") || (sSlot == "armor") || (sSlot == "torso"))
    { return INVENTORY_SLOT_CHEST; }

    return -1;
}

object FindSMSWidget(string sSMS_Crate, string sName)
{   object oSMS_Crate = GetObjectByTag(sSMS_Crate);
    if (!GetIsObjectValid(oSMS_Crate)) { return OBJECT_INVALID; }

    object oSMS = GetFirstItemInInventory(oSMS_Crate);

    int iLoop = TRUE;

    while (iLoop)
    {   if (!GetIsObjectValid(oSMS))
        { iLoop = FALSE; }
        else if (GetStringLowerCase(sName) == GetStringLowerCase(SearchAndReplace(SearchAndReplace(GetName(oSMS), ",", ""), " ", "")))
        { iLoop = FALSE; }
        else
        { oSMS = GetNextItemInInventory(oSMS_Crate); }
    }

    return oSMS;
}

int ProcessTrapType(string sTrapType)
{   string sTrapStrength = FirstWord(sTrapType, " ");
    string sTrapDamageType = RestWords(sTrapType, " ");

    int iStrength = 0;

    if (sTrapStrength == "random")
    { switch (Random(5))
      { case 0:
          sTrapStrength = "minor"; break;
        case 1:
          sTrapStrength = "average"; break;
        case 2:
          sTrapStrength = "strong"; break;
        case 3:
          sTrapStrength = "deadly"; break;
        case 4:
          sTrapStrength = "epic"; break;
      }
    }

    if (sTrapStrength == "epic")
    { if ((sTrapDamageType == "electrical") || (sTrapDamageType == "electric") || (sTrapDamageType == "elec"))
      { return 44; }
      if (sTrapDamageType == "fire")
      { return 45; }
      if (sTrapDamageType == "frost")
      { return 46; }
      if (sTrapDamageType == "sonic")
      { return 47; }
      return Random(4) + 44;
    }

    if (sTrapStrength == "minor")
    { iStrength = 0; }
    else if (sTrapStrength == "average")
    { iStrength = 1; }
    else if (sTrapStrength == "strong")
    { iStrength = 2; }
    else if (sTrapStrength == "deadly")
    { iStrength = 3; }

    if (sTrapDamageType == "spike")
    { return iStrength + 0; }
    else if (sTrapDamageType == "holy")
    { return iStrength + 4; }
    else if (sTrapDamageType == "tangle")
    { return iStrength + 8; }
    else if (sTrapDamageType == "acid")
    { return iStrength + 12; }
    else if (sTrapDamageType == "fire")
    { return iStrength + 16; }
    else if ((sTrapDamageType == "electrical") || (sTrapDamageType == "electric") || (sTrapDamageType == "elec"))
    { return iStrength + 20; }
    else if (sTrapDamageType == "gas")
    { return iStrength + 24; }
    else if (sTrapDamageType == "frost")
    { return iStrength + 28; }
    else if (sTrapDamageType == "negative")
    { return iStrength + 32; }
    else if (sTrapDamageType == "sonic")
    { return iStrength + 36; }
    else if (sTrapDamageType == "acid splash")
    { return iStrength + 40; }
    else
    { return (Random(11) * 4) + iStrength; }

    return 0;
}

void ProcessSingleAction(object oCreature, string sAction)
{   if ((sAction == "walk") || (sAction == "1"))
    { AssignCommand(oCreature, ActionRandomWalk()); return; }

    if (sAction == "chair")
    { object oChair = GetNearestObjectByTag("Chair", oCreature, 1);
      if (GetIsObjectValid(oChair))
      { AssignCommand(oCreature, ActionSit(oChair)); }
      return;
    }

    if (sAction == "dead")
    { AssignCommand(oCreature, SetIsDestroyable(FALSE, TRUE, TRUE));
      ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oCreature);
      return;
    }

    if (sAction == "corpse")
    { AssignCommand(oCreature, SetIsDestroyable(FALSE, FALSE, FALSE));
      ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oCreature);
      return;
    }

    if (FirstWord(sAction, ":") == "faction")
    { object oFactionNPC = GetObjectByTag("Faction_" + RestWords(sAction, ":"));
      if (GetIsObjectValid(oFactionNPC))
      { ChangeFaction(oCreature, oFactionNPC); }
      return;
    }

    if (FirstWord(sAction, ":") == "unequip")
    { string sSlot = RestWords(sAction, ":");
      object oItem = GetItemInSlot(WhichSlot(sSlot), oCreature);
      if (GetIsObjectValid(oItem))
      { AssignCommand(oCreature, ActionUnequipItem(oItem)); }
      return;
    }

    if (FirstWord(sAction, ":") == "equip")
    { string sSlot = FirstWord(RestWords(sAction, ":"), ":");
      string sTag = RestWords(RestWords(sAction, ":"), ":");
      object oItem = GetItemPossessedBy(oCreature, sTag);
      if (GetIsObjectValid(oItem))
      { AssignCommand(oCreature, ActionEquipItem(oItem, WhichSlot(sSlot))); }
      return;
    }

    int iAnim;
    if (sAction == "spasm")
    { iAnim = ANIMATION_LOOPING_SPASM; }
    else if (sAction == "sit")
    { iAnim = ANIMATION_LOOPING_SIT_CROSS; }
    else if (sAction == "threaten")
    { iAnim = ANIMATION_LOOPING_TALK_FORCEFUL; }
    else if (sAction == "laugh")
    { iAnim = ANIMATION_LOOPING_TALK_LAUGHING; }
    else if (sAction == "talk")
    { iAnim = ANIMATION_LOOPING_TALK_NORMAL; }
    else if (sAction == "beg")
    { iAnim = ANIMATION_LOOPING_TALK_PLEADING; }
    else if (sAction == "worship")
    { iAnim = ANIMATION_LOOPING_WORSHIP; }
    else if (sAction == "pray")
    { iAnim = ANIMATION_LOOPING_MEDITATE; }
    else if (sAction == "conjure1")
    { iAnim = ANIMATION_LOOPING_CONJURE1; }
    else if (sAction == "conjure2")
    { iAnim = ANIMATION_LOOPING_CONJURE2; }
    else
    { return; }

    AssignCommand(oCreature, ActionPlayAnimation(iAnim, 1.0f, 9999.0f));
    return;
}

void ProcessActions(object oCreature, string sActionList)
{   string sAction = FirstWord(sActionList, ";");
    sActionList = RestWords(sActionList, ";");

    while (sAction != "")
    { ProcessSingleAction(oCreature, sAction);
      sAction = FirstWord(sActionList, ";");
      sActionList = RestWords(sActionList, ";");
    }
}


location ProcessLocation(string sLoc, string sOffset, int iSpawn, int iTotalSpawns, object oArea)
{   string sAngle = RestWords(sLoc, "@");
    sLoc = FirstWord(sLoc, "@");

    location lLoc;
    float fAngle;
    if (sAngle == "")
    { fAngle = IntToFloat(Random(360)); }
    else if (sAngle == "last")
    { lLoc = GetLocalLocation(oArea, "lLastSpawn");
      fAngle = GetFacingFromLocation(lLoc);
    }
    else
    { fAngle = StringToFloat(sAngle); }

    string sType = GetStringLowerCase(FirstWord(sLoc, ":"));
    string sParameter = RestWords(sLoc, ":");
    float fOffset = StringToFloat(sOffset);
    vector vVector;
    float fROffset;
    float fFacingOffset = 0.0f;

    if ((sType == "circle") || (sType == "circleflip"))
    { if (iSpawn > 0)
      { lLoc = GetLocalLocation(oArea, "lLastSpawn"); }
      else
      { lLoc = ProcessLocation(sParameter, "", 0, 0, oArea);
        SetLocalLocation(oArea, "lLastSpawn", lLoc);
      }
      vVector = GetPositionFromLocation(lLoc);
      fAngle = (360.0f / IntToFloat(iTotalSpawns)) * iSpawn;
      if (sType == "circleflip")
      { fFacingOffset = 180.0f; }
      lLoc = Location(oArea, GetChangedPosition(vVector, fOffset, fAngle), fFacingOffset + fAngle);
      return lLoc;
    }

    if ((sType == "loc") || (sType == "location"))
    { sParameter = GetStringLowerCase(sParameter);
      float fLocX = StringToFloat(FirstWord(sParameter, "x"));
      sParameter = RestWords(sParameter, "x");
      float fLocY = StringToFloat(FirstWord(sParameter, "y"));
      sParameter = RestWords(sParameter, "y");
      float fLocZ = 0.0f;
      if (sParameter != "")
      { fLocZ = StringToFloat(FirstWord(sParameter, "z")); }
      lLoc = Location(oArea, Vector(fLocX, fLocY, fLocZ), fAngle);
      SetLocalLocation(oArea, "lLastSpawn", lLoc);
      if (sOffset != "")
      { vVector = GetPositionFromLocation(lLoc);
        fROffset = IntToFloat(Random(FloatToInt(fOffset * 100.0f))) / 100.0f;
        lLoc = Location(oArea, GetChangedPosition(vVector, fROffset, fAngle), fAngle);
      }
      return lLoc;

    }

    if ((sType == "wp") || (sType == "waypoint"))
    { lLoc = GetLocation(GetWaypointByTag(sParameter));
      SetLocalLocation(oArea, "lLastSpawn", lLoc);
      if (sOffset != "")
      { vVector = GetPositionFromLocation(lLoc);
        fROffset = IntToFloat(Random(FloatToInt(fOffset * 100.0f))) / 100.0f;
        lLoc = Location(oArea, GetChangedPosition(vVector, fROffset, fAngle), fAngle);
      }
      return lLoc;
    }

    if ((sType == "object") || (sType == "obj"))
    { lLoc = GetLocation(GetNearestObjectByTag(sParameter, GetFirstObjectInArea(oArea)));
      SetLocalLocation(oArea, "lLastSpawn", lLoc);
      if (sOffset != "")
      { vVector = GetPositionFromLocation(lLoc);
        fROffset = IntToFloat(Random(FloatToInt(fOffset * 100.0f))) / 100.0f;
        lLoc = Location(oArea, GetChangedPosition(vVector, fROffset, fAngle), fAngle);
      }
      return lLoc;
    }

    if (sType == "last")
    { lLoc = GetLocalLocation(oArea, "lLastSpawn");
      return lLoc;
    }

    // Return a random location. Do not use the edges (.05 width).

    int iAreaX = GetAreaSize(AREA_WIDTH, oArea);
    int iAreaY = GetAreaSize(AREA_HEIGHT, oArea);

    float fRandX = IntToFloat(Random(iAreaX * 10)) + (IntToFloat(Random(90)) / 100) + 0.05f;
    float fRandY = IntToFloat(Random(iAreaY * 10)) + (IntToFloat(Random(90)) / 100) + 0.05f;

    lLoc = Location(oArea, Vector(fRandX, fRandY, 0.0f), fAngle);
    SetLocalLocation(oArea, "lLastSpawn", lLoc);

    return lLoc;
}

int GetSpawnAmount(string sAmt)
{   if (TestStringAgainstPattern("*n-*n", sAmt))
    { int iLowAmt = StringToInt(FirstWord(sAmt, "-"));
      int iHighAmt = StringToInt(RestWords(sAmt, "-"));
      return (Random((iHighAmt - iLowAmt) +1) + iLowAmt);
    }
    else
    { return StringToInt(sAmt); }
}

int ProcessV2Entry(string sEnc, object oArea, object oDB, string sLocationOverride = "", string sOffsetOverride = "")
{   string sResRef;
    int iAmt;
    string sLocation;
    string sOffset;
    location lLocation;
    int iLoop;
    object oSpawn;
    int iEntry;
    int iContinue;
    string sAction;
    string sNewTag;

    string sType = GetStringLowerCase(FirstWord(sEnc, ","));
    sEnc = RestWords(sEnc, ",");

    if (sType == "music")
    { string sMusic = GetStringLowerCase(FirstWord(sEnc, ","));
      sEnc = RestWords(sEnc, ",");
      int iMusicTrack = StringToInt(FirstWord(sEnc, ","));

      if (iMusicTrack == 0) { return TRUE; }

      if (sMusic == "day")
      { SetLocalInt(oArea, "iSparkyMusicDay", MusicBackgroundGetDayTrack(oArea));
        MusicBackgroundStop(oArea);
        MusicBackgroundChangeDay(oArea, iMusicTrack);
      }
      else if (sMusic == "night")
      { SetLocalInt(oArea, "iSparkyMusicNight", MusicBackgroundGetNightTrack(oArea));
        MusicBackgroundStop(oArea);
        MusicBackgroundChangeNight(oArea, iMusicTrack);
      }
      else if (sMusic == "battle")
      { SetLocalInt(oArea, "iSparkyMusicBattle", MusicBackgroundGetBattleTrack(oArea));
        MusicBattleChange(oArea, iMusicTrack);
      }

      return (StringToInt(sEnc));
    }

    if ((sType == "creature") || (sType == "npc"))
    { sResRef = FirstWord(FirstWord(sEnc, ","), ":");
      sNewTag = RestWords(FirstWord(sEnc, ","), ":");
      sEnc = RestWords(sEnc, ",");

      iAmt = GetSpawnAmount(FirstWord(sEnc, ","));
      sEnc = RestWords(sEnc, ",");

      sLocation = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sLocationOverride !="") { sLocation = sLocationOverride; }

      sOffset = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sOffsetOverride !="") { sOffset = sOffsetOverride; }

      sAction = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      for (iLoop = 0; iLoop < iAmt; iLoop++)
      { lLocation = ProcessLocation(sLocation, sOffset, iLoop, iAmt, oArea);
        oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLocation, FALSE, sNewTag);
        SetLocalInt(oSpawn, "iSparkySpawn", TRUE);
        ProcessActions(oSpawn, sAction);
      }

      return (StringToInt(sEnc));
    }

    if (sType == "mcs")
    { object oMCS_Spawn;
      location lHoldingCell = GetLocation(GetWaypointByTag("MCS_CELL"));
      string sRecord;

      string sMCS_Unit = "ENC_MCS_" + FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      string sMCS_BagName = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      object oMCS = FindMCSBag(sMCS_Unit, sMCS_BagName);
      if (!GetIsObjectValid(oMCS)) { return TRUE; }

      string sMCSData = GetDescription(oMCS, FALSE, FALSE);

      iAmt = StringToInt(FirstWord(sMCSData, "|"));
      sMCSData = RestWords(sMCSData, "|");

      sLocation = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sLocationOverride !="") { sLocation = sLocationOverride; }

      sOffset = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sOffsetOverride !="") { sOffset = sOffsetOverride; }

      sAction = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      for (iLoop = 0; iLoop < iAmt; iLoop++)
      { lLocation = ProcessLocation(sLocation, sOffset, iLoop, iAmt, oArea);
        object oMCSSpawn = CreateObject(OBJECT_TYPE_CREATURE, FirstWord(sMCSData, "|"), lHoldingCell);
        sMCSData = RestWords(sMCSData, "|");
        sRecord = FirstWord(sMCSData, "<<<EOR>>>|");
        sMCSData = RestWords(sMCSData, "<<<EOR>>>|");

        RestoreCreature(oMCSSpawn, sRecord);
        oSpawn = CopyObject(oMCSSpawn, lLocation);
        DestroyObject(oMCSSpawn);

        SetLocalInt(oSpawn, "iSparkySpawn", TRUE);
        ProcessActions(oSpawn, sAction);

        sLocation = "last";
        sOffset = "";
      }

      return (StringToInt(sEnc));
    }

    if (sType == "sms")
    { string sSMS_Crate = "ENC_SMS_" + FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      string sSMSWidgetName = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      object oSMS = FindSMSWidget(sSMS_Crate, sSMSWidgetName);
      if (!GetIsObjectValid(oSMS)) { return TRUE; }

      sLocation = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sLocationOverride !="") { sLocation = sLocationOverride; }

      sOffset = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sOffsetOverride !="") { sOffset = sOffsetOverride; }

      if ((sLocation == "absolute") || (sLocation == "abs"))
      { lLocation = ProcessLocation("1.0x1.0y", sOffset, 1, 1, oArea);
        Unpack(oSMS, lLocation, OBJECT_INVALID, FALSE, FALSE, FALSE, 2);
      }
      else
      { lLocation = ProcessLocation(sLocation, sOffset, 1, 1, oArea);
        Unpack(oSMS, lLocation, OBJECT_INVALID, TRUE, TRUE, FALSE, 2);
      }

      return (StringToInt(sEnc));

    }

    if ((sType == "placeable") || (sType == "prop") || (sType == "static"))
    { sResRef = FirstWord(FirstWord(sEnc, ","), ":");
      sNewTag = RestWords(FirstWord(sEnc, ","), ":");
      sEnc = RestWords(sEnc, ",");

      iAmt = GetSpawnAmount(FirstWord(sEnc, ","));
      sEnc = RestWords(sEnc, ",");

      sLocation = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sLocationOverride !="") { sLocation = sLocationOverride; }

      sOffset = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sOffsetOverride !="") { sOffset = sOffsetOverride; }

      for (iLoop = 0; iLoop < iAmt; iLoop++)
      { lLocation = ProcessLocation(sLocation, sOffset, iLoop, iAmt, oArea);
        oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLocation, FALSE, sNewTag);
        SetLocalInt(oSpawn, "iSparkySpawn", TRUE);
        if (sType == "static")
        { AssignCommand(oSpawn, SetIsDestroyable(FALSE)); }
      }

      return (StringToInt(sEnc));
    }

    if ((sType == "waypoint") || (sType == "wp"))
    { sNewTag = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      sLocation = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sLocationOverride !="") { sLocation = sLocationOverride; }

      sOffset = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sOffsetOverride !="") { sOffset = sOffsetOverride; }

      lLocation = ProcessLocation(sLocation, sOffset, 1, 1, oArea);
      oSpawn = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", lLocation, FALSE, sNewTag);
      SetLocalInt(oSpawn, "iSparkySpawn", TRUE);

      return (StringToInt(sEnc));
    }

    if (sType == "item")
    { sResRef = FirstWord(FirstWord(sEnc, ","), ":");
      sNewTag = RestWords(FirstWord(sEnc, ","), ":");
      sEnc = RestWords(sEnc, ",");

      iAmt = GetSpawnAmount(FirstWord(sEnc, ","));
      sEnc = RestWords(sEnc, ",");

      sLocation = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sLocationOverride !="") { sLocation = sLocationOverride; }

      sOffset = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sOffsetOverride !="") { sOffset = sOffsetOverride; }

      for (iLoop = 0; iLoop < iAmt; iLoop++)
      { lLocation = ProcessLocation(sLocation, sOffset, iLoop, iAmt, oArea);
        oSpawn = CreateObject(OBJECT_TYPE_ITEM, sResRef, lLocation, FALSE, sNewTag);
        SetLocalInt(oSpawn, "iSparkySpawn", TRUE);
      }

      return (StringToInt(sEnc));
    }

    if ((sType == "trap") || (sType == "traps"))
    { string sTrapStrength = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      string sTrapDmgType = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      string sTrapType = sTrapStrength + " " + sTrapDmgType;

      iAmt = GetSpawnAmount(FirstWord(sEnc, ","));
      sEnc = RestWords(sEnc, ",");

      float fTrapSize = StringToFloat(FirstWord(sEnc, ","));
      sEnc = RestWords(sEnc, ",");
      if (fTrapSize < 1.0f)
      { fTrapSize = 2.0f; }

      string sDetectDC = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      string sDisarmDC = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      int iRecoverable = StringToInt(FirstWord(sEnc, ","));
      sEnc = RestWords(sEnc, ",");

      sLocation = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sLocationOverride !="") { sLocation = sLocationOverride; }

      sOffset = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sOffsetOverride !="") { sOffset = sOffsetOverride; }

      for (iLoop = 0; iLoop < iAmt; iLoop++)
      { lLocation = ProcessLocation(sLocation, sOffset, iLoop, iAmt, oArea);
        oSpawn = CreateTrapAtLocation(ProcessTrapType(sTrapType), lLocation, fTrapSize);
        SetLocalInt(oSpawn, "iSparkySpawn", TRUE);

        if (sDetectDC == "-1")
        { SetTrapDetectable(oSpawn, FALSE); }
        else if (sDetectDC != "")
        { SetTrapDetectDC(oSpawn, StringToInt(sDetectDC)); }

        if (sDisarmDC == "-1")
        { SetTrapDisarmable(oSpawn, FALSE); }
        else if (sDisarmDC != "")
        { SetTrapDisarmDC(oSpawn, StringToInt(sDisarmDC)); }

        if (!iRecoverable)
        { SetTrapRecoverable(oSpawn, FALSE); }
      }

      return (StringToInt(sEnc));
    }

    if (sType == "script")
    { sResRef = FirstWord(FirstWord(sEnc, ","), ":");
      string sRunAs = RestWords(FirstWord(sEnc, ","), ":");
      object oRunAs;
      if (sRunAs != "")
      { oRunAs = GetObjectByTag(sRunAs);
        if (!GetIsObjectValid(oRunAs))
        { oRunAs = oDB; }
      }
      else
      { oRunAs = oDB; }
      ExecuteScript(sResRef, oRunAs);
      return TRUE;
    }

    if (sType == "group")
    { string sGroup = "group_" + GetStringLowerCase(FirstWord(sEnc, ","));
      iEntry = 1;

      for (iEntry = 1; sEnc != ""; iEntry++)
      { sEnc = GetLocalString(oArea, sGroup + ((iEntry < 10) ? "_0" : "_") + IntToString(iEntry));
        iContinue = ProcessV2Entry(SearchAndReplace(sEnc, " ", ""), oArea, oDB, sLocationOverride, sOffsetOverride);
      }

      return iContinue;
    }

    if (sType == "table")
    { string sTable = "table_" + GetStringLowerCase(FirstWord(sEnc, ","));
      int iDieRoll = d100();
      int iChance = 0;
      iEntry = 1;

      for (iEntry = 1; iDieRoll > iChance; iEntry++)
      { sEnc = GetLocalString(oArea, sTable + ((iEntry < 10) ? "_0" : "_") + IntToString(iEntry));

        iChance = StringToInt(FirstWord(sEnc, ","));
        sEnc = RestWords(sEnc, ",");
      }

      iContinue = ProcessV2Entry(SearchAndReplace(sEnc, " ", ""), oArea, oDB, sLocationOverride, sOffsetOverride);
      return iContinue;
    }

    if ((sType == "level") || (sType == "lvl"))
    { int iSparkyPartyLvls = GetLocalInt(oArea, "iSparkyPartyLvls");
      string sTable = "lvltable_" + GetStringLowerCase(FirstWord(sEnc, ","));
      int iEntryLvl = 10000;
      iEntry = 1;

      for (iEntry = 1; iSparkyPartyLvls < iEntryLvl; iEntry++)
      { sEnc = GetLocalString(oArea, sTable + ((iEntry < 10) ? "_0" : "_") + IntToString(iEntry));

        iEntryLvl = StringToInt(FirstWord(sEnc, ","));
        sEnc = RestWords(sEnc, ",");
      }

      iContinue = ProcessV2Entry(SearchAndReplace(sEnc, " ", ""), oArea, oDB, sLocationOverride, sOffsetOverride);
      return iContinue;
    }

    if (sType == "copy")
    { string sAreaTag = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      string sObjTag = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      sNewTag = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      object oSourceArea = GetObjectByTag(sAreaTag);
      object oObject = GetFirstObjectInArea(oSourceArea);
      if (GetTag(oObject) != sObjTag)
      { oObject = GetNearestObjectByTag(sObjTag, oObject); }

      iAmt = GetSpawnAmount(FirstWord(sEnc, ","));
      sEnc = RestWords(sEnc, ",");

      sLocation = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sLocationOverride !="") { sLocation = sLocationOverride; }

      sOffset = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      if (sOffsetOverride !="") { sOffset = sOffsetOverride; }

      if (GetObjectType(oObject) == OBJECT_TYPE_CREATURE)
      { sAction = FirstWord(sEnc, ",");
        sEnc = RestWords(sEnc, ",");
      }

      for (iLoop = 0; iLoop < iAmt; iLoop++)
      { lLocation = ProcessLocation(sLocation, sOffset, iLoop, iAmt, oArea);
        oSpawn = CopyObject(oObject, lLocation, OBJECT_INVALID, sNewTag);
        SetLocalInt(oSpawn, "iSparkySpawn", TRUE);
        if (GetObjectType(oObject) == OBJECT_TYPE_CREATURE)
        { ProcessActions(oSpawn, sAction); }
      }

      return (StringToInt(sEnc));
    }

    if (sType == "disable")
    { string sEntry = FirstWord(sEnc, ",");
      iContinue = StringToInt(RestWords(sEnc, ","));

      sEnc = GetLocalString(oDB, "encounter_" + sEntry);

      if (!TestStringAgainstPattern("OFF:**", sEnc))
      { SetLocalString(oDB, "encounter_" + sEntry, "OFF:" + sEnc);
        SetLocalString(oDB, "sSparky_Disabled_List", GetLocalString(oArea, "sSparky_Disabled_List") + sEntry + " ");
      }

      return iContinue;
    }

    return TRUE;
}

int ProcessTime(string sTime)
{   if (sTime == "always")
    { return TRUE; }

    if (sTime == "day")
    { return GetIsDay(); }

    if (sTime == "night")
    { return GetIsNight(); }

    if (TestStringAgainstPattern("*n", sTime))
    { return (StringToInt(sTime) == GetTimeHour()); }

    if (TestStringAgainstPattern("*n-*n", sTime))
    { int iHour = GetTimeHour();
      int iHour1 = StringToInt(FirstWord(sTime, "-"));
      int iHour2 = StringToInt(FirstWord(RestWords(sTime, "-"), ","));

      if (iHour2 < iHour1)
      { return (iHour1 <= iHour) || (iHour <= iHour2); }
      else
      { return (iHour1 <= iHour) && (iHour <= iHour2); }
    }

    return FALSE;
}

int ProcessV2Encounter(string sEnc, object oArea, object oDB)
{   int iRightTime = ProcessTime(GetStringLowerCase(FirstWord(sEnc, ",")));
    sEnc = RestWords(sEnc, ",");

    int iChance = StringToInt(FirstWord(sEnc, ","));
    sEnc = RestWords(sEnc, ",");

    if ((d100() <= iChance) && iRightTime)
    { int iContinue = ProcessV2Entry(sEnc, oArea, oDB);
      return iContinue;
    }

    return TRUE;
}

int ProcessEncounter(string sEnc, object oArea, object oDB)
{   int iContinue;
    int iLoop;
    object oSpawn;

    if (TestStringAgainstPattern("OFF:**", sEnc))
    { return TRUE; }

    if (GetStringLowerCase(FirstWord(sEnc, ",")) == "v2")
    { iContinue = ProcessV2Encounter(RestWords(sEnc, ","), oArea, oDB);
      return iContinue;
    }

    if (GetStringLowerCase(FirstWord(sEnc, ":")) == "runscript")
    { ExecuteScript(RestWords(sEnc, ":"), oDB);
      return TRUE;
    }

    int iChance = StringToInt(FirstWord(sEnc, ","));
    sEnc = RestWords(sEnc, ",");

    string sResRef = FirstWord(sEnc, ",");
    sEnc = RestWords(sEnc, ",");

    int iAmt = StringToInt(FirstWord(sEnc, ","));
    sEnc = RestWords(sEnc, ",");

    object oWP = GetWaypointByTag(FirstWord(sEnc, ","));
    location lWP = GetLocation(oWP);

    iContinue = StringToInt(RestWords(sEnc, ","));

    if (iChance <= d100())
    { for (iLoop = 0; iLoop < iAmt; iLoop++)
      {   oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lWP);
          SetLocalInt(oSpawn, "iSparkySpawn", TRUE);
          AssignCommand(oSpawn, ActionRandomWalk());
      }
      return iContinue;
    }

    return TRUE;
}

void SpawnEncounters(object oArea)
{   int iDone = FALSE;
    int iEnc = 1;
    string sEnc;
    object oDB = oArea;

    if (GetObjectType(oArea) == OBJECT_TYPE_TRIGGER)
    { oArea = GetArea(oDB);
      int iSparkyTriggers = GetLocalInt(oArea, "iSparkyTriggers");
      SetLocalObject(oArea, "oSparkyTrigger" + IntToString(iSparkyTriggers), oDB);
      SetLocalInt(oArea, "iSparkyTriggers", iSparkyTriggers + 1);
    }

    while (!iDone)
    {   sEnc = GetLocalString(oDB, "encounter" + ((iEnc < 10) ? "_0" : "_") + IntToString(iEnc));
        sEnc = SearchAndReplace(sEnc, " ", "");
        if (sEnc == "")
        { iDone = TRUE;}
        else
        { iDone = ProcessEncounter(sEnc, oArea, oDB);
          iDone = abs(iDone - 1);
          iEnc++;
        }
    }

    SetLocalInt(oDB, "iSparkySpawned", TRUE);
}

void Despawn(object oArea)
{   object oObject;
    int iObjectType;
    int iSpawned;
    string sEntry;
    string sEnc;

    iSpawned = GetLocalInt(oArea, "iSparkySpawned");
    if (!iSpawned)
    { return; }

    string sSparky_Disabled_List = GetLocalString(oArea, "sSparky_Disabled_List");
    while (sSparky_Disabled_List != "")
    { sEntry = FirstWord(sSparky_Disabled_List, " ");
      sSparky_Disabled_List = RestWords(sSparky_Disabled_List, " ");

      sEnc = GetLocalString(oArea, "encounter_" + sEntry);
      if (TestStringAgainstPattern("OFF:**", sEnc))
      { SetLocalString(oArea, "encounter_" + sEntry, RestWords(sEnc, "OFF:")); }
    }

    DeleteLocalString(oArea, "sSparky_Disabled_List");

    oObject = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oObject))
    {   iObjectType = GetObjectType(oObject);
        iSpawned = GetLocalInt(oObject, "iSparkySpawn");
        if (iSpawned)
        { if ((iObjectType == OBJECT_TYPE_PLACEABLE) && GetHasInventory(oObject))
          { DestroyContents(oObject); }
          AssignCommand(oObject, SetIsDestroyable(TRUE));
          DestroyObject(oObject);
        }

        oObject = GetNextObjectInArea(oArea);
    }

    int iMusic = GetLocalInt(oArea, "iSparkyMusicDay");
    if ( iMusic!= 0)
    { MusicBackgroundStop(oArea);
      MusicBackgroundChangeDay(oArea, iMusic);
      DeleteLocalInt(oArea, "iSparkyMusicDay");
    }

    iMusic = GetLocalInt(oArea, "iSparkyMusicNight");
    if ( iMusic!= 0)
    { MusicBackgroundStop(oArea);
      MusicBackgroundChangeNight(oArea, iMusic);
      DeleteLocalInt(oArea, "iSparkyMusicNight");
    }

    iMusic = GetLocalInt(oArea, "iSparkyMusicBattle");
    if ( iMusic!= 0)
    { MusicBattleChange(oArea, iMusic);
      DeleteLocalInt(oArea, "iSparkyMusicBattle");
    }

    MusicBackgroundStop(oArea);
    MusicBackgroundPlay(oArea);

    SetLocalInt(oArea, "iSparkySpawned", FALSE);

    int iSparkyTriggers = GetLocalInt(oArea, "iSparkyTriggers");
    int iLoop;
    object oDB;
    string sDB;

    for (iLoop = 0; iLoop < iSparkyTriggers; iLoop++)
    { sDB = "oSparkyTrigger" + IntToString(iLoop);
      oDB = GetLocalObject(oArea, sDB);
      SetLocalInt(oDB, "iSparkySpawned", FALSE);
      DeleteLocalObject(oArea, sDB);
    }

    DeleteLocalInt(oArea, "iSparkyTriggers");
}

