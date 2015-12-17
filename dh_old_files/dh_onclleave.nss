#include "_incl_xp"
#include "nw_i0_spells"

void main()
{
    object oPC = GetExitingObject();
    location lLocation = GetLocation(oPC);
    string sModName = GetName(GetModule());
    SetCampaignLocation(sModName, "lastlocation", lLocation, oPC);

    //log their exp on logout
    string sLog = "EXIT: " + GetName(oPC) + " | " +
                                GetPCPublicCDKey(oPC) + " | " +
                                GetPCIPAddress(oPC) + " | " +
                                IntToString(GetXPDH(oPC));
    WriteTimestampedLogEntry(sLog);

    // Clean up crafting in case the player crashes mid-conversation.
    object oBackup = GetLocalObject(oPC, "ZEP_CR_BACKUP");
    if(oBackup != OBJECT_INVALID)
    {
        DeleteLocalObject(oPC, "ZEP_CR_BACKUP");
        RemoveSpecificEffect(EFFECT_TYPE_CUTSCENE_PARALYZE, oPC);
    }
}