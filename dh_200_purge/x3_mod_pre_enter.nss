//
// enter_script -- This script, or the code from it, may be added to
// onEnterModule if you wish to automatically give the scavenger object to
// each player as they enter the module.
//

#include "_incl_xp"
#include "_incl_pc_setup"
#include "_incl_disease"

void main()
{
    object oPC = GetEnteringObject();

    if(GetCampaignInt(GetPCPlayerName(oPC)+"_BANNED", GetPCPlayerName(oPC)) == TRUE ||
       GetCampaignInt(GetPCIPAddress(oPC)+"_BANNED",  GetPCIPAddress(oPC))  == TRUE ||
       GetCampaignInt(GetPCPublicCDKey(oPC)+"_BANNED",GetPCPublicCDKey(oPC))== TRUE ||
       OBJECT_INVALID != GetItemPossessedBy(oPC, "Banner"))
    {
        BootPC(oPC);
    }

    string sName = GetName(oPC);
    string sMessage = sName + " is entering the game from: " +
                        GetPCPublicCDKey(oPC) + " IP ADDRESS: " +
                        GetPCIPAddress(oPC);
    SendMessageToAllDMs(sMessage);
    PrintString(sMessage);

    if (GetIsPC(oPC))
        SetLocalInt(oPC, "Is_PC", 1);

    int nHitpoints = GetLocalInt(GetModule(),sName);
    if (nHitpoints > 0)
    {
        int nLessHP = GetMaxHitPoints(oPC) - nHitpoints;
        if (nLessHP > 0)
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nLessHP),oPC);
    }

    AddJournalQuestEntry("Stuff1",1,oPC,FALSE);
    AddJournalQuestEntry("RULES2",1,oPC,FALSE);
    AddJournalQuestEntry("Stuff3",1,oPC,FALSE);
    AddJournalQuestEntry("Stuff4",1,oPC,FALSE);
    AddJournalQuestEntry("DMTEAM",1,oPC,FALSE);
    AddJournalQuestEntry("CraftingSystem",1,oPC,FALSE);
    AddJournalQuestEntry("ClawingFeverInfo",1,oPC,FALSE);

    //Give them all their items and shit
    UpdatePC(oPC);

    object oPCToken = GetItemPossessedBy(oPC, "token_pc");

    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "DeathToken") ||
        OBJECT_INVALID != GetItemPossessedBy(oPC, "ReaperToken"))
    {
        location lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(lLoc)));
    }

    if(GetLocalInt(oPCToken, "iDisease") > 0)
        ApplyDisease(oPC);
}
