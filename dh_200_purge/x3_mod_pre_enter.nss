//
// enter_script -- This script, or the code from it, may be added to
// onEnterModule if you wish to automatically give the scavenger object to
// each player as they enter the module.
//
#include "disease_inc"
#include "_cls_bard"
#include "_incl_xp"
#include "_incl_versioning"
#include "_incl_badges"

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

    object oPCToken = GetItemPossessedBy(oPC, "token_pc");

    // First login ever - there'll have to be lots of other setup stuff here.
    if(oPCToken == OBJECT_INVALID)
    {
        oPCToken = CreateItemOnObject("token_pc", oPC);
        // Setup for brand new bard
        if(GetClassByPosition(1, oPC) == CLASS_TYPE_BARD && GetHitDice(oPC) == 1)
            SetupNewBard(oPC);

    }

    // clean up their tokens, if they have any
    if(!GetLocalInt(oPCToken, "bTokensInit"))
        TokensToVars(oPC, oPCToken);

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

    //RefreshBadges(oPC);

    string sPre = GetDBVarName(oPC);
    int iVer = GetCampaignInt("VERSIONING", sPre+"Version");
    switch(iVer)
    {
        case 0:
            //All new PCs
            ZeroToVersionTwo(oPC);
            break;
        case 1:
            //There should be no pcs marked as v1, they predate this system
            ZeroToVersionTwo(oPC);
            break;
        case 2:
            break;
        default:
            break;
    }

    

    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "DeathToken") ||
        OBJECT_INVALID != GetItemPossessedBy(oPC, "ReaperToken"))
    {
        location lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(lLoc)));
    }

    //This needs to get rewritten so that it's not being duplicated by ApplyDisease
    int nDisease = 0;
    object oCheckDisease = GetFirstItemInInventory(oPC);
    while (oCheckDisease != OBJECT_INVALID)
    {
        if (GetTag(oCheckDisease) == "ZombieDisease")
        {
            nDisease += 1;
        }
        oCheckDisease = GetNextItemInInventory(oPC);
    }
    if (nDisease >= 10)
    {
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(GetLocation(GetWaypointByTag("lostsoularrive")))));
    }

    if (GetItemPossessedBy(oPC,"ZombieDisease") != OBJECT_INVALID && GetLocalInt(oPC,"DiseaseApplied") != TRUE)
    {
        ApplyDisease(oPC);
    }
}
