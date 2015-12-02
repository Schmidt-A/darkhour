// Name     : Avlis Persistence System OnModuleLoad
// Purpose  : Initialize APS on module load event
// Authors  : Ingmar Stieger
// Modified : January 27, 2003

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"
#include "inc_bs_module"
#include "team_balance"
#include "x2_inc_switches"
void main()
{
    // Init placeholders for ODBC gateway
    SQLInit();

    SQLExecDirect("SELECT value FROM Settings WHERE name='HALLOWEEN'");
    if (SQLFetch() == SQL_SUCCESS)
    {
        SetLocalInt(GetModule(), "Halloween", StringToInt(SQLGetData(1)));
    }
 //Custom aw spellhook for antispam spells from items
SetModuleOverrideSpellscript("aw_spellhook");

//Activate Anti-Dev on server start
SetLocalInt(GetModule(), "noDev", 1);


    //set initial map to halloween if it's halloween
    if (GetLocalInt(GetModule(), "Halloween") == 1)
    {
        SetLocalInt(GetModule(), "nRound", Random(4)+50);
    }
    else
    {
        SetLocalInt(GetModule(), "nRound", Random(TOTAL_ARENAS)+1); //antiworld
    }
    SetRound(); //antiworld
    InitializeModule();  ///antiworld from border sirkmish

    AssignCommand(GetObjectByTag("flagshouter"), DelayCommand(100.0, BalanceTeams()));
 /////////////////////// From Wingery Mod ////////////
        object oMod = GetModule();
    // NWNX!INIT reads the return address and stores it.
    // The persistance functions ALSO use SetLocalString to
    // store their value.  Therefore NWNX!INIT only works
    // when the value is "1".  We set it to "0" so that when
    // the persist functions run, they don't reset the "one
    // true return address"
    SetLocalString(oMod,"NWNX!INIT","1");
    SetLocalString(oMod,"NWNX!INIT","0");
    SetLocalInt(oMod, "MonsterType", 1);
 ////////////////////////////////////////////////////

//// Max Players allowed in the reserved GM/winged gods slots/////
//SetLocalInt(GetModule(), "MaxPlayers", 32);
  //  SQLExecDirect("UPDATE Settings SET value='32' WHERE name='MAXPLAYERS'");

// Start the VCS_Engine loop.
//DelayCommand(30.0f, ExecuteScript("vcs_engine", GetModule()));

// I will set the tokens at loadup not to set them every king conversation
    SetCustomToken(1001, GetName(GetObjectByTag("arena_1")));
    SetCustomToken(1002, GetName(GetObjectByTag("arena_2")));
    SetCustomToken(1003, GetName(GetObjectByTag("arena_3")));
    SetCustomToken(1004, GetName(GetObjectByTag("arena_4")));
    SetCustomToken(1005, GetName(GetObjectByTag("arena_5")));
    SetCustomToken(1006, GetName(GetObjectByTag("arena_6")));
    SetCustomToken(1007, GetName(GetObjectByTag("arena_7")));
    SetCustomToken(1008, GetName(GetObjectByTag("arena_8")));
    SetCustomToken(1009, GetName(GetObjectByTag("arena_9")));
    SetCustomToken(1010, GetName(GetObjectByTag("arena_10")));
    SetCustomToken(1011, GetName(GetObjectByTag("arena_11")));
    SetCustomToken(1012, GetName(GetObjectByTag("arena_12")));
    SetCustomToken(1013, GetName(GetObjectByTag("arena_13")));
    SetCustomToken(1014, GetName(GetObjectByTag("arena_14")));
    SetCustomToken(1015, GetName(GetObjectByTag("arena_15")));
    SetCustomToken(1016, GetName(GetObjectByTag("arena_16")));
    SetCustomToken(1017, GetName(GetObjectByTag("arena_17")));
    SetCustomToken(1018, GetName(GetObjectByTag("arena_18")));
    SetCustomToken(1019, GetName(GetObjectByTag("arena_19")));
    SetCustomToken(1020, GetName(GetObjectByTag("arena_20")));
    SetCustomToken(1021, GetName(GetObjectByTag("arena_21")));
    SetCustomToken(1022, GetName(GetObjectByTag("arena_22")));
    SetCustomToken(1098, GetName(GetObjectByTag("arena_98")));
    SetCustomToken(1100, GetName(GetObjectByTag("arena_100")));
    SetCustomToken(1101, GetName(GetObjectByTag("arena_200")));
    SetCustomToken(1102, GetName(GetObjectByTag("arena_999")));

}
