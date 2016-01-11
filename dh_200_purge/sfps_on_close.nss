//------------------------------------------------------------------
//             Spiffy Fox Persistent Storage system v2
//
// original version by Spiffy Fox
// recode (v2) by Malishara
//
// sfps_close     OnClose event for persistent storage containers
//
//------------------------------------------------------------------

#include "sfps_inc"
#include "dmts_common_inc"


void main()
{   if (GetLocalInt(OBJECT_SELF, "iSFPS_Unload"))
    { DestroyContents(OBJECT_SELF);
      DeleteLocalInt(OBJECT_SELF, "iSFPS_Loaded");
      return;
    }
    string sPrefix = GetLocalString(OBJECT_SELF, "sSFPS_Prefix");
    if (sPrefix == "")
    { sPrefix = "PS_"; }

    int iStuffed = WritePS(OBJECT_SELF, GetStringLeft(GetTag(OBJECT_SELF), 29), sPrefix);
    if (iStuffed > 200)
    { SendMessageToPC(GetLastClosedBy(), "ERROR: Storage capacity (200 items) exceeded! Please remove some items!"); }
}
