#include "inc_bs_module"
#include "aw_include"
#include "inc_array"

//TEAM BALANCING

//returns constant that is opposite to nTeam
int GetEnemyTeam(int nTeam);

struct TeamCount
{
    int Good;
    int Evil;
};

//returns modified count of players on each team in range of oCurPC based on level differences
struct TeamCount GetInRangeCount(object oCurPC);

int GetTeamInRangeCount(int nTeam, struct TeamCount Count);

//returns an array of PCs who are = nLevel, except those with already "Matched" localint
//must call DeleteArray after done with list
string GetSortedPlayerList(int nLevel1, int nLevel2 = 40, int bWeighted = FALSE, object oCurPC = OBJECT_INVALID);

//returns 0 or FALSE if nobody in range
//to be used on castle exit door, returns TRUE if player can continue to arena
int CheckHasEnemyInRange(object oPC);

//Adds a player to a team using the balancing algorithm #2
//intended to be onuse welcomedoor
//int AddPlayerToBalancedTeam(object oPC);

//simply separates players by alternating level
void BalanceTeams();

//checks if object is player, not special GM and on valid team
int GetIsPlayerValid(object oPC);

//returns constant that is opposite to nTeam
int GetEnemyTeam(int nTeam);

int GetPlayerWeight(object oPC);

void CheckPlayerBalance(object oPC);


void DeleteAllInt(string sName)
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        DeleteLocalInt(oPC, sName);
        oPC = GetNextPC();
    }
}
//checks if object is player, not special GM and on valid team
int GetIsPlayerValid(object oPC)
{
    int nTeam = GetPlayerTeam(oPC);
    return (GetIsPC(oPC) && !GetIsGM(oPC) && !GetIsDMAW(oPC) &&
            ((nTeam == TEAM_GOOD) || (nTeam == TEAM_EVIL))
           );
}

//returns constant that is opposite to nTeam
int GetEnemyTeam(int nTeam)
{
    if (nTeam == TEAM_GOOD) { return TEAM_EVIL; }
    else if (nTeam == TEAM_EVIL) { return TEAM_GOOD; }
    else { return TEAM_NONE; }
}


int GetPlayerWeight(object oPC)
{
    int nKills = GetLocalInt(oPC, "m_nKills");
    int nDeaths = GetLocalInt(oPC, "m_nDeaths");
    int nScore = GetLocalInt(oPC, "nScore");
    int nWeight = 0;
    if (nKills > FloatToInt(nDeaths * 1.5))
    {
        nWeight = nKills / Max(3, nDeaths);
    }
    else if (nDeaths > FloatToInt(nKills * 1.5))
    {
        nWeight = -nDeaths / Max(3, nKills);
    }

    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 10)
    {
        nWeight++;
    }

    nWeight += nScore / 25;

    nWeight = Min(5, Max(-5, nWeight));

    return nWeight;
}

//returns all objects same level as nLevel, not including oCurPC
string GetSortedPlayerList(int nLevel1, int nLevel2 = 40, int bWeighted = FALSE, object oCurPC = OBJECT_INVALID)
{
    string PCs = arCreateArray();
    int nLevel;
    if ((nLevel2 == 40) && (nLevel1 < 40)) //allow default to return only 1 level
    {
        nLevel2 = nLevel1;
    }
    string sName;
    int nCount;
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        if (GetIsPlayerValid(oPC) && (oPC != oCurPC))
        {
            nLevel = GetHitDice(oPC);

            if (bWeighted)
            {
                nLevel += GetPlayerWeight(oPC);
                nLevel = Min(40, Max(10, nLevel));
            }

            if ((nLevel <= nLevel1) && (nLevel >= nLevel2))
            {
                sName = PCs + IntToString(nLevel);
                nCount = GetLocalInt(OBJECT_SELF, sName);
                SetLocalObject(OBJECT_SELF, sName + IntToString(nCount), oPC);
                SetLocalInt(OBJECT_SELF, sName, nCount+1);
            }
        }
        oPC = GetNextPC();
    }

    nCount = 0;
    int nSubCount;
    int i;
    for (nLevel = nLevel1; nLevel >= nLevel2; nLevel--)
    {
        sName = PCs + IntToString(nLevel);
        nSubCount = GetLocalInt(OBJECT_SELF, sName);
        DeleteLocalInt(OBJECT_SELF, sName);
        for (i = 0; i < nSubCount; i++)
        {
            SetLocalObject(OBJECT_SELF, PCs + IntToString(nCount), GetLocalObject(OBJECT_SELF, sName + IntToString(i)));
            DeleteLocalObject(OBJECT_SELF, sName + IntToString(i));
            nCount++;
        }
    }

    SetLocalInt(OBJECT_SELF, PCs, nCount);

    return PCs;
}

struct TeamCount GetInRangeCount(object oCurPC)
{
    int nCurLevel = GetHitDice(oCurPC);
    struct TeamCount Count;
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        int nTeam = GetPlayerTeam(oPC);
        int nDiff = GetHitDice(oPC) - nCurLevel;
        if (GetIsPlayerValid(oPC) && (oCurPC != oPC) && (abs(nDiff) <= 5))
        {
            if (nTeam == TEAM_GOOD)
            {
                Count.Good++;
            }
            else if (nTeam == TEAM_EVIL)
            {
                Count.Evil++;
            }
        }
        oPC = GetNextPC();
    }
    return Count;
}

int GetTeamInRangeCount(int nTeam, struct TeamCount Count)
{
    if (nTeam == TEAM_GOOD)
    {
        return Count.Good;
    }
    else if (nTeam == TEAM_EVIL)
    {
        return Count.Evil;
    }
    else
    {
        return 0;
    }
}
//returns 0 or FALSE if nobody in range
//to be used on castle exit door, returns TRUE if player can continue to arena
int CheckHasEnemyInRange(object oPC)
{
    struct TeamCount Count = GetInRangeCount(oPC);
    int nTeam = GetPlayerTeam(oPC);
    if (GetTeamInRangeCount(GetEnemyTeam(nTeam), Count) > 0)
    {
        return TRUE; //there is at least 1 enemy in range, allow to enter arena
    }

    if (nTeam == TEAM_NONE)
    {
        return FALSE; //(Count.Good + Count.Evil) //not on team.. do not allow to enter arena
    }

    if (GetTeamInRangeCount(nTeam, Count) > 0) //you have an ally in range, but no enemies
    {
        if ((GetTeamCount(nTeam) - GetTeamCount(GetEnemyTeam(nTeam))) >= -1)
        {
            //switch
            SendMessageToAllDMs("DEBUG [CheckHasEnemyInRange]: " + GetName(oPC) + " has been switched");
            DelayCommand(0.1, RemovePlayerFromTeam(nTeam, oPC));
            DelayCommand(0.3, AddPlayerToTeam(GetEnemyTeam(nTeam), oPC));
            DelayCommand(0.5, MovePlayerToSpawn(oPC));
            DelayCommand(2.0, FloatingTextStringOnCreature("You have been switched to balance teams, please do not try to change back", oPC, FALSE));
            SetLocalInt(oPC, "TeamChangeBanned", TRUE);
            DelayCommand(120.0, DeleteLocalInt(oPC, "TeamChangeBanned")); //1 game hour
            return FALSE;
        }
        else //do not switch if it will lock doors
        {

            if  (GetTag(GetArea(oPC)) != "EvilCastle" && GetTag(GetArea(oPC)) != "GoodCastle")
                DelayCommand(3.0, MovePlayerToSpawn(oPC));
            SendMessageToAllDMs("DEBUG [CheckHasEnemyInRange]: " + GetName(oPC) + " has no enemy in range and cannot auto-switch");
            FloatingTextStringOnCreature("There is no enemy currently in your range", oPC, FALSE);
            return FALSE;
        }
    }
    else //you have no one in your range
    {
        if  (GetTag(GetArea(oPC)) != "EvilCastle" && GetTag(GetArea(oPC)) != "GoodCastle")
            DelayCommand(3.0, MovePlayerToSpawn(oPC));
        SendMessageToAllDMs("DEBUG [CheckHasEnemyInRange]: " + GetName(oPC) + " has no one in range");
        FloatingTextStringOnCreature("There is no one currently in your range", oPC, FALSE);
        return FALSE;
    }
}

void BalanceTeams()
{
    BroadcastMessage("<c^&À>*****Teams are being auto-balanced*****</c>");

    object oPC;
    object oPCMatch;
    object oPCMatch2;
    object oMod = GetModule();

    int iPCMatch;
    int iPCMatch2;
    int nLevel;
    int nTeam;

    float fDelay = 0.1; //stagger delays
    string PCs = GetSortedPlayerList(40, 10, TRUE);
    int i;
    int j;
    int nCount = arGetCount(PCs);
    for (i = 0; i < nCount; i++)
    {
        oPC = arGetObject(PCs, i);

        if (GetIsObjectValid(oPC))
        {
            nLevel = GetHitDice(oPC);
            nTeam = GetPlayerTeam(oPC);
            iPCMatch = -1;
            iPCMatch2 = -1;
            oPCMatch = OBJECT_INVALID;
            oPCMatch2 = OBJECT_INVALID;

            // WriteTimestampedLogEntry("DEBUG: [BalanceTeams]: Processing " + GetName(oPC));

            for (j = i+1; j < nCount; j++)
            {
                oPCMatch = arGetObject(PCs, j);
                if (GetIsObjectValid(oPCMatch))
                {
                    // WriteTimestampedLogEntry("DEBUG: [BalanceTeams]: Checking match " + GetName(oPCMatch));
                    if (abs(GetHitDice(oPCMatch) - nLevel) <= 5)
                    {
                        if (iPCMatch == -1) //record first valid match as backup
                        {
                            oPCMatch2 = oPCMatch;
                            iPCMatch2 = j;
                        }

                        if (GetPlayerTeam(oPCMatch) != nTeam)
                        {
                            // WriteTimestampedLogEntry("DEBUG: [BalanceTeams]: Found match #1: "+GetName(oPCMatch));
                            iPCMatch = j; //we have a match!
                            j = nCount; //I don't think break is working as expected
                        }
                    }
                    else
                    {
                        // WriteTimestampedLogEntry("DEBUG: [BalanceTeams]: Out of range: "+GetName(oPCMatch));
                        j = nCount; //i don't think break is working as expected
                    }
                }
            }

            if (iPCMatch2 > -1)
            {
                if ((iPCMatch > -1) &&
                    (abs((GetHitDice(oPCMatch2)+GetPlayerWeight(oPCMatch2)) -
                         (GetHitDice(oPCMatch) +GetPlayerWeight(oPCMatch))) <= 1) )
                {
                    // WriteTimestampedLogEntry("DEBUG: [BalanceTeams]: Matched: " + GetName(oPC) + " and " + GetName(oPCMatch));
                    arDeleteObject(PCs, iPCMatch);
                }
                else
                {
                    //matched with iPCMatch2
                    arDeleteObject(PCs, iPCMatch2);

                    if (GetLocalObject(oMod, "oHasFlag_" + IntToString(GetEnemyTeam(nTeam))) == oPC)
                    {
                        DelayCommand(fDelay, DropFlag(oPC)); fDelay += 0.2;
                        DelayCommand(fDelay, RemoveFlagEffect(oPC)); fDelay += 0.2;
                    }
                    DelayCommand(fDelay, RemovePlayerFromTeam(nTeam, oPC)); fDelay += 0.2;
                    DelayCommand(fDelay, AddPlayerToTeam(GetEnemyTeam(nTeam), oPC)); fDelay += 0.2;
                    DelayCommand(fDelay, MovePlayerToSpawn(oPC)); fDelay += 0.2;
                    DelayCommand(2.0 + fDelay, FloatingTextStringOnCreature("You have been automatically switched to balance teams, please do not try to change back", oPC, FALSE)); fDelay += 0.2;
                    // WriteTimestampedLogEntry("DEBUG: [BalanceTeams]: " + GetName(oPC) + " has been switched to match " + GetName(oPCMatch2));
                    SetLocalInt(oPC, "TeamChangeBanned", TRUE);
                    DelayCommand(120.0, DeleteLocalInt(oPC, "TeamChangeBanned")); //1 game hour
                }
            }
            else
            {
                struct TeamCount Count = GetInRangeCount(oPC); //double check, maybe someone in range, just not matching
                if ((Count.Good + Count.Evil) == 0)
                {
                    FloatingTextStringOnCreature("There is no enemy currently in your range", oPC, FALSE);
                    SendMessageToAllDMs("DEBUG [BalanceTeams]: " + GetName(oPC) + " has no one in range");
                    //WriteTimestampedLogEntry("DEBUG [BalanceTeams]: " + GetName(oPC) + " has no one in range");
                }
                else
                {
                    SendMessageToAllDMs("DEBUG [BalanceTeams]: " + GetName(oPC) + " cannot be matched");
                    // WriteTimestampedLogEntry("DEBUG [BalanceTeams]: " + GetName(oPC) + " cannot be matched");
                }
            }
        }
    }
    arDeleteArray(PCs);
}

//Adds a player to a team using the balancing algorithm #2
/*
int BalancePlayerByWeight(object oPC)
{
    struct TeamCount Count = GetInRangeCount(oPC, TRUE);
    int nCurTeam = GetPlayerTeam(oPC);
    int nTeam = TEAM_NONE;
    if (Count.Good < Count.Evil) nTeam = TEAM_GOOD;
    else if (Count.Good > Count.Evil) nTeam = TEAM_EVIL;
    else if (((Count.Good + Count.Evil) == 0) &&
             (GetLocalInt(GetModule(), "nRound") != 0))
    {
        WriteTimestampedLogEntry("DEBUG: No one in range for " + GetName(oPC) + " (" + IntToString(GetHitDice(oPC)) + ")");
        SendMessageToAllDMs("DEBUG: No one in range for " + GetName(oPC) + " (" + IntToString(GetHitDice(oPC)) + ")");
        if (nCurTeam == TEAM_NONE)
        {
            AddPlayerToTeam(TEAM_GOOD, oPC); //doesn't really matter which team we add to, does it?
            DelayCommand(0.5,MovePlayerToSpawn(oPC));
        }
        //FloatingTextStringOnCreature("There is no one in your range currently playing.", oPC, FALSE);
        //no one in range
        return FALSE;
    }

    if (nCurTeam != nTeam)
    {
        if (nCurTeam != TEAM_NONE)
        {
            FloatingTextStringOnCreature("You have been switched to balance teams, please do not try to change back", oPC, FALSE);
            WriteTimestampedLogEntry("DEBUG: Switching " + GetName(oPC) + " (" + IntToString(GetHitDice(oPC)) + (GetPlayerTeam(oPC) == TEAM_GOOD ? "g" : (GetPlayerTeam(oPC) == TEAM_EVIL ? "e" : "n")) + ") Good: " + IntToString(Count.Good) + " Evil: " + IntToString(Count.Evil));
            SendMessageToAllDMs("DEBUG: Switching " + GetName(oPC) + " (" + IntToString(GetHitDice(oPC)) + (GetPlayerTeam(oPC) == TEAM_GOOD ? "g" : (GetPlayerTeam(oPC) == TEAM_EVIL ? "e" : "n")) + ") Good: " + IntToString(Count.Good) + " Evil: " + IntToString(Count.Evil));
            RemovePlayerFromTeam(nCurTeam, oPC);
        }

        SendMessageToAllDMs("DEBUG: Adding " + GetName(oPC) +  " (" + IntToString(GetHitDice(oPC)) + ") to " + (nTeam == TEAM_GOOD ? "good" : "evil") + " team.");
        AddPlayerToTeam(nTeam, oPC);
        DelayCommand(0.5,MovePlayerToSpawn(oPC));
        return TRUE;
    }

    return FALSE;
}
*/

//assuming called only when player is in castle on respawn
void CheckPlayerBalance(object oPC)
{
    int nTeam = GetPlayerTeam(oPC);
    if ((GetTeamCount(GetEnemyTeam(nTeam)) - GetTeamCount(nTeam)) > 1)
    {
        return; //don't bother if enemy team has more players, so as not to close doors
    }

    object oMod = GetModule();
    //if (enemy > (allies + 15))
    if (GetLocalInt(oMod, "nScore_" + IntToString(GetEnemyTeam(nTeam))) > (GetLocalInt(oMod, "nScore_" + IntToString(nTeam)) + 15))
    {
        return; //don't bother if current team is losing (i.e. enemy is winning)
    }

    if ((GetLocalInt(oPC, "nScore") - GetLocalInt(oPC, "nLastSwitchScore")) < 15) //at start of round this will be 0
    {
        return; //don't bother if player has low score
    }
    SetLocalInt(oPC, "nLastSwitchScore", GetLocalInt(oPC, "nScore"));

    if (GetLocalInt(oPC, "m_nDeaths") >= GetLocalInt(oPC, "m_nKills"))
    {
        return; //don't bother if player has more deaths than kills
    }

    if (GetPlayerWeight(oPC) < 2)
    {
        return;
    }

    //if ((nAllies < 1) || (Enemies > Allies))
    struct TeamCount Count = GetInRangeCount(oPC);
    //int GetTeamInRangeCount(int nTeam, struct TeamCount Count)
    if ((GetTeamInRangeCount(nTeam, Count) < 2) || //minimum of 2 allies
        (GetTeamInRangeCount(GetEnemyTeam(nTeam), Count) > GetTeamInRangeCount(nTeam, Count)) )
    {
        return; //don't bother if current team already has too few players in range
    }

    //passed all filters, safe to switch
    SendMessageToAllDMs("DEBUG [CheckPlayerBalance]: " + GetName(oPC) + " has been switched");
    DelayCommand(1.0, RemovePlayerFromTeam(nTeam, oPC));
    DelayCommand(1.2, AddPlayerToTeam(GetEnemyTeam(nTeam), oPC));
    DelayCommand(2.0, MovePlayerToSpawn(oPC));
    DelayCommand(4.0, FloatingTextStringOnCreature("You have been switched automatically to balance teams, please do not try to change back", oPC, FALSE));
    SetLocalInt(oPC, "TeamChangeBanned", TRUE);
    DelayCommand(120.0, DeleteLocalInt(oPC, "TeamChangeBanned")); //1 game hour
}

