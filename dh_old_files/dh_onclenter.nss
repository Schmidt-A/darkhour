//
// enter_script -- This script, or the code from it, may be added to
// onEnterModule if you wish to automatically give the scavenger object to
// each player as they enter the module.
//
#include "disease_inc"
#include "x3_inc_horse"
#include "_incl_xp"
#include "_incl_versioning"
void main()
{

    object oPC = GetEnteringObject();
    string sModName = GetName(GetModule());
    if(GetHasFeat(FEAT_HORSE_MENU, oPC) == FALSE)
    {
        HorseAddHorseMenu(oPC);
    }
    if(GetCampaignInt(GetPCPlayerName(oPC)+"_BANNED",GetPCPlayerName(oPC))==TRUE)
    {
        BootPC(oPC);
    }
    else if(GetCampaignInt(GetPCIPAddress(oPC)+"_BANNED",GetPCIPAddress(oPC))==TRUE)
    {
        BootPC(oPC);
    }
    else if(GetCampaignInt(GetPCPublicCDKey(oPC)+"_BANNED",GetPCPublicCDKey(oPC))==TRUE)
    {
        BootPC(oPC);
    }
    string sName = GetName(oPC);
    int nHitpoints = GetLocalInt(GetModule(),sName);

    //set their xp vars
    SetXPVars(oPC);

    string sMessage = GetName(oPC) + " is entering the game from: " +
                        GetPCPublicCDKey(oPC) + " IP ADDRESS: " +
                        GetPCIPAddress(oPC);
    string sLog = "ENTRY: " + GetName(oPC) + " | " +
                                GetPCPublicCDKey(oPC) + " | " +
                                GetPCIPAddress(oPC) + " | " +
                                IntToString(GetXPDH(oPC));
    SendMessageToAllDMs(sMessage);
    PrintString(sMessage);
    // a new logging form
    WriteTimestampedLogEntry(sLog);

    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "Banner"))
    {
        BootPC(oPC);
    }
    if (nHitpoints > 0)
    {
        int nLessHP = GetMaxHitPoints(oPC) - nHitpoints;
        if (nLessHP > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nLessHP),oPC);
        }
    }

    string sPre = GetDBVarName(oPC);
    int iVer = GetCampaignInt("VERSIONING", sPre+"Version");
    switch(iVer)
    {
        case 0: 
            ZeroToVersionTwo(oPC);
            break;
        case 1: 
            OneToVersionTwo(oPC);
            break;
        case 2: 
            break;
        default:
            break;
    }

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

    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "DeathToken"))
    {
//      effect eDeath = EffectDeath();
//      ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oPC);

        int nAlign = GetAlignmentGoodEvil(oPC);
        location lLoc;
        if (nAlign == ALIGNMENT_EVIL)
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        else if (nAlign == ALIGNMENT_GOOD)
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        else
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(lLoc)));
    }
    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "ReaperToken"))
    {
//      effect eDeath = EffectDeath();
//      ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oPC);

        int nAlign = GetAlignmentGoodEvil(oPC);
        location lLoc;
        if (nAlign == ALIGNMENT_EVIL)
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        else if (nAlign == ALIGNMENT_GOOD)
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        else
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(lLoc)));
    }

    ExecuteScript("window_mod_enter", OBJECT_SELF);

    if(GetItemPossessedBy(oPC,"ZombieDisease") != OBJECT_INVALID && GetLocalInt(oPC,"DiseaseApplied") != TRUE)
    {
        ApplyDisease(oPC);
    }
}