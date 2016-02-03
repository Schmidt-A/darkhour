//::///////////////////////////////////////////////
//:: Default On Enter for Module
//:: x3_mod_def_enter
//:: Copyright (c) 2008 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This script adds the horse menus to the PCs.
*/
//:://////////////////////////////////////////////
//:: Created By: Deva B. Winblood
//:: Created On: Dec 30th, 2007
//:: Last Update: April 21th, 2008
//:://////////////////////////////////////////////
#include "x3_inc_horse"

#include "_incl_disease"
#include "_incl_pc_data"
#include "_incl_pc_setup"
#include "_incl_subrace"
#include "_incl_xp"

#include "nwnx_chat"

void BootIfBanned(object oPC)
{
    if(GetCampaignInt(GetPCPlayerName(oPC)+"_BANNED", GetPCPlayerName(oPC)) == TRUE ||
       GetCampaignInt(GetPCIPAddress(oPC)+"_BANNED",  GetPCIPAddress(oPC))  == TRUE ||
       GetCampaignInt(GetPCPublicCDKey(oPC)+"_BANNED",GetPCPublicCDKey(oPC))== TRUE ||
       OBJECT_INVALID != GetItemPossessedBy(oPC, "Banner"))
    {
        BootPC(oPC);
    }
}

void EntryMessage(object oPC)
{
    string sName = GetName(oPC);
    string sMessage = sName + " is entering the game from: " +
                        GetPCPublicCDKey(oPC) + " IP ADDRESS: " +
                        GetPCIPAddress(oPC);
    SendMessageToAllDMs(sMessage);
    PrintString(sMessage);
}

void RestorePreviousHP(object oPC)
{
    int nHitpoints = GetLocalInt(GetModule(),GetName(oPC));
    if (nHitpoints > 0)
    {
        int nLessHP = GetMaxHitPoints(oPC) - nHitpoints;
        if (nLessHP > 0)
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nLessHP),oPC);
    }
}

void SetJournalEntries(object oPC)
{
    AddJournalQuestEntry("Stuff1",1,oPC,FALSE);
    AddJournalQuestEntry("RULES2",1,oPC,FALSE);
    AddJournalQuestEntry("Stuff3",1,oPC,FALSE);
    AddJournalQuestEntry("Stuff4",1,oPC,FALSE);
    AddJournalQuestEntry("DMTEAM",1,oPC,FALSE);
    AddJournalQuestEntry("CraftingSystem",1,oPC,FALSE);
    AddJournalQuestEntry("ClawingFeverInfo",1,oPC,FALSE);
}

void CheckForDeath(object oPC)
{
    if(!PCDIsDead(oPC))
        return;

    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "DeathToken") ||
        OBJECT_INVALID != GetItemPossessedBy(oPC, "ReaperToken"))
    {
        location lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(lLoc)));
    }
}

void CheckForDisease(object oPC)
{
    if(!PCDIsDiseased(oPC))
        return;
    ApplyDisease(oPC);
}

void main()
{
    object oPC=GetEnteringObject();

    // nwnx_chat
    dmb_PCin(oPC);

    if(GetIsPC(oPC)) 
    {
        BootIfBanned(oPC);
        EntryMessage(oPC);
        RestorePreviousHP(oPC);
        SetJournalEntries(oPC);
        UpdatePC(oPC);
        PCDCacheToken(oPC);
        CheckForDeath(oPC);
        CheckForDisease(oPC);
    }

    // Unique skin stuff has to be set prior to this point.
    if ((GetIsPC(oPC) || GetIsDM(oPC)) && !GetHasFeat(FEAT_HORSE_MENU,oPC))
    {
        HorseAddHorseMenu(oPC);
        if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB"))
            DelayCommand(2.0,HorseReloadFromDatabase(oPC,X3_HORSE_DATABASE));
    }
    if (GetIsPC(oPC))
    {
        // restore appearance in case you export your character in mounted form, etc.
        if(!GetSkinInt(oPC,"bX3_IS_MOUNTED"))
            HorseIfNotDefaultAppearanceChange(oPC);

        // Format : PC_ENTER:[pc name]
        // Example: PC_ENTER:My PC
        string sLog = "PC_ENTER:" + GetPCPlayerName(oPC) + " | " +
                      GetName(oPC);
        WriteTimestampedLogEntry(sLog);

        HorsePreloadAnimations(oPC);
        DelayCommand(3.0,HorseRestoreHenchmenLocations(oPC));
    }
}
