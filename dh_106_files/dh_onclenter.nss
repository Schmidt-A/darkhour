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
#include "_incl_subrace"
#include "nwnx_chat"

// TODO: Move this to module variable
string AUTH_DB_NAME = "AUTH";
string FORUM_URL = "http://dhepilogue.boards.net/";

void Authenticate(object oPC);

void main()
{
    object oPC=GetEnteringObject();

    // nwnx_chat
    dmb_PCin(oPC);

    ExecuteScript("x3_mod_pre_enter",OBJECT_SELF); // Override for other skin systems

    if ((GetIsPC(oPC)||GetIsDM(oPC))&&!GetHasFeat(FEAT_HORSE_MENU,oPC))
    { // add horse menu
        HorseAddHorseMenu(oPC);
        if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB"))
        { // restore PC horse status from database
            DelayCommand(2.0,HorseReloadFromDatabase(oPC,X3_HORSE_DATABASE));
        } // restore PC horse status from database
    } // add horse menu
    if (GetIsPC(oPC))
    { // more details
        // restore appearance in case you export your character in mounted form, etc.
        //if (!GetSkinInt(oPC,"bX3_IS_MOUNTED")) HorseIfNotDefaultAppearanceChange(oPC);
        // pre-cache horse animations for player as attaching a tail to the model

        // Format : PC_ENTER:[pc name]
        // Example: PC_ENTER:My PC
        string sLog = "PC_ENTER:" + GetPCPlayerName(oPC) + " | " +
                      GetName(oPC);
        WriteTimestampedLogEntry(sLog);

        HorsePreloadAnimations(oPC);
        DelayCommand(3.0,HorseRestoreHenchmenLocations(oPC));
        Authenticate(oPC);
    } // more details
}

// Homebrew CD Key Authentication
void Authenticate(object oPC)
{
    string sPlayerName = GetPCPlayerName(oPC);
    string sKey        = GetPCPublicCDKey(oPC);
    string sKeyVarName = "KEY_" + sPlayerName;
    string sStoredKey  = GetCampaignString(AUTH_DB_NAME, sKeyVarName);

    // First time this player has logged in
    if(sStoredKey == "")
        SetCampaignString(AUTH_DB_NAME, sKeyVarName, sKey);
    else if(sStoredKey != sKey)
    {
        SendMessageToPC(oPC, "YOU HAVE LOGGED IN TO AN ACCOUNT BOUND TO ANOTHER CD KEY. IF THIS IS A MISTAKE AND YOU ARE THE REAL OWNER OF THIS ACCOUNT, CONTACT THE ADMINS AT " + FORUM_URL);
        DelayCommand(15.0, BootPC(oPC)); // GTFO if your key is invalid
    }
}
