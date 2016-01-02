//------------------------------------------------------------------
//             Spiffy Fox Persistent Storage system v2
//
// original version by Spiffy Fox
// recode (v2) by Malishara
//
// sfps_open      OnOpen event for persistent storage containers
//
//------------------------------------------------------------------

#include "sfps_inc"


void main()
{   int iAmtLoaded;
    string sPrefix = GetLocalString(OBJECT_SELF, "sSFPS_Prefix");
    if (sPrefix == "")
    { sPrefix = "PS_"; }

    int iVersion = GetCampaignInt(sPrefix + GetStringLeft(GetTag(OBJECT_SELF), 29), "PS_iVersion");
    if (iVersion == 2)
    { iAmtLoaded = ReadPS(OBJECT_SELF, GetStringLeft(GetTag(OBJECT_SELF), 29), sPrefix); }
    else
    { iAmtLoaded = ReadPS(OBJECT_SELF, GetStringLeft(GetTag(OBJECT_SELF), 19), "ANNAKOLIA_PS_", 1); }
}
