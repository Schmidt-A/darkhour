#include "inc_bs_module"
#include "aw_include"
#include "x0_i0_match"
//#include "player_status"

void main()
{
    object oPC = OBJECT_SELF;
    if (!GetIsObjectValid(oPC))
    {
        return;
    }

    object oModule = GetModule();
    int nTimer = GetLocalInt(GetModule(),"timer");

    int nTeam = GetPlayerTeam(oPC);
    string sArea = GetTag(GetArea(oPC));

    //************************SCAN PLAYERS - REBUILD PARTY
    // If a player is on a team, and his first faction member is not the Team Leader, then we have problems.
    if ((GetFirstFactionMember(oPC, TRUE) != GetTeamLeader(nTeam)) && (nTeam != TEAM_NONE))
    {
        if (!GetHasEffect(EFFECT_TYPE_DOMINATED, oPC))
        {
            // Is the Team Leader still a valid object, and still on the right team?
            // If so, add the player to his party.
            if (GetIsObjectValid(GetTeamLeader(nTeam)) && (nTeam == GetPlayerTeam(GetTeamLeader(nTeam))))
            {
                BuildParty(nTeam, oPC);
            }
            // Otherwise, this player will be the team leader. The next heartbeat will add everyone to his party.
            else
            {
                SetTeamLeader(nTeam, oPC);

            }
        }
    }

    //************************EFFY/IMP ATTACK NOTICE
    if (!GetLocalInt(oModule, "DisableAttackNotice"))
    {
        object oVictim = GetAttemptedAttackTarget();
        if (!GetIsPC(oVictim))
        {
            oVictim = GetAttemptedSpellTarget();
        }

        if (GetIsPC(oVictim))
        {
            int nRound = GetLocalInt(GetModule(), "nRound");
            int nLevel = GetHitDice(oPC);
            int nVictimLevel = GetHitDice(oVictim);
            if (abs(nLevel - nVictimLevel) > 5)
            {
                int nVictimTeam = GetPlayerTeam(oVictim);
                if ((nTeam == (3 - nVictimTeam)) && nRound != 999)
                {
                    object TeamFlagger = GetLocalObject(oModule, "oHasFlag_" + IntToString(nVictimTeam));
                    object EnemyFlagger = GetLocalObject(oModule, "oHasFlag_" + IntToString(nTeam));
                    if ((TeamFlagger != oPC) && (EnemyFlagger != oVictim) && (sArea != "arena_100") && !GetIsDead(oVictim))
                    {
                        if (nLevel > nVictimLevel)
                        {
                            SendMessageToGM(GetName(oPC) + " has attacked an effy: " + GetName(oVictim));
                            FloatingTextStringOnCreature(GetName(oVictim) + " is Effortless. Do not attack Effortless.", oPC, FALSE);
                            //SetLocalInt(oPC, "AttackEffy", GetLocalInt(oPC, "AttackEffy") + 1);
                        }
                        else if (!GetLocalInt(oVictim, "Pengy") && !GetLocalInt(oVictim, "UsingBackToCastle") )
                        {
                            SendMessageToGM(GetName(oPC) + " has attacked an imp: " + GetName(oVictim));
                            FloatingTextStringOnCreature(GetName(oVictim) + " is Impossible. Do not attack Impossible.", oPC, FALSE);
                            //SetLocalInt(oPC, "AttackImp", GetLocalInt(oPC, "AttackImp") + 1);
                        }
                    }
                }
            }
        }
    }

    //************************MONK SPEED FIX
    //even though monks still run to fast with haste, this will prevent the 1-level monks from running fast
    if ((nTimer % 5) == 0)
    {
        int nRound = GetLocalInt(GetModule(), "nRound");
        if ((GetLevelByClass(CLASS_TYPE_MONK, oPC) > 0) && (nRound != 999))
        {
            object oTarget = GetAttemptedAttackTarget();
            if (!GetIsPC(oTarget))
            {
                oTarget = GetAttemptedSpellTarget();
            }
            if (!GetIsPC(oTarget)) //toggle haste only while not attacking
            {
                RemoveHaste(oPC);
                if (GetLocalObject(oModule, "oHasFlag_" + IntToString(3 - nTeam)) != oPC)
                {
                    DelayCommand(0.1, ApplyHaste(oPC));
                }
            }
        }
    }

    //************************AFK BOOT
    if ((nTimer % 10) == 0)
    {
        //HALLOWEEN
        if (GetLocalInt(oModule, "Halloween") == 1)
        {
            float delay = Random(300) / 10.0;
            DelayCommand(delay,FadeToBlack(oPC, FADE_SPEED_FASTEST));
            DelayCommand(delay+0.1+Random(10)/10.0,FadeFromBlack(oPC, FADE_SPEED_FASTEST));
        }

        if (!GetIsDMAW(oPC) && !GetIsGM(oPC) && !GetIsGMNormalChar(oPC) &&
            (GetXP(oPC) < GetXPRequiredForLevel(GetHitDice(oPC)+1)) && //leveling up
            (sArea != "Jail" )) //afk allowed in jail
        {
            location loc = GetLocation(oPC);
            if (loc == GetLocalLocation(oPC, "Location"))
            {
            //int nAction = GetCurrentAction(oPC);
            //if ((nAction == ACTION_INVALID) || IsInConversation(oPC) || (nAction == ACTION_SIT) )
            //{
                int nInactivity = GetLocalInt(oPC,"InvactiveRounds");
                nInactivity++;
                SetLocalInt(oPC,"InvactiveRounds",nInactivity);
                switch (nInactivity)
                {
                case 3:
                    DelayCommand(3.0,FloatingTextStringOnCreature("Message from Server: Please Read",oPC, FALSE));
                    SendMessageToPC(oPC,"You have been inactive (or so it seems), for 3 minutes. You will be 'booted' in 7 minutes if you do not start playing.");
                    break;
                case 5:
                    DelayCommand(3.0,FloatingTextStringOnCreature("Message from Server: Please Read",oPC, FALSE));
                    SendMessageToPC(oPC,"You have been inactive (or so it seems), for 5 minutes. You will be 'booted' in 5 minutes if you do not start playing.");
                    BroadcastMessage(GetName(oPC)+ " Is AFK.");
                    if (GetTag(GetArea(oPC)) != "DuelArea")
                    {
                        RemovePlayerFromTeam(nTeam,oPC);
                        MovePlayerAfk(oPC);
                        DelayCommand(3.0, SetLocalLocation(oPC, "Location", GetLocation(oPC)));
                    }
                    break;
                case 6:
                    DelayCommand(3.0,FloatingTextStringOnCreature("Message from Server: Please Read",oPC, FALSE));
                    SendMessageToPC(oPC,"You have been inactive (or so it seems), for 6 minutes. You will be 'auto-booted' in 4 minutes if you do not start playing.");
                    break;
                case 7:
                    DelayCommand(3.0,FloatingTextStringOnCreature("Message from Server: Please Read",oPC, FALSE));
                    SendMessageToPC(oPC,"You have been inactive (or so it seems), for 7 minutes. You will be 'auto-booted' in 3 minutes if you do not start playing.");
                    break;
                case 8:
                    DelayCommand(3.0,FloatingTextStringOnCreature("Message from Server: Please Read",oPC, FALSE));
                    SendMessageToPC(oPC,"You have been inactive (or so it seems), for 8 minutes. You will be 'auto-booted' in 2 minutes if you do not start playing.");
                    break;
                case 9:
                    DelayCommand(3.0,FloatingTextStringOnCreature("Message from Server: Please Read",oPC, FALSE));
                    SendMessageToPC(oPC,"You have been inactive (or so it seems), for 9 minutes. You will be 'auto-booted' in 1 minute if you do not start playing.");
                    break;
                case 10:
                    BroadcastMessage(GetName(oPC)+ " was auto-booted for inactivity, though they may rejoin when they wish.");
                    //WriteTimestampedLogEntry(GetName(oPC) + " | " + GetPCPlayerName(oPC) +  " was auto-booted for inactivity.");
                    BootPC(oPC);
                    break;
                }
            }
            else
            {
                SetLocalLocation(oPC, "Location", loc);
                SetLocalInt(oPC,"InvactiveRounds",0);
            }
        }
    }
}
