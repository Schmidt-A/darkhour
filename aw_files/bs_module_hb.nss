//::///////////////////////////////////////////////
//:: BS_MODULE_HB
//::
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fires OnHeartbeat for the module.

    If you're going to optimize anything in the
    module, this is it.
*/
//:://////////////////////////////////////////////
//:: Created By: Erich Delcamp
//:: Created On: Jul/01/02
//:://////////////////////////////////////////////

#include "inc_bs_module"
#include "aw_include"
#include "aps_include"
#include "inc_custom"
#include "team_balance"
#include "player_status"

void main()
{
    //module starts at
    object oModule = GetModule();
    int nTimer = GetLocalInt(oModule, "timer");

    if (nTimer == 2147483640) { nTimer = 0; }

    //************************DAWN WARNING
    if (GetTimeHour() == 5 && GetLocalInt(oModule, "nDawnWarning") < 3)
    {
        BroadcastMessage("Dawn will arrive in one hour!");
        SetLocalInt(oModule, "nDawnWarning", GetLocalInt(oModule, "nDawnWarning") + 1);
        SetLocalInt(oModule, "TeamChangeBanned", 1);
    }

    if (GetTimeHour() == 2)
    {
        SetLocalInt(oModule, "NearEndOfRound", TRUE);
    }
    //************************END OF ROUND
    // Check if it's dawn, or if we're getting close. Shout the warning three
    // times at 5am. When it's dawn, end the current round.
    if (GetTimeHour() == 6) //EndTheGame sets the Hour to 12
    {
        GetVotedRound();
        BroadcastMessage("--------------------");
        BroadcastMessage("Breakfast Time! This round is OVER.");
        EndTheGame();
        SetLocalInt(oModule, "nDawnWarning", 0);
        SetLocalInt(oModule, "TeamChangeBanned", 0);
        SetLocalInt(oModule, "NearEndOfRound", FALSE);
        if (GetLocalInt(oModule, "TeamBalance"))
        {
            DelayCommand(60.0, BalanceTeams());
            DelayCommand(100.0, BalanceTeams());
        }
        SetLocalInt(oModule, "RoundEnded", TRUE);

        //ExecuteScript("current_map", OBJECT_SELF);
    }

    //************************FLAG CHECK
    // Check if the flags are held by invalid objects. If so, send the flag home.
    //the invalid object is a player logged out, this HB replace the onclient exit
    if (GetIsObjectValid(GetLocalObject(oModule, "oHasFlag_1")) == FALSE)
    {
        FlagDestroyed(TEAM_GOOD);
    }

    if (GetIsObjectValid(GetLocalObject(oModule, "oHasFlag_2")) == FALSE)
    {
        FlagDestroyed(TEAM_EVIL);
    }

    //************************FLAG CHECK
    if ((nTimer % 20) == 0)
    {
        //we can check if the flag is in the current area or not..
        //nb if the flag is on a valid object = dropped invis placeable
        //for Bugged char who have it but it don't show this will be checked on ScanPlayers
        //nRound is Zero in the 2 minutes pause...
        int nRound = GetLocalInt(oModule, "nRound");
        object oHasFlag = (GetLocalObject(oModule, "oHasFlag_1"));
        if (GetTag(GetArea(oHasFlag)) != "arena_"+IntToString(nRound) &&  nRound != 0)
        {
            RemoveFlag(oHasFlag);
        }
        oHasFlag =  GetLocalObject(oModule, "oHasFlag_2");
        if (GetTag(GetArea(oHasFlag)) != "arena_"+IntToString(nRound) &&  nRound != 0)
        {
            RemoveFlag(oHasFlag);
        }
    }

    //************************PLAYER STATUS
    //interval must match the UpdatePlayerStatus in bs_player_hb
    if ((nTimer % 5) == 0)
    {
        SQLExecDirect("TRUNCATE TABLE `player_status`");
        SQLExecDirect("UPDATE Settings SET value = " + IntToString(GetLocalInt(oModule, "nScore_" + IntToString(TEAM_EVIL))) +
                      " WHERE name = 'EVIL_TEAM_SCORE'");
        SQLExecDirect("UPDATE Settings SET value = " + IntToString(GetLocalInt(oModule, "nScore_" + IntToString(TEAM_GOOD))) +
                      " WHERE name = 'GOOD_TEAM_SCORE'");

    }

    //************************RULES SHOUTING
    if ((nTimer % 40) == 0)
    {
        ExecuteScript("aw_rule_heartb", GetObjectByTag("antiworld_npc"));
    }

    int nActiveRound = GetLocalInt(oModule, "nRound");
    //************************PLAYER HEARTBEAT
    object oPC = GetFirstPC();
    float fDelay;
    int nTotalPlayers = 0;
    while (GetIsObjectValid(oPC))
    {
        if (GetIsPC(oPC))
        {
            if ((nTimer % 5) == 0)
            {

            //************************PLAYER STATUS
                UpdatePlayerStatus(oPC); //timer has to match in bs_module_hb

                SetLocalInt(oPC, "LastTimer", nTimer);
                SetLocalInt(oPC, "LastRound", nActiveRound);
                DeleteLocalInt(oPC, "LoopTest");
            }

            DelayCommand(fDelay, ExecuteScript("bs_player_hb", oPC));
            fDelay += 0.15;
            nTotalPlayers++;
        }
        oPC = GetNextPC();
    }

    SQLExecDirect("UPDATE Settings SET value='" + IntToString(nTotalPlayers) + "' WHERE name='TOTALPLAYERS'");

    DeleteLocalInt(oModule, "RoundEnded");

    //************************INCREMENT TIMER
    SetLocalInt(oModule,"timer",nTimer+1);
}


