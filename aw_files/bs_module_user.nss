 ///////////  BS_MODULE_USER
//THIS SCRIPT IS OBSOLETE
#include "inc_bs_module"
#include "inc_custom"
#include "aw_include"

void main()
{
    object oPlayer;
    int nTeam;

    switch (GetUserDefinedEventNumber()) {

    // EVENT_SCAN_PLAYERS
    // Check all players, see if anybody on TEAM_NONE is outside of the Welcome area.
    // If so, send them to the welcome area and wipe all effects.
    //  check Gold Amount
    //
    // Then check for broken parties. Set a team leader if things aren't right.
    case 200 :
    {
        // bScanningPlayers is TRUE while the scan happens.
        // This loop should never start until the previous scan ends.
        if (GetLocalInt(GetModule(), "bScanningPlayers") == FALSE)
        {
            SetLocalInt(GetModule(), "bScanningPlayers", TRUE);
            oPlayer = GetFirstPC();
           while (GetIsObjectValid(oPlayer))
            {
                nTeam = GetPlayerTeam(oPlayer);
                //The Xp Gold Balance Has been moved to: somehwere (search it)
                // CheckXpGoldBalance(oPlayer);

                // If a player is on a team, and his first faction member is not
                // the Team Leader, then we have problems.
                if (GetFirstFactionMember(oPlayer, TRUE) != GetTeamLeader(nTeam)
                    && nTeam != TEAM_NONE)
                {
                    // Is the Team Leader still a valid object, and still on the right team?
                    // If so, add the player
                    // to his party.
                    if (GetIsObjectValid(GetTeamLeader(nTeam)) && nTeam == GetPlayerTeam(GetTeamLeader(nTeam)))
                    {
                        BuildParty(nTeam, oPlayer);
                    }
                    // Otherwise, this player will be the team leader. The next heartbeat
                    // will add everyone to his party.
                    else
                    {
                        SetTeamLeader(nTeam, oPlayer);
                    }
                }
                oPlayer = GetNextPC();
            }
            SetLocalInt(GetModule(), "bScanningPlayers", FALSE);
        }
    }
    break;

    // EVENT_DAWN_HERE
    case 201:
    {
        BroadcastMessage("--------------------");
        BroadcastMessage("Breakfast Time! This round is OVER.");
        EndTheGame();
        SetLocalInt(GetModule(), "nDawnWarning", 0);
        //SetLocalInt(GetObjectByTag("antiworld_npc"), "LastShout", 12);
        }
    break;

    // EVENT_DAWN_WARNING
    case 202:
    {
        BroadcastMessage("Dawn will arrive in one hour!");
        int nDawnWarning = GetLocalInt(GetModule(), "nDawnWarning") + 1;
        SetLocalInt(GetModule(), "nDawnWarning", nDawnWarning);
    }
    break;

    }


}



