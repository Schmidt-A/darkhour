// This script fires the rest conversation for the dark hour module.
// As soon as the PC chooses to rest, his resting is cancelled and the
// conversation pops up. This is set to NOT fire when the PC chooses to rest from
// the rest conversation.

// The script will terminate resting if the player has rested within the hour of
// his last rest session.

// Created by Zunath on August 2, 2007
// Edited by Vision on September 15, 2007 (Several times)
// Edited by Tweek Jan 2016 (once)

#include "_incl_pc_data"

void StartRestConversation(object oPC)
{
    int iZombieKills    = PCDGetZombieKills(oPC); 
    int iSurvivalTime   = PCDGetSurvivalTimes(oPC);
    int iFrenzyKills    = PCDGetFrenzyKills(oPC);
    int iCurrentHour    = GetTimeHour();

    // Apparently we get one survival time token every 8 hours
    string sSurvivalTime = IntToString(iSurvivalTime * 8);

    SetCustomToken(900, IntToString(iZombieKills));
    SetCustomToken(901, IntToString(iCurrentHour));
    if (iCurrentHour = 0)
        SetCustomToken(901, "<cþ  >DARK HOUR</c>");
    SetCustomToken(902, sSurvivalTime + " Hours");
    SetCustomToken(903, IntToString(iSurvivalTime));
    SetCustomToken(904, IntToString(iFrenzyKills));

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionStartConversation(oPC, "dh_rest_convo", TRUE, FALSE));
}

void main()
{
    object oPC = GetLastPCRested();
    object oRestObject = GetNearestObjectByTag("DH_RESTOBJ", oPC);
    int iRestType = GetLastRestEventType();

    //The player is not resting, and the player is trying to rest...
    if (GetLocalInt(oPC, "IS_RESTING") == 0
            && iRestType == REST_EVENTTYPE_REST_STARTED)
    {
        StartRestConversation(oPC);
    }

    // The player is beyond 5m from a bed roll but is set to rest mode...
    // Tweek: wtf is rest mode
    else if (GetDistanceBetween(oRestObject, oPC) > 5.0 &&
             GetLocalInt(oPC, "IS_RESTING") == 1)
    {
        //I cannot rest because I am beyond the range of a bedroll
        SetLocalInt(oPC, "IS_RESTING", 0);

        StartRestConversation(oPC);
    }
    // Tweek: Got rid of the rest limit case becase it never seems to be set.
}
