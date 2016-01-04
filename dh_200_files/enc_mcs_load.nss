#include "sfps_inc"
#include "mali_string_fns"


void OpenStorage(string sConTag)
{   object oContainer = GetObjectByTag(sConTag);
    int iAmtLoaded;
    string sPrefix = "PS_";

    int iVersion = GetCampaignInt(sPrefix + sConTag, "PS_iVersion");
    if (iVersion == 2)
    { iAmtLoaded = ReadPS(oContainer, sConTag, sPrefix); }
    else
    { iAmtLoaded = ReadPS(oContainer, sConTag, "ANNAKOLIA_PS_", 1); }
}

void main()
{
    int iLoop = 1;
    while (iLoop < 15)
    {  OpenStorage("ENC_MCS_" + IntToString(iLoop));
       iLoop++;
    }

    iLoop = 1;
    while (iLoop < 16)
    {  OpenStorage("ENC_SMS" + ((iLoop < 10) ? "_0" : "_") + IntToString(iLoop));
       iLoop++;
    }

    object oWP = GetWaypointByTag("WP_FactionNPCs");
    object oSign = GetObjectByTag("MCS_FactionList");
    string sDelimiter = "";
    string sFactionList = "";

    object oThingie = GetFirstObjectInArea(GetArea(oWP));
    while (GetIsObjectValid(oThingie))
    {   if ( (GetDistanceBetween(oThingie, oWP) < 12.0f) &&
             (GetObjectType(oThingie) == OBJECT_TYPE_CREATURE) &&
             (TestStringAgainstPattern("Faction_**", GetTag(oThingie))) )
           { sFactionList = RestWords(GetTag(oThingie), "Faction_") + sDelimiter + sFactionList;
             sDelimiter = ", ";
           }
        oThingie = GetNextObjectInArea(GetArea(oWP));
    }

    SetDescription(oSign, "These factions are currently set up for MCS:\n\n" + sFactionList + ".");
    sFactionList = SearchAndReplace(sFactionList, " ", "") + ",";
    SetLocalString(oSign, "sFactionList", sFactionList);
}
