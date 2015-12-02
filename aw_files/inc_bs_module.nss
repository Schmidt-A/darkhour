#include "inc_rules"

// Event Constants

// This event is sent by the module heartbeat.
// It's an attempt to optimize the heartbeat script so that
// it will never take more than 6 seconds to run.
int EVENT_SCAN_PLAYERS = 200;
int EVENT_DAWN_HERE    = 201;
int EVENT_DAWN_WARNING = 202;
int EVENT_SHOUT_RULES = 203;

//amount of xp POINTS per event
int TOW_LINK_CAPTURED = 250;
int TOW_AVATAR_CAPTURED = 1000;
int TOW_DESTROY_LINK = 150;

// Player Constants
float RESPAWN_TIMER = 8.0;
int DAILY_TRAP_LIMIT = 80;
int TEAMKILL_LIMIT = -10;   // This is the score at which players are booted, -2 points per teamkill.

// Reward Constants -- the actual reward is REWARD_* multiplied by the HitDice of the player.
int REWARD_WINNERS = 80; //unused
int REWARD_TEAM_WINNERS = 40; //unused
int REWARD_XP_WINNERS = 60; //RewardCapture
int REWARD_XP_TEAM_WINNERS = 15; //RewardTeamKill
int REWARD_LOSERS = 0; //unused
int REWARD_KILLER = 50; //RewardKill
int REWARD_TEAMKILLER = 100; //unused Actually a penalty, if you're not a sarcastic person.
int REWARD_MVM =200;
int REWARD_MVM_TEAM =150;
int PLAYERS_EASY_KILL_CONSTANT = 5;

// Team Constants
const int TEAM_NONE = 0;
const int TEAM_GOOD = 1;
const int TEAM_EVIL = 2;
const int NUM_TEAMS = 2;
const int NO_TEAM = 3;

//MAPS Constant
int TOTAL_ARENAS = 21;

// Team Functions
void     AddPlayerToTeam( int nTeam, object oPlayer );
int      GetPlayerTeam( object oPlayer);
string   GetTeamName( int nTeam);
string   GetTeamColour( int nTeam);
int      ChooseTeam(object oPlayer);
void     BuildParty(int nTeam, object oPlayer);
void     SetTeamLeader(int nTeam, object oPlayer);
object   GetTeamLeader(int nTeam);
//the Flag will be removed and sent home, before remove the player from the team
void     RemovePlayerFromTeam(int nTeam, object oPlayer);


// Rule Constants
int RULE_ALLOWED_COST       = 0;
int RULE_ALLOWED_LEVEL      = 1;
int RULE_NUM_TEAMS          = 2;
int RULE_NUM_GAMES          = 3;



// Module Options -- Currently using only
// OPTION_ALLOWED_ITEM_COST
// OPTION_ALLOWED_LEVEL
// Number of teams doesn't matter...2 (plus TEAM_NONE) is hardcoded everywhere.
int OPTION_ALLOWED_ITEM_COST        = 0;
int OPTION_ALLOWED_LEVEL            = 1;
int OPTION_RANDOM_START_LOC         = 2;
int OPTION_NUM_TEAMS                = 3;
int OPTION_NUM_GAMES                = 4;



// Game Initialization Functions
void RemoveAllPlotItems( object oPlayer );
void InitializeModule();
void RestartModule();
void IntializePlayerForGame( object oPlayer );
void ReimburseGoldToPlayer( object oPlayer );
void SetRound();
void GetVotedRound();
void ResetMapVote();

// Game Specific Functionality
void    PickupFlag(object oPlayer, object oFlagHolder);
void    FlagDestroyed(int nFlagTeam);
void    DropFlag(object oPC);
void    RemoveAllGoldFromPlayer( object oPlayer );
//Removes all effect that have been applied by a PC ( not to remove Haste or those)
void    RemoveAllEffects( object oPlayer );
void    ApplyFlagEffect( object oPlayer );
void    RemoveFlagEffect( object oPlayer );
void    RewardCapture(int nTeam, object oCapturingPlayer);
void    BroadcastMessage( string sMessage, int nTeam = 0);
void    MovePlayerToSpawn( object oPlayer);
void    MovePlayerToArena(object oPlayer);
void    MovePlayerAfk( object oPlayer);
void    MovePlayerToJail(object oPlayer);
void    MoveMeToLocation (location lLoc);
int     GetIsEnemyTeam (object oTarget, object oMe);
void    IncrementTeamCount(int nTeam, int nAdjust);
int     GetTeamCount(int nTeam);
int     GetTeamTotalLevel(int nTeam);
void    LockCastleDoors();
void    UnlockCastleDoors();
//decrease pm ac depending on how many lvls
void PmACDecrease(object oPC);

// int nSpawn: TRUE=resurrect and MovePlayerToSpawn, FALSE= resurrect in place and stop
void    RespawnPlayer(object oPlayer, int nSpawn);
int     GetTrapsAcquired(object oPlayer);
void    SetTrapsAcquired(object oPlayer, int nTraps);
void    CleanTheGame();
void    CleanStores();
//this also unlock doors
void    DisableTrapsInArea(object oArea, int nChance);
void    CleanDroppedItems(object oArea);
void    CheckTeamBalance();
void    SetPlayersNeeded(int nPlayers, int nTeam);
int     GetPlayersNeeded();
int     GetWeakTeam();
void    ApplyHaste(object oPlayer);
void    RemoveHaste(object oPlayer);
// RemoveAllEffects()+  ApplyHaste() + ApplyTumble()+ toggle Slow()+toggle Darkness()
void ToggleAllStuff(object oPlayer);
//15 for guaranteed tumble, and +7 +3 to counteract heavy armor and shield penalties
void ApplyTumble(object oPlayer);
void PlayBellSound();
int GetIsHasted(object oPlayer);
//Return true if  the two players are into allowed kill range.
int  GetKillRangeResult(object oPC, object oPlayer);
// Store as local Object on the GM the selected player = to be used only from the GameMaster conversation
void SelectPlayer(object oGM,int nNumber);

// Game State Functionality
void SetGameStarted( int bGameStarted );
int  GetGameStarted();

void EndTheGame(int bRestarting = FALSE);
void IncrementNumGamesPlayed();

//void RewardWinningTeam(int nTeam);
void AddTeamScore(int nTeam, int nScore = 1);
void AddPlayerScore(object oPlayer, int nScore);

int Min(int val1, int val2);
int Max(int val1, int val2);


//TOW functions
void TOW_BroadcastMessage(string sString);
void TOW_AddTeamScore(int nTeam, int nScore);
void RewardTugOfWar(int nReward, object oPC, int nTeam, int nScore);
void RemoveAllBeams(object oObject);
void StartAvatars();
void ResetTugOfWar(object oAvatar);
void EndTugOfWar(int nRound);
//////////////////////////////////////////////////////////////
// InitializeModule()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Edited By Jantima
// Created On: Jun/27/02
// Description: Initialize the module at start.
//////////////////////////////////////////////////////////////
void InitializeModule()
{
    object oModule =  GetModule();
    SetLocalInt(oModule, "nScore_1", 0);
    SetLocalInt(oModule, "nScore_2", 0);
    SetLocalInt(oModule, "nTeamCount_1", 0);
    SetLocalInt(oModule, "nTeamCount_2", 0);
    SetLocalInt(oModule, "bEncounters", FALSE);
    SetLocalInt(oModule, "noDev",1);
    //Reset All Arenas Local Int for voting Points
    int nMap = 1;
    for(nMap;nMap <= TOTAL_ARENAS; nMap++)
    {
    SetLocalInt(oModule, "map"+IntToString(nMap), 0);
    }
    SetLocalInt(oModule, "map50", 0);    //50 51 52 53 reserved for halloween or to be replaced from the halloween maps that are ready and working
    SetLocalInt(oModule, "map98", 0);    // KING OF THE HILL
    SetLocalInt(oModule, "map100", 0);    //Sudden Death

    //riddler 2007-4-25 turn off expertise while casting
    SetModuleSwitch("X2_L_STOP_EXPERTISE_ABUSE",TRUE);

}



//////////////////////////////////////////////////////////////
// ResetMapVote()
//////////////////////////////////////////////////////////////
// Created By:  Jantima
// Created On: April/8/04
// Description: Reset the map vote.
//////////////////////////////////////////////////////////////
void ResetMapVote()
{
    int nMap;
    object oModule =  GetModule();
    for(nMap= 1;nMap <= TOTAL_ARENAS ; nMap++)
    {
    SetLocalInt(oModule, "map"+IntToString(nMap), 0);
    }
    SetLocalInt(oModule, "map50", 0);    //halloween reserved
    SetLocalInt(oModule, "map98", 0);    // KING OF THE HILL
    SetLocalInt(oModule, "map100", 0);    //Sudden Death
    SetLocalInt(oModule, "map200", 0);    //PushOfWar
    if (GetLocalInt(GetModule(), "InfiniteHunt") != 1)
    {
    SetLocalInt(oModule, "map999", 0);    //Hunt
    }


}

////////////////////////////////////////////
//// void GetVotedRound();
///////////////////////////////////////
// Created By: Jantima
// Created On: April/07/04
// Modified By: Nilas_87
// MOdified On: Nov/09/04
// Description: Get the most voted map.
/////////////////////////////////////////
void GetVotedRound()
{
    int MostVotateMap = 0;
    int i;
    object oModule =GetModule();
    int LastMap = GetLocalInt(oModule, "nRound");
    SetLocalInt(oModule,"LastMap",LastMap);
     ////this is where it count every vote for every voted maps
    for ( i=1; i<=TOTAL_ARENAS; i++ ) ///where 20 is the number of maps
    {
        int nVotes = GetLocalInt(oModule,"map"+IntToString(i));
        if(nVotes > MostVotateMap)
        {
            if ( i != LastMap)
            MostVotateMap = i;
            //SendMessageToAllDMs("Area "+GetName(GetObjectByTag("arena_"+IntToString(i)))+" had :"+IntToString(nVotes)+" votes.");
        }
    }
    //SendMessageToAllDMs("Most voted Map was: "+GetName(GetObjectByTag("arena_"+IntToString(MostVotateMap)))+" With :"+IntToString(GetLocalInt(oModule,"map"+IntToString(MostVotateMap)))+" votes.");
    //here is save the number of the most votated map as next map tp be played
    if (GetLocalInt(oModule, "Halloween") == 1)
    {   //only play 4 random maps on Halloween, do not allow voting
        int nextmap = Random(4)+50; ///take a random map
        while (nextmap == LastMap ) //until was same as the last one
        {
            nextmap = Random(4)+50;
        }
        SetLocalInt(oModule, "nRound", nextmap); //play it
    }
    else if (MostVotateMap != 0)
    {
        SetLocalInt(oModule, "nRound", MostVotateMap);
    }
    //if anyone voted start a random map
    else
    {
        int nextmap = Random(TOTAL_ARENAS)+1; ///take a random map
        while (nextmap == LastMap ) //until was same as the last one
        {
            nextmap = Random(TOTAL_ARENAS)+1;
        }
        SetLocalInt(oModule, "nRound", nextmap); //play it
    }
      //sudden if sudden was voted start it (nb this not take the place of the next round!!)
    if (GetLocalInt(oModule, "map100") >= 4)
    {
        SetLocalInt(oModule, "nSuddenRound", 1);
    }
      ///king of the hill  if koth was voted, set it as next round
    if (GetLocalInt(oModule, "map98") >= 4)
    {
        SetLocalInt(oModule, "nRound", 98);
        SendMessageToAllDMs("Area King of the Hill had :"+IntToString(GetLocalInt(oModule, "map98"))+" votes");
    }
    if (GetLocalInt(oModule, "map101") >= 4)
    {
        SetLocalInt(oModule, "nRound", 101);
        SendMessageToAllDMs("Area Reverse CTF had :"+IntToString(GetLocalInt(oModule, "map101"))+" votes");
    }
    ///Push Of War  if pow was voted, set it as next round
    if (GetLocalInt(oModule, "map200") >= 4)
    {
        SetLocalInt(oModule, "nRound", 200);
        SendMessageToAllDMs("Area Tug Of War had :"+IntToString(GetLocalInt(oModule, "map200"))+" votes");
    }
    ///Start The Hunt if it is voted.
    if (GetLocalInt(oModule, "map999") >= 4)
    {
        SetLocalInt(oModule, "nRound", 999);
        SetLocalInt(oModule, "NoHunt", TRUE);
        DelayCommand(HoursToSeconds(120), DeleteLocalInt(oModule, "NoHunt"));
        SendMessageToAllDMs("The Hunt had :"+IntToString(GetLocalInt(oModule, "map999"))+" votes");
    }
    if  (LastMap == 98)
    {
        object oThrone = GetObjectByTag("ThroneKH");
        SetLocalInt(oThrone, "nTeam", 9);
        DeleteLocalObject(oThrone, "oKing");
        DeleteLocalObject(oThrone, "oLastKing");
    }
     if  (LastMap == 200)
    {
        //do we need to reset anything?
        EndTugOfWar(200);
    }
}

//////////////////////////////////////////////////////////////
// PlayBellSound()
//////////////////////////////////////////////////////////////
// Created By: Jantima
// Created On: May/04/04
// Description: Play the as_cv_bell2 Sound from all the Player's level Signs.
//////////////////////////////////////////////////////////////
void PlayBellSound()
{
    BroadcastMessage( ".....Round Starts!!......");
    object oSuona;
    oSuona = GetObjectByTag("Playerslevel");
    AssignCommand(oSuona, PlaySound("as_cv_bell2"));
    oSuona = GetObjectByTag("Playerslevel",1);
    AssignCommand(oSuona, PlaySound("as_cv_bell2"));
    oSuona = GetObjectByTag("Playerslevel",2);
    AssignCommand(oSuona, PlaySound("as_cv_bell2"));
    object oModule = GetModule();
    // Double Check . check the last map for players and flags.
    int LastMap = GetLocalInt(oModule,"LastMap");
    object oLastArea = GetObjectByTag("arena_"+IntToString(LastMap));

    object oPC = GetFirstObjectInArea(oLastArea);
    while (GetIsObjectValid(oPC))
    {
        if(GetIsPC(oPC))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(),oPC);
        }
        oPC = GetNextObjectInArea(oLastArea);
    }
    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        SetLocalInt(oPC, "nScore", 0);
        oPC = GetNextPC();
    }
    ///look for any dropped flag ...
    object oGoodFlag = GetLocalObject(oModule, "oHasFlag_1");
    object oEvilFlag = GetLocalObject(oModule, "oHasFlag_2");
    if ( GetObjectType(oGoodFlag) == OBJECT_TYPE_PLACEABLE )
    {
        DestroyObject(oGoodFlag);
        string szHasFlag = "oHasFlag_" + IntToString(1);
        object oHomeFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(1));
        SetLocalObject(GetModule(), szHasFlag, oHomeFlagHolder);
        ApplyFlagEffect(oHomeFlagHolder);
    }
    if (GetObjectType(oEvilFlag) == OBJECT_TYPE_PLACEABLE )
    {
        DestroyObject(oEvilFlag);
        string szHasFlag = "oHasFlag_" + IntToString(2);
        object oHomeFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(2));
        SetLocalObject(GetModule(), szHasFlag, oHomeFlagHolder);
        ApplyFlagEffect(oHomeFlagHolder);
    }
}

//////////////////////////////////////////////////////////////
//(SetRound)
//////////////////////////////////////////////////////////////
// Created By: Jantima
// Created On: Jan/24/04
// Modified By: Nilas_87
// MOdified On: Nov/09/04
// Description: Set the round constant.Move the Flag bearer.
//////////////////////////////////////////////////////////////
void SetRound()
{  object oModule = GetModule();
   int nActiveRound = GetLocalInt(oModule, "nRound");
   ExecuteScript("current_map", OBJECT_SELF);


   location lSpawn;
   object oFlagpoint;
   object oTarget;
   object oSuona;

       /////Tug Of War /////
   if(GetLocalInt(oModule, "nRound") == 200)
    {
    BroadcastMessage("<c^&À>..... Next round will be: ......</c>");
    BroadcastMessage("<c^&À>..... Tug Of War ......</c>");
    }
       /////The Hunt /////
   if(GetLocalInt(oModule, "nRound") == 999)
    {
    BroadcastMessage("<c^&À>..... Next round will be: ......</c>");
    BroadcastMessage("<c^&À>..... The Hunt ......</c>");
     BroadcastMessage("<c^&À>..... The Hunt cannot be voted for again until 6 normal rounds have been played. ......</c>");
    }
        /////King og the hill round/////
   if(GetLocalInt(oModule, "nRound") == 98)
    {
    BroadcastMessage("<c^&À>..... Next round will be: ......</c>");
    BroadcastMessage("<c^&À>..... King of the hill! ......</c>");
    }
else
 {
     if(GetLocalInt(oModule, "nSuddenRound") == 1)
      {
      BroadcastMessage("<c^&À>.....Sudden Death Match!!......</c>");
      object oPC = GetFirstPC();
        while (GetIsObjectValid(oPC))
        {
        FloatingTextStringOnCreature("<c^&À>Death match will start in 25 seconds! Prepare yourself!</c>",oPC,FALSE);
        oPC = GetNextPC();
        }
      DelayCommand(25.0,ExecuteScript("suddenspawn",oModule));
      }
      //include halloween rounds as well 50-53
    if ((nActiveRound <= TOTAL_ARENAS) || ((nActiveRound >= 50) && (nActiveRound <= 53)))
      {
         ///////ALL ROUNDS!!///////
          string sRound =IntToString(nActiveRound);
          BroadcastMessage( GetName(GetObjectByTag("arena_"+IntToString(nActiveRound)))+" Round Start in 2 Minutes!");
          oTarget = GetObjectByTag("FlagHolder_2");
          oFlagpoint = GetObjectByTag(sRound+"_Flagholder_2");
          lSpawn = GetLocation(oFlagpoint);
          AssignCommand(oTarget, MoveMeToLocation(lSpawn));

          oTarget = GetObjectByTag("FlagHolder_1");
          oFlagpoint = GetObjectByTag(sRound+"_Flagholder_1");
          lSpawn = GetLocation(oFlagpoint);
          AssignCommand(oTarget, MoveMeToLocation(lSpawn));
          SetLocalInt(oModule,"nRound", 0);
          DelayCommand( 119.0f,SetLocalInt(oModule,"nRound", nActiveRound));
          DelayCommand(120.0f, PlayBellSound());
          DelayCommand(125.0f, ExecuteScript("setlastround", OBJECT_SELF));
          // add here the LAG prevention Double check _
          // check into the lastMap and teleport to castle all players in here
          //GetLocalInt(oModule,"LastMap",LastMap);
          //if round is not 98 check to see if the flags are in the new map
       }
  }
 }
//////////////////////////////////////////////////////////////
// RestartModule()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jul/02/02
// Description: Restart the module.
//////////////////////////////////////////////////////////////
void RestartModule()
{
    EndTheGame(TRUE);
}


//////////////////////////////////////////////////////////////
// GetPlayerTeam()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Returns the team of the specified player.
//////////////////////////////////////////////////////////////
int GetPlayerTeam( object oPlayer )
{
    return GetLocalInt(oPlayer,"nTeam");
}


//////////////////////////////////////////////////////////////
// PickupFlag()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/27/02
// Description: Get the flag from where it was dropped.
//
//////////////////////////////////////////////////////////////

void PickupFlag(object oPlayer, object oFlagHolder)
{
    int nFlagHolderTeam = GetLocalInt(oFlagHolder, "nTeam");
    int nPCTeam = GetLocalInt(oPlayer, "nTeam");
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nFlagHolderTeam);

    if (nPCTeam == nFlagHolderTeam)
    {
        return;
    }
    else
    {
        DestroyObject(oFlagHolder);
        SetLocalObject(GetModule(), szEnemyHasFlag, oPlayer);
        //Well the dropped flag = invisible placeable it's destroyed
        //and we assume that this cause the ApplyFlagScript = ApplyEffects() to fail
        //So we change to AssignCommand [get The trigger as Object] ApplyFlagEffect
        AssignCommand(GetObjectByTag("FlagStand_"+IntToString(nFlagHolderTeam)), ApplyFlagEffect(oPlayer));
    }
    if (GetLocalInt(GetModule(), "FlagShouts"))
    {
        AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam) + GetStringLeft(GetName(oPlayer),20) +"</c>" + " grabs the " + GetTeamColour(nFlagHolderTeam) + GetTeamName(nFlagHolderTeam) + "</c> flag.", TALKVOLUME_SHOUT));
    }
    else
    {
        BroadcastMessage(GetTeamColour(nPCTeam) + GetStringLeft(GetName(oPlayer),20) +"</c>" + " grabs the " + GetTeamColour(nFlagHolderTeam) + GetTeamName(nFlagHolderTeam) + "</c> flag.");
    }
}




//////////////////////////////////////////////////////////////
// FlagDestroyed()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/27/02
// Description: Return the flag to its team when the dropped
//              flag is destroyed.
//////////////////////////////////////////////////////////////

void FlagDestroyed(int nFlagTeam)
{
    string szHasFlag = "oHasFlag_" + IntToString(nFlagTeam);
    object oHomeFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(nFlagTeam));

    SetLocalObject(GetModule(), szHasFlag, oHomeFlagHolder);
    ApplyFlagEffect(oHomeFlagHolder);

    if (GetLocalInt(GetModule(), "FlagShouts"))
    {
          AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nFlagTeam)+GetTeamName(nFlagTeam) + "</c> recovered their flag!", TALKVOLUME_SHOUT));
    }
    else
    {
        BroadcastMessage(GetTeamColour(nFlagTeam)+GetTeamName(nFlagTeam) + "</c> recovered their flag!");
    }

    if (nFlagTeam == GetPlayerTeam(GetLastDamager()))
    {
        AddTeamScore(nFlagTeam, 1);
    }

    object oHasFlag = GetLocalObject(GetModule(), "oHasFlag_"+IntToString(3-nFlagTeam));
    FloatingTextStringOnCreature ("Your Flag has been recovered!", oHasFlag, FALSE);
}




//////////////////////////////////////////////////////////////
// DropFlag()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/27/02
// Description: Removes flag from PC and creates a temporary
//              flag holder.
// Edited by Jantima  on 19 July 2004  for Antiworld Arena PVP
//////////////////////////////////////////////////////////////
void DropFlag( object oPlayer )
{
    location lLoc1 = Location(GetArea(oPlayer),GetPosition(oPlayer)+AngleToVector(GetFacing(oPlayer))+AngleToVector(GetFacing(oPlayer)),0.0f);
    int nPCTeam = GetLocalInt(oPlayer, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
    object oDroppedFlag;
    string sFlagResRef = "invisobj00" + IntToString(nEnemyTeam);
    //if ( GetAreaFromLocation(lLoc) != OBJECT_INVALID)
    //{
    object oDroppedFlag1 = CreateObject(OBJECT_TYPE_CREATURE, "droppedflag",lLoc1);
    location lLoc = GetLocation (oDroppedFlag1);
    oDroppedFlag = CreateObject(OBJECT_TYPE_PLACEABLE, sFlagResRef, lLoc, TRUE);
    DestroyObject( oDroppedFlag1);
    SetLocalInt(oDroppedFlag, "nTeam", nEnemyTeam);
    SetLocalObject(GetModule(), szEnemyHasFlag, oDroppedFlag);
    ApplyFlagEffect(oDroppedFlag);

    if (GetLocalInt(GetModule(), "FlagShouts"))
    {
        AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPlayer),20)+"</c>" + " dropped the "+GetTeamColour(nEnemyTeam)+ GetTeamName(nEnemyTeam) + "</c> flag!", TALKVOLUME_SHOUT));
    }
    else
    {
        BroadcastMessage(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPlayer),20)+"</c>" + " dropped the "+GetTeamColour(nEnemyTeam)+ GetTeamName(nEnemyTeam) + "</c> flag!");
    }
}



//////////////////////////////////////////////////////////////
// RemoveAllEffects()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Removes all non-permanent/innate/equipped
//              effects from the specified player.
//////////////////////////////////////////////////////////////
void RemoveAllEffects( object oPlayer )
{
    effect eEffect;
    eEffect = GetFirstEffect(oPlayer);

    while ( GetIsEffectValid(eEffect))
    {
     RemoveEffect(oPlayer, eEffect);
    eEffect = GetNextEffect(oPlayer);
    }
}

//////////////////////////////////////////////////////////////
// RemoveBuffs()
//////////////////////////////////////////////////////////////
// Created On: AUG/08/06
// Description: Removes all Buffs. but the haste and other module needed effects
//////////////////////////////////////////////////////////////
void RemoveBuffs( object oPlayer );
void RemoveBuffs( object oPlayer )
{
    effect eEffect;
    eEffect = GetFirstEffect(oPlayer);
    object oCreator;
    while ( GetIsEffectValid(eEffect))
    {
        //check not to remove effect we apply by the module ( autohaste and such)
         oCreator = GetEffectCreator(eEffect);
         if ( GetIsPC(oCreator) )
         {
            RemoveEffect(oPlayer, eEffect);
         }
    eEffect = GetNextEffect(oPlayer);
    }
}
//////////////////////////////////////////////////////////////
// GetIsHasted()
//////////////////////////////////////////////////////////////
// Created By: Vladiat0r
// Modified By:
// Modified By: Jantima
// Created On: 16 Feb 2005 01:47 pm
////////////////////////////////////////////////////////////
int GetIsHasted(object oPlayer)
{
    effect eff = GetFirstEffect(oPlayer);
    while (GetIsEffectValid(eff))
    {
        if (GetEffectType(eff) == EFFECT_TYPE_HASTE)
        {
            return TRUE;
        }
        eff = GetNextEffect(oPlayer);
    }
    return FALSE;
}



//////////////////////////////////////////////////////////////
// ApplyFlagEffect()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Modified By: Erich Delcamp
// Modified By: Jantima
// Modified By: Riddler 2008-5-25
// Created On: Jan/25/04
// Description: Applies the team specific flag effect to the
//              player.
//              Decrease Monk and Barb speed to normal
//              Attack Bonus and Armor Penalty  (level/5)
//              Remove from the player: G.Sanct - Freedom of Movment - Invisibility(?)
//              Apply Hide Skill Penalty current_skill/2
//              ...something else?
//              Apply Move Silently Penalty current_skill/2
//              Apply Discipline Penalty   current_skill/2
//              Apply damage vulnerabilities for DDs
//
//////////////////////////////////////////////////////////////
void ApplyFlagEffect( object oPlayer )
{
    int nTeam, nVisEffect, nLightEffect;
    effect eFlagEffect;
    effect eLightEffect;

    nTeam = GetPlayerTeam(oPlayer);
    if ((nTeam == TEAM_GOOD && GetIsPC(oPlayer) != TRUE) || (nTeam == TEAM_EVIL && GetIsPC(oPlayer) == TRUE ))
    {
        nVisEffect = VFX_DUR_FLAG_BLUE;
        nLightEffect = VFX_DUR_LIGHT_BLUE_15;
    }
    else
    {
        nVisEffect = VFX_DUR_FLAG_RED;
        nLightEffect = VFX_DUR_LIGHT_RED_15;
    }
    eFlagEffect = EffectVisualEffect(nVisEffect);
    eLightEffect = EffectVisualEffect(nLightEffect);
    effect nLinkFlagEffect = EffectLinkEffects (eFlagEffect ,eLightEffect);
    nLinkFlagEffect = SupernaturalEffect(nLinkFlagEffect);
    ///effect nLinkFlagEffect =EffectLinkEffects ( eFlagEffect
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,nLinkFlagEffect,oPlayer);

    if (GetIsPC(oPlayer))
    {
        //Search for and remove greater sanctuary and freedom of movment effects
        //effect eVis = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
        //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLook = GetFirstEffect(oPlayer);
        while(GetIsEffectValid(eLook))
        {
            if( GetEffectType(eLook) == EFFECT_TYPE_ETHEREAL ||
                GetEffectType(eLook) == IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE ||
                GetEffectType(eLook) == EFFECT_TYPE_SANCTUARY ||
                GetEffectType(eLook) == EFFECT_TYPE_INVISIBILITY ||
                GetEffectType(eLook) == EFFECT_TYPE_POLYMORPH ||
                GetEffectSpellId(eLook) == SPELL_FREEDOM_OF_MOVEMENT)
            {
                RemoveEffect(oPlayer, eLook);
            }
            eLook = GetNextEffect(oPlayer);
        }
        // Slow the flag holder down.  if is a Monk - Barb
        // Formula By Vladiat0r // Posted: 16 Feb 2005
        // then edited so we remove haste items again and give haste to all player automatically
        SetActionMode(oPlayer, ACTION_MODE_DETECT, FALSE); //Loophole fix
        SetActionMode(oPlayer, ACTION_MODE_STEALTH, FALSE); //Loophole fix
        int nMonkLevels = GetLevelByClass(CLASS_TYPE_MONK, oPlayer);
        int nBarbLevels = GetLevelByClass(CLASS_TYPE_BARBARIAN, oPlayer);
        if ((nMonkLevels > 0) || (nBarbLevels > 0)) //Loophole fix
        {
           int nDecrease = -50;
           if (nMonkLevels > 0) nDecrease += ( nMonkLevels/3)*10;
           if (nBarbLevels > 0) nDecrease += 10;
           //if (nMonkLevels >= 9) nDecrease -= 10; //give monks 10% boost
           //remove the effect of haste so it's not part of the calculation
           RemoveHaste(oPlayer);
           //DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSlow()), oPlayer));
           //yes this will give negative values for decrease, ie speed increase
           DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectMovementSpeedDecrease(nDecrease)), oPlayer));
           //// Toggle Slow to prevent monks from cheating speed
           effect effSlow = EffectSlow();
           DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_PERMANENT, effSlow, oPlayer));
           DelayCommand(0.7, RemoveEffect(oPlayer, effSlow));
        }

        effect eACPenalty = EffectACDecrease(GetAC(oPlayer)/4);
        effect eABPenalty = EffectAttackDecrease(GetBaseAttackBonus(oPlayer)/4);

        effect eHidePenalty = EffectSkillDecrease(SKILL_HIDE,GetSkillRank(SKILL_HIDE,oPlayer)/2);
        effect eMoveSilentlyPenalty = EffectSkillDecrease(SKILL_MOVE_SILENTLY,GetSkillRank(SKILL_MOVE_SILENTLY,oPlayer)/2);
        effect eDisciplinePenalty = EffectSkillDecrease(SKILL_DISCIPLINE,GetSkillRank(SKILL_DISCIPLINE,oPlayer)/2);
        effect eCasterPenalty = EffectSpellFailure(25);
        effect eSRPenalty = EffectSpellResistanceDecrease(10);
        effect eConcPenalty = EffectSkillDecrease(SKILL_CONCENTRATION, GetSkillRank(SKILL_CONCENTRATION, oPlayer) / 4);
        effect eFlagLink = EffectLinkEffects(eACPenalty, eABPenalty);

        //damage vulnerabilities for damage resistence
        effect eDivinePenalty;
        effect ePositivePenalty;
        effect eNegativePenalty;

        if (GetHasFeat(FEAT_EPIC_DAMAGE_REDUCTION_9,oPlayer))
        {
               eDivinePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE,30);
               ePositivePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_POSITIVE,30);
               eNegativePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_NEGATIVE,30);

               eFlagLink = EffectLinkEffects(eFlagLink, eNegativePenalty);
               eFlagLink = EffectLinkEffects(eFlagLink, ePositivePenalty);
               eFlagLink = EffectLinkEffects(eFlagLink, eDivinePenalty);
        }
        else if (GetHasFeat(FEAT_EPIC_DAMAGE_REDUCTION_6,oPlayer))
        {
               eDivinePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE,20);
               ePositivePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_POSITIVE,20);
               eNegativePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_NEGATIVE,20);

               eFlagLink = EffectLinkEffects(eFlagLink, eNegativePenalty);
               eFlagLink = EffectLinkEffects(eFlagLink, ePositivePenalty);
               eFlagLink = EffectLinkEffects(eFlagLink, eDivinePenalty);
        }
        else if (GetHasFeat(FEAT_EPIC_DAMAGE_REDUCTION_3,oPlayer))
        {
              eDivinePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE,10);
              ePositivePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_POSITIVE,10);
              eNegativePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_NEGATIVE,10);

              eFlagLink = EffectLinkEffects(eFlagLink, eNegativePenalty);
              eFlagLink = EffectLinkEffects(eFlagLink, ePositivePenalty);
              eFlagLink = EffectLinkEffects(eFlagLink, eDivinePenalty);
        }

        int nDDLvls = GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPlayer);

        if (nDDLvls > 20)
        {
             effect eSlashingPenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING,25);
             eFlagLink = EffectLinkEffects(eFlagLink, eSlashingPenalty);

        }
        else if (nDDLvls > 15)
        {
             effect ePiercingPenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING,25);
             eFlagLink = EffectLinkEffects(eFlagLink, ePiercingPenalty);
        }
        else if (nDDLvls > 10)
        {
             effect eBluntPenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING,25);
             eFlagLink = EffectLinkEffects(eFlagLink, eBluntPenalty);
        }

        eFlagLink = EffectLinkEffects(eFlagLink, eHidePenalty);
        eFlagLink = EffectLinkEffects(eFlagLink, eMoveSilentlyPenalty);
        eFlagLink = EffectLinkEffects(eFlagLink, eDisciplinePenalty);
        eFlagLink = EffectLinkEffects(eFlagLink, eCasterPenalty);
        eFlagLink = EffectLinkEffects(eFlagLink, eSRPenalty);
        eFlagLink = SupernaturalEffect(eFlagLink);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFlagLink,oPlayer);
    }
    AssignCommand(oPlayer, PlaySound("as_mg_telepout1"));
}


//////////////////////////////////////////////////////////////
// RemoveFlagEffect()
//////////////////////////////////////////////////////////////
// Created By:  Jantima
// Modified By:  Jantima
// Created On: Jan/20/04
// Description: Remove only the team specific flag effect to the
//              player and not all effects!.
//////////////////////////////////////////////////////////////

void RemoveFlagEffect( object oPC )
{
    effect eEfc;
    string sName;
    //SendMessageToPC(oPC, "Remove");
    eEfc=GetFirstEffect(oPC);
    while(GetIsEffectValid(eEfc))
    {
        //PrintString("Creator name:"+GetName(GetEffectCreator(eEfc)));
        //PrintString("Creator tag:"+GetTag(GetEffectCreator(eEfc)));
        sName= GetName(GetEffectCreator(eEfc));
        if ((sName== "Evil Flag Stand")||(sName== "Good Flag Stand" )||(sName== "")||(sName== "Good Pillar")||(sName== "Evil Pillar") )
        // sName== ""  is for remove the flag effect when it's created by the dropped
        // flag "invisible object" because it is destroyed so it have no name.
        {
            RemoveEffect(oPC, eEfc);
        }
        eEfc = GetNextEffect(oPC);
    }
    if ((GetLevelByClass(CLASS_TYPE_MONK, oPC) > 0) ||
        (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) > 0)) //Loophole fix
    {
        //// Toggle Haste to prevent monks from cheating speed
        RemoveHaste(oPC);
        DelayCommand(0.1, ApplyHaste(oPC));
        //effect effSlow = EffectSlow();
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT, effSlow, oPC);
        //DelayCommand(0.1, RemoveEffect(oPC, effSlow));
    }
}


//////////////////////////////////////////////////////////////
// BroadcastMessage()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/27/02
// Description: Send message to all PCs, or to specific team.
//
//////////////////////////////////////////////////////////////
void BroadcastMessage(string sMessage, int nTeam)
{
    object oPlayer;

    oPlayer = GetFirstPC();
    while ( GetIsObjectValid(oPlayer) == TRUE )
    {
        if (nTeam == 0 || nTeam == GetLocalInt(oPlayer, "nTeam"))
        {
            SendMessageToPC(oPlayer,sMessage);
        }
        oPlayer = GetNextPC();
    }
    //PrintString(sMessage);
}


//////////////////////////////////////////////////////////////
// RewardCapture()
//////////////////////////////////////////////////////////////
// Created By: Noel Borstad
// Modified By: Erich Delcamp
// Modified By: Jantima
// Created On: Jun/13/02
// Description: Reward a team for capturing the flag.
//
//////////////////////////////////////////////////////////////
void RewardCapture( int nTeam, object oCapturingPlayer)
{
    object oPlayer;

    if (GetLocalInt(GetModule(), "FlagShouts"))
    {
        AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nTeam)+GetStringLeft(GetName(oCapturingPlayer), 20)+"</c>"/* + " of " + GetTeamName(nTeam) */+ " captures the " +GetTeamColour(3 - nTeam)+ GetTeamName(3 - nTeam) + "</c> flag!", TALKVOLUME_SHOUT));
    }
    else
    {
        BroadcastMessage(GetTeamColour(nTeam)+GetStringLeft(GetName(oCapturingPlayer), 20)+"</c>"/* + " of " + GetTeamName(nTeam) */+ " captures the " +GetTeamColour(3 - nTeam)+ GetTeamName(3 - nTeam) + "</c> flag!");
    }

    FloatingTextStringOnCreature("Well done!", oCapturingPlayer, FALSE);
    //Reward who capture the flag
    int nReward;
    nReward = REWARD_XP_WINNERS * GetHitDice(oCapturingPlayer) * 2;
    GiveGoldToCreature(oCapturingPlayer,nReward);
    SetXP(oCapturingPlayer,(GetXP(oCapturingPlayer)+ nReward));
    //GiveXPToCreature(oCapturingPlayer, nReward);

    //Reward all the team
    float fDelay;
    oPlayer = GetFirstPC();
    while ( GetIsObjectValid(oPlayer) == TRUE )
    {
        ///SendMessageToPC(oPlayer, sMessage);
        if (nTeam == GetLocalInt(oPlayer, "nTeam") && oPlayer != oCapturingPlayer && (GetTag(GetArea(oPlayer)) == ("arena_"+IntToString(GetLocalInt(GetModule(), "nRound")))) && GetTag(GetArea(oPlayer)) != "RedWings")
        {   nReward = REWARD_XP_WINNERS * GetHitDice(oPlayer);
            GiveGoldToCreature(oPlayer, nReward);
            SetLocalInt(oPlayer,"m_nGoldwinnings", (GetLocalInt(oPlayer,"m_nGoldwinnings") + nReward));
            DelayCommand(fDelay, SetXP(oPlayer,(GetXP(oPlayer)+ nReward)));
            fDelay += 0.1;
        }
        oPlayer = GetNextPC();
    }

    AddTeamScore(nTeam, 10);
}




//////////////////////////////////////////////////////////////
// RewardKill()
//////////////////////////////////////////////////////////////
// Created By: Noel Borstad
// Modified By: Jantima
// Created On: Jun/13/02
// Description: Reward a team for Kill other team players.
//
//////////////////////////////////////////////////////////////
void RewardTeamKill(int nReward, object oKiller, int nTeam, int nScore);
void RewardTeamKill(int nReward, object oKiller, int nTeam, int nScore)
{
    object oPlayer;
    oPlayer = GetFirstPC();
    float fDelay;
    while ( GetIsObjectValid(oPlayer) == TRUE  )
    {
        if ((nTeam == GetLocalInt(oPlayer, "nTeam")) &&
           (GetTag(GetArea(oPlayer)) == ("arena_"+IntToString(GetLocalInt(GetModule(), "nRound"))))
            && (oPlayer != oKiller))
         {
            GiveGoldToCreature(oPlayer, nReward);
            SetLocalInt(oPlayer,"m_nGoldwinnings", (GetLocalInt(oPlayer,"m_nGoldwinnings") +  nReward));
            DelayCommand(fDelay, SetXP(oPlayer,(GetXP(oPlayer)+ nReward)));
            fDelay += 0.1;
        }
        oPlayer = GetNextPC();
    }
    AddTeamScore(nTeam, nScore);
}

//////////////////////////////////////////////////////////////
// // string   GetTeamColour( int nTeam);
//////////////////////////////////////////////////////////////
// Created By: Jantima
// Created On: ?/?/04
// Description: Returns the team colour.
//
//////////////////////////////////////////////////////////////
string GetTeamColour( int nTeam)
{

    if (nTeam == TEAM_GOOD)
    {
        return "<c&VÍ>";
    }
    else if (nTeam == TEAM_EVIL)
    {
        return "<cú==>";
    }
    else
    {
        return "<c&ÈE>";
    }
}

//////////////////////////////////////////////////////////////
// GetTeamName()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/27/02
// Description: Returns the team name.
//
//////////////////////////////////////////////////////////////
string GetTeamName( int nTeam )
{

    if (nTeam == TEAM_GOOD)
    {
        return "Good";
    }
    else if (nTeam == TEAM_EVIL)
    {
        return "Evil";
    }
    else
    {
        return "None";
    }
}


//////////////////////////////////////////////////////////////
// AddPlayerToTeam()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Modified By: Erich Delcamp
// Created On: Jun/09/02
// Description: Adds a player to the specified team.
//Modified By: Jantima
//////////////////////////////////////////////////////////////
void AddPlayerToTeam( int nTeam, object oPlayer )
{

    //Players alignment changes to Good/Evil when he joins a team
    if (nTeam == 1)
    {
    AdjustAlignment(oPlayer, ALIGNMENT_GOOD, 100);
    }
    else if (nTeam == 2)
    {
    AdjustAlignment(oPlayer, ALIGNMENT_EVIL, 100);
    }
    //SetLocalInt(oPC, "nScore", 0);
    if (GetWeakTeam() != TEAM_NONE)
    {
        CheckTeamBalance();
    }
    // Loop through all other players in the game
    // and set up the likes/dislikes appropriately.
    object oPC;

    SetLocalInt(oPlayer, "nTeam", nTeam);

    /*
    oPC = GetFirstPC();
    while ( GetIsObjectValid(oPC) == TRUE )
    {
        if ( oPC != oPlayer )
        {
            if ( GetPlayerTeam(oPC) == nTeam  || GetDeity(oPC) == "GM")
            {
                SetPCLike(oPlayer,oPC);
                SetPCLike(oPC,oPlayer);
            }
            else
            {
                SetPCDislike(oPlayer,oPC);
                SetPCDislike(oPC,oPlayer);
            }
        }

        oPC = GetNextPC();
    }
    */
    // Set Faction Reputations
    AdjustReputation(oPlayer, GetObjectByTag("King_" + IntToString(nTeam)), 100);
    AdjustReputation(oPlayer, GetObjectByTag("King_" + IntToString(3 - nTeam)), -100);
    BroadcastMessage(GetName(oPlayer) + " has joined " +GetTeamColour(nTeam)+ GetTeamName(nTeam) + ".</c>");
    IncrementTeamCount(nTeam, 1);
    BuildParty(nTeam, oPlayer);

    ////Valentine's Day change team = Dismiss valentine :D
   if (GetLocalInt(GetModule(),"ValentineDay") == 1)
   {
   object oMyValentine = GetLocalObject(oPlayer,"MyValentine");
   if (oMyValentine != OBJECT_INVALID)
      {
      object oMyValentine = GetLocalObject(oPlayer,"MyValentine");
      if (3-GetPlayerTeam(oPlayer) != GetPlayerTeam(oMyValentine))
         {
         DelayCommand(3.0,BroadcastMessage("<cø.>You cannot longer be: "+GetName(oMyValentine)+" Valentine!</c>"));
         DeleteLocalObject(oPlayer,"MyValentine");
         DeleteLocalObject(oMyValentine,"MyValentine");
         FloatingTextStringOnCreature("<cëe@>"+GetName(oPlayer)+" changed team.</c>",oMyValentine, FALSE);
         DelayCommand(2.0,FloatingTextStringOnCreature("<cëe@>"+GetName(oPlayer)+" is no longer your Valentine.</c>",oMyValentine, FALSE));
         }
      }
   }
}

//////////////////////////////////////////////////////////////
// RemovePlayerFromTeam()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jul/01/02
// Description: Remove a player to the specified team.
// Edited By Jantima on April 2005
//////////////////////////////////////////////////////////////
void RemovePlayerFromTeam(int nTeam, object oPlayer)
{
    object oLeader = GetTeamLeader(nTeam);

    if (oPlayer == oLeader)
    {
        oLeader = GetFactionLeader(oPlayer);
        oLeader = GetNextFactionMember(oPlayer, TRUE);
        SetTeamLeader(nTeam, oLeader);
    }
    ///Check if the player have the flag, if so send flag home
    int nEnemyTeam = 3 - nTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
    if (GetLocalObject(GetModule(), "oHasFlag_1") == oPlayer
    ||  GetLocalObject(GetModule(), "oHasFlag_2") == oPlayer)

    {
           RemoveFlagEffect(oPlayer);
           FlagDestroyed(nEnemyTeam);
    }

    RemoveFromParty(oPlayer);
    IncrementTeamCount(nTeam, -1);
    SetLocalInt(oPlayer, "nTeam", TEAM_NONE);
}


//////////////////////////////////////////////////////////////
// BuildParty()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jul/01/02
// Description: Create party if there is none, or add a new
//              player to the party.
//
//////////////////////////////////////////////////////////////
void BuildParty(int nTeam, object oPlayer)
{
    if (GetTeamCount(nTeam) == 1)
    {
    // This player is the only PC on the team.
        SetTeamLeader(nTeam, oPlayer);
    }
    else
    {
    // This player is not the first.
        RemoveFromParty(oPlayer);
        AddToParty(oPlayer, GetTeamLeader(nTeam));
    }

    object oPC = GetFirstPC();
    int nPCTeam;
    while (GetIsObjectValid(oPC))
    {
        if ( oPC != oPlayer )
        {
            if ((GetPlayerTeam(oPC)  == nTeam) || (GetDeity(oPC) == "GM"))
            {
                SetPCLike(oPlayer,oPC);
                SetPCLike(oPC,oPlayer);
            }
            else
            {
                SetPCDislike(oPlayer,oPC);
                SetPCDislike(oPC,oPlayer);
            }
        }

        oPC = GetNextPC();
    }
}


//////////////////////////////////////////////////////////////
// GetTeamLeader()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jul/01/02
// Description: Get the team leader.
//
//////////////////////////////////////////////////////////////
object GetTeamLeader(int nTeam)
{
    object oResult = GetLocalObject(GetModule(), "oTeamLeader_" + IntToString(nTeam));

    return oResult;
}

//////////////////////////////////////////////////////////////
// SetTeamLeader()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jul/01/02
// Description: Set the team leader.
//
//////////////////////////////////////////////////////////////
void SetTeamLeader(int nTeam, object oPlayer)
{
    SetLocalObject(GetModule(), "oTeamLeader_" + IntToString(nTeam), oPlayer);
}


//////////////////////////////////////////////////////////////
// ChooseTeam()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/27/02
// Description: Selects a team for the player based on the
//              number of players on each team.
//              In desperate need of a rewrite, now that I
//              track team counts.
//Modified by Jantima on 26 April 2004
//////////////////////////////////////////////////////////////
void ChooseTeam( object oPC )
{
    int nGood = GetTeamCount(TEAM_GOOD);
    int nEvil = GetTeamCount(TEAM_EVIL);
    int nGoodTotalLevel =  GetTeamTotalLevel(TEAM_GOOD);
    int nEvilTotalLevel =  GetTeamTotalLevel(TEAM_EVIL);
    //int PlayerLevel = GetTotalPlayerLevel(oPC);

    if (nEvil > nGood)
    {
        AddPlayerToTeam(TEAM_GOOD, oPC);
    }
    else if (nGood > nEvil)
    {
        AddPlayerToTeam(TEAM_EVIL, oPC);
    }
    else  if (nGoodTotalLevel > nEvilTotalLevel)
    {
        AddPlayerToTeam(TEAM_EVIL, oPC);
        //SendMessageToAllDMs("Player: "+GetName(oPC)+"["+IntToString(GetTotalPlayerLevel(oPC))+"] added on team: "+GetTeamName(TEAM_EVIL)+" -Evil Total level was:"+IntToString(nEvilTotalLevel)+" Good Total level was:"+IntToString(nGoodTotalLevel)+".");
    }
    else if (nEvilTotalLevel > nGoodTotalLevel)
    {
        AddPlayerToTeam(TEAM_GOOD, oPC);
        //SendMessageToAllDMs("Player: "+GetName(oPC)+"["+IntToString(GetTotalPlayerLevel(oPC))+"] added on team: "+GetTeamName(TEAM_GOOD)+" -Evil Total level was:"+IntToString(nEvilTotalLevel)+" Good Total level was:"+IntToString(nGoodTotalLevel)+".");
    }
    else
    {
        AddPlayerToTeam(d2(), oPC);//random
    }

}
//////////////////////////////////////////////////////////////
// GetTeamTotalLevel()
//////////////////////////////////////////////////////////////
// Created By: Jantima
// Created On: Apr/26/04
// Description: Selects a team for the player based on the
//              total levels of players on each team.
//              ??In desperate need of a rewrite, now that I
//              track team counts.    ??
//
//////////////////////////////////////////////////////////////
int GetTeamTotalLevel(int nTeam)
{
    object oPlayer = GetFirstPC();
    int Level = 0;
    int TotalLevel = 0;
    while ( GetIsObjectValid(oPlayer) == TRUE )
    {
        if (nTeam == GetPlayerTeam(oPlayer))
        {
            Level = GetTotalPlayerLevel(oPlayer);
            TotalLevel += Level;
        }
        oPlayer = GetNextPC();
    }
    return TotalLevel;
}

//////////////////////////////////////////////////////////////
// RemoveAllPlotItems()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/14/02
// Description: Removes all plot items from a creature.
//////////////////////////////////////////////////////////////
 /*//Antiworld //
// we do not remove plot items because  we're server vault
// so we can use plot items for some advantage in scripting
//like do not remove plot item when we remove everything due to merchants and items rebuild
// like those plot items have no cost, finally (i think at least)
void RemoveAllPlotItems( object oPlayer )
{
    object oItem;
    int nCount;

    oItem = GetFirstItemInInventory(oPlayer);

   while ( GetIsObjectValid(oItem) == TRUE )
    {
        if ( GetPlotFlag(oItem) == TRUE )
        {
            DestroyObject(oItem);
        }

        oItem = GetNextItemInInventory(oPlayer);
    }

    // Now iterate through each inventory slot and compute
    // the cost of the item (if one exists in that slot)
    // - BKH - Jun/17/02
    for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
    {
        oItem = GetItemInSlot(nCount,oPlayer);
        if ( GetPlotFlag(oItem) == TRUE )
        {
            DestroyObject(oItem);
        }
    }
}   */


//////////////////////////////////////////////////////////////
// InitializePlayerForGame()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Modified By: Erich Delcamp
// Created On: Jun/09/02
// Description: Initializes the player with a team and sets
//              up the base statistics values for that player.
//////////////////////////////////////////////////////////////
void InitializePlayerForGame( object oPlayer )
{
    RemoveFromParty(oPlayer);
    PrintString("Selecting a team for player: " + GetName(oPlayer)+" lvl: "+ IntToString(GetHitDice(oPlayer)));
    ChooseTeam(oPlayer);
    //SetLocalInt(oPlayer, "nScore", 0);
    SetLocalInt(oPlayer, "nLastSwitchScore", 0);
    SetLocalInt(oPlayer, "LastTimer", GetLocalInt(GetModule(), "timer"));
    SetLocalInt(oPlayer, "LastRound", GetLocalInt(GetModule(), "nRound"));
    SetTrapsAcquired(oPlayer, 0);
}


//////////////////////////////////////////////////////////////
// RemoveAllGoldFromPlayer()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/10/02
// Description: Removes all gold from the specified player.
//////////////////////////////////////////////////////////////
void RemoveAllGoldFromPlayer( object oPlayer )
{
    TakeGoldFromCreature(GetGold(oPlayer),oPlayer,TRUE);
    RemoveAllPlotItems(oPlayer);
}


//////////////////////////////////////////////////////////////
//
// //MovePlayerToArena(oPlayer);
//
//////////////////////////////////////////////////////////////
// Created By: Jantima
// Created On: Jan/25/04 1:30
// Description: Moves player to team spawn point.
//////////////////////////////////////////////////////////////
void MovePlayerToArena(object oPlayer)
{
    int nTeam = GetPlayerTeam(oPlayer);
    location lSpawn;
    object oSpawnpoint;
    int nActiveRound = GetLocalInt(GetModule(), "nRound");

    if (nTeam == TEAM_NONE)
    {
        oSpawnpoint = GetObjectByTag("spawnpoint_inn");
        lSpawn = GetLocation(oSpawnpoint);
    }
    else
    {
        oSpawnpoint = GetObjectByTag(GetTeamName(nTeam) + "Spawn" + IntToString(nActiveRound));
        lSpawn = GetLocation(oSpawnpoint);
    }
    AssignCommand(oPlayer, MoveMeToLocation(lSpawn));

}

//////////////////////////////////////////////////////////////
//
// MovePlayerToSpawn()
//
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/28/02
// Description: Moves player to team spawn point.
//////////////////////////////////////////////////////////////
void MovePlayerToSpawn( object oPlayer)
{
    int nTeam = GetPlayerTeam(oPlayer);
    location lSpawn;
    object oSpawnpoint;
    if (nTeam == TEAM_NONE)
    {
        oSpawnpoint = GetObjectByTag("spawnpoint_inn");
        lSpawn = GetLocation(oSpawnpoint);
    }
    else
    {
        oSpawnpoint = GetObjectByTag("spawnpoint_" + IntToString(nTeam));
        lSpawn = GetLocation(oSpawnpoint);
    }

    AssignCommand(oPlayer, MoveMeToLocation(lSpawn));

}

//////////////////////////////////////////////////////////////
//
// MovePlayerAFK()
//
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/28/02
// Description: Moves player to team spawn point.
//////////////////////////////////////////////////////////////
void MovePlayerAfk( object oPlayer)
{
    AssignCommand(oPlayer, MoveMeToLocation(GetLocation(GetObjectByTag("AFK"))));
}

//////////////////////////////////////////////////////////////
//
// MovePlayerToJail()
//
//////////////////////////////////////////////////////////////
// Created By: Jantima
// Created On: Jan/9/04
// Description: Moves player to team spawn point.
//////////////////////////////////////////////////////////////
void MovePlayerToJail(object oPlayer)
{
AssignCommand(oPlayer, MoveMeToLocation(GetLocation(GetObjectByTag("jail"))));
}

//////////////////////////////////////////////////////////////
// MoveMeToLocation()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Modified By: Erich Delcamp
// Created On: Jun/14/02
// Description: Moves this creature to their designated start
//              location.
//////////////////////////////////////////////////////////////
void MoveMeToLocation( location lLoc )
{
    ClearAllActions();
    JumpToLocation(lLoc);
    ActionDoCommand(SetCommandable(TRUE));
    SetCommandable(FALSE);
}
//////////////////////////////////////////////////////////////
// ReimburseGoldToPlayer()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/28/02
// Description: Gives player starting gold.
//////////////////////////////////////////////////////////////
void ReimburseGoldToPlayer( object oPlayer)
{
    int nMaxGold = GetAllowedItemCostForPlayer(oPlayer);
    int nItemCost = GetTotalPlayerItemCost(oPlayer);
    int nGiveGold;

    if (GetLocalInt(GetModule(), "m_nAllowedItemCost") == ITEM_COST_UNLIMITED)
    {
        nGiveGold = DEFAULT_AMOUNT_OF_STARTING_GOLD;
    }
    else
    {
        nGiveGold = nMaxGold - nItemCost;
    }
    if (nGiveGold > 0)
    {
        GiveGoldToCreature(oPlayer, nGiveGold);
    }
}
//////////////////////////////////////////////////////////////
// GetIsEnemyTeam()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/30/02
// Description: Returns TRUE if PC is not on source's
//              team, or if source has a hostile reaction.
//////////////////////////////////////////////////////////////
int GetIsEnemyTeam(object oTarget, object oMe)
{
    int nTargetTeam = GetPlayerTeam(oTarget);
    int nMyTeam = GetPlayerTeam(oMe);

    if (GetIsPC(oTarget) && (GetDeity(oTarget) != "GM"))
    {
        if (3 - nTargetTeam == nMyTeam)
        {
            return TRUE;
        }
        return FALSE;
    }
    else if (GetIsReactionTypeHostile(oTarget, oMe))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
//////////////////////////////////////////////////////////////
// ApplyHaste()
//////////////////////////////////////////////////////////////

void ApplyHaste(object oPlayer)
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectHaste()),oPlayer);
}

void RemoveHaste(object oPlayer)
{
    int eType;
    effect eff = GetFirstEffect(oPlayer);
    while (GetIsEffectValid(eff))
    {
        eType = GetEffectType(eff);
        if ((eType == EFFECT_TYPE_HASTE) ||
            (eType == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE))
        {
            RemoveEffect(oPlayer, eff);
        }
        eff = GetNextEffect(oPlayer);
    }
}
//////////////////////////////////////////////////////////////
// ApplyTumble()
//////////////////////////////////////////////////////////////
//15 for guaranteed tumble, and +7 +3 to counteract heavy armor and shield penalties
void ApplyTumble(object oPlayer)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSkillIncrease(SKILL_TUMBLE, 50)), oPlayer);
}
//////////////////////////////////////////////////////////////
// IncrementTeamCount()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jul/01/02
// Description: Add or subtract a team member.
//
//////////////////////////////////////////////////////////////
void IncrementTeamCount(int nTeam, int nAdjust)
{
    string szTeamCountVar = "nTeamCount_" + IntToString(nTeam);
    int nCurrentCount = GetLocalInt(GetModule(), szTeamCountVar);

    nCurrentCount += nAdjust;
    SetLocalInt(GetModule(), szTeamCountVar, nCurrentCount);
}

//////////////////////////////////////////////////////////////
// GetTeamCount()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jul/01/02
// Description: Get the number of players on a team.
//
//////////////////////////////////////////////////////////////
int GetTeamCount(int nTeam)
{
    return GetLocalInt(GetModule(), "nTeamCount_" + IntToString(nTeam));
}


//////////////////////////////////////////////////////////////
// AddTeamScore()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/30/02
// Description: Add points to a team's score.
//////////////////////////////////////////////////////////////
void AddTeamScore(int nTeam, int nScore)
{
    string szScoreVar = "nScore_" + IntToString(nTeam);
    int nCurrentScore = GetLocalInt(GetModule(), szScoreVar);
    int nGoodScore, nEvilScore;

    nCurrentScore += nScore;
    SetLocalInt(GetModule(), szScoreVar, nCurrentScore);
    nGoodScore = GetLocalInt(GetModule(), "nScore_1");
    nEvilScore = GetLocalInt(GetModule(), "nScore_2");
    BroadcastMessage("Good: " + IntToString(nGoodScore) + "  Evil: " + IntToString(nEvilScore));
}


//////////////////////////////////////////////////////////////
// AddPlayerScore()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/30/02
// Description: Add points to one player's score.
//
//////////////////////////////////////////////////////////////
void AddPlayerScore(object oPlayer, int nScore)
{
    int nCurrentScore = GetLocalInt(oPlayer, "nScore") + nScore;

    SetLocalInt(oPlayer, "nScore", nCurrentScore);
    SendMessageToPC(oPlayer, "Your score: " + IntToString(nCurrentScore) + ".");

    if (nCurrentScore <= TEAMKILL_LIMIT)
    {
        BroadcastMessage(GetName(oPlayer) + " booted for excessive team kills.");
        SendMessageToAllDMs(GetName(oPlayer) + " booted for teamkilling. Player name: " + GetPCPlayerName(oPlayer));
        SendMessageToAllDMs("CD Key: " + GetPCPublicCDKey(oPlayer));
        WriteTimestampedLogEntry(GetPCPlayerName(oPlayer) + " booted for teamkilling.CD Key: " + GetPCPublicCDKey(oPlayer));

        BootPC(oPlayer);
    }
}


//////////////////////////////////////////////////////////////
// EndTheGame()
//////////////////////////////////////////////////////////////
// Created By: Erich Delcamp
// Created On: Jun/30/02
// Modified By: Nilas_87
// Modified On: Nov/09/04
// Description: Report the scores, reset everything.
//////////////////////////////////////////////////////////////
void EndTheGame(int bRestarting)
{
    int nGoodScore = GetLocalInt(GetModule(), "nScore_1");
    int nEvilScore = GetLocalInt(GetModule(), "nScore_2");
    object oPC;
    object oBestPC;
    object oHasFlag;

    ////////////////////////////////////////////////////
    //Delete Ints from Statues in map The Hunting Ground
    ////////////////////////////////////////////////////
    effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
    object oStatue1 = GetObjectByTag("zzz_statnw");
    DeleteLocalInt(oStatue1, "StatueUsed");
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue1, HoursToSeconds(17));
    object oStatue2 = GetObjectByTag("zzz_statne");
    DeleteLocalInt(oStatue2, "StatueUsed");
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue2, HoursToSeconds(17));
    object oStatue3 = GetObjectByTag("zzz_statsw");
    DeleteLocalInt(oStatue3, "StatueUsed");
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue3, HoursToSeconds(17));
    object oStatue4 = GetObjectByTag("zzz_statse");
    DeleteLocalInt(oStatue4, "StatueUsed");
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue4, HoursToSeconds(17));
    object oStatue5 = GetModule();
    DeleteLocalInt(oStatue5, "StatueUsed");
    object oPU1 = GetObjectByTag("powerup1");
    SetLocalInt(oPU1, "Decharged", 1);
    AssignCommand(oPU1, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    object oPU2 = GetObjectByTag("powerup2");
    SetLocalInt(oPU2, "Decharged", 1);
    AssignCommand(oPU2, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    object oPU3 = GetObjectByTag("powerup3");
    SetLocalInt(oPU3, "Decharged", 1);
    AssignCommand(oPU3, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    object oPU4 = GetObjectByTag("powerup4");
    SetLocalInt(oPU4, "Decharged", 1);
    AssignCommand(oPU4, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    object oPU5 = GetObjectByTag("powerup5");
    SetLocalInt(oPU5, "Decharged", 1);
    AssignCommand(oPU5, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    object oPU6 = GetObjectByTag("powerup6");
    SetLocalInt(oPU6, "Decharged", 1);
    AssignCommand(oPU6, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

    int nBestPCScore = 0;
    int nTeam;
    int nBestCoupleScore = 0;
    object oPlayer;
    object oBestCouple;
    object oHisValentine;
    int nCoupleScore;
    SetTime(12, 0, 0, 0);
    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
        DeleteLocalInt(oPC, "Monster");
        DeleteLocalInt(oPC, "Hunter");
        DeleteLocalInt(oPC, "LegendHunter");
        DeleteLocalInt(oPC, "StatueNumber");
        if (GetPlayerTeam(oPC) != TEAM_NONE && GetTag(GetArea(oPC)) != "Jail" && GetTag(GetArea(oPC)) != "DuelArea")
        {
            //RemoveAllEffects(oPC);
            if ( (oPC == (GetLocalObject(GetModule(), "oHasFlag_2"))) ||  (oPC == (GetLocalObject(GetModule(), "oHasFlag_1"))) )
            {
                RemoveFlagEffect(oPC);
            }
            if (bRestarting == FALSE)
            {
                //MovePlayerToSpawn(oPC);
                AssignCommand(oPC, ClearAllActions(TRUE));
                ToggleAllStuff(oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectPetrify(),oPC ,4.9f);
                DelayCommand(5.0f, MovePlayerToSpawn(oPC));
            }
            else
            {
                AssignCommand(oPC, ClearAllActions(TRUE));
                RemovePlayerFromTeam(GetPlayerTeam(oPC), oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectPetrify(),oPC ,4.9f);
                DelayCommand(5.0f, MovePlayerToSpawn(oPC));
            }
            if (GetLocalInt(oPC, "nScore") > nBestPCScore)
            {
                oBestPC = oPC;
                nBestPCScore = (GetLocalInt(oPC, "nScore"));
            }
            if (GetLocalInt(GetModule(),"ValentineDay") == 1)
              {
              object oMyValentine = GetLocalObject(oPC,"MyValentine");
              if (GetPCPlayerName(oMyValentine) != "")
                 {
                 nCoupleScore =  GetLocalInt(oPC, "nScore")+GetLocalInt(oMyValentine, "nScore");
                 if (nCoupleScore  > nBestCoupleScore)
                   {
                   oBestCouple = oPC;
                   oHisValentine = oMyValentine;
                   nBestCoupleScore = nCoupleScore;
                   }
                 SendMessageToPC(oPC, "Your Valentines Couple score was: " + IntToString(nCoupleScore));
                 }
              }

            SendMessageToPC(oPC, "Your score was: " + IntToString(GetLocalInt(oPC, "nScore")));
            //SetLocalInt(oPC, "nScore", 0);
            DeleteLocalInt(oPC, "MapVote");
            DeleteLocalInt(oPC, "SudVote");
            DeleteLocalInt(oPC, "HillVote");
            SetTrapsAcquired(oPC, 0);
        }
        oPC = GetNextPC();
    }
    for (nTeam = 1; nTeam < 3; nTeam ++)
    {
        if (GetTag(GetLocalObject(GetModule(), "oHasFlag_" + IntToString(nTeam))) == "dropped_flag_" + IntToString(nTeam))
        {
            FlagDestroyed(nTeam);
        }
        else if (GetTag(GetLocalObject(GetModule(), "oHasFlag_" + IntToString(nTeam))) != "FlagHolder_" + IntToString(nTeam))
        {
            SetLocalObject(GetModule(), "oHasFlag_" + IntToString(nTeam), GetObjectByTag("FlagHolder_" + IntToString(nTeam)));
            ApplyFlagEffect(GetObjectByTag("FlagHolder_" + IntToString(nTeam)));
        }
    }

    if (nGoodScore > nEvilScore)
    {
        BroadcastMessage(GetTeamColour(TEAM_GOOD)+"Good wins the day </c>" + IntToString(nGoodScore) + " to " + IntToString(nEvilScore) + ".");

            oPlayer = GetFirstPC();     //Reward all Good Team
            while ( GetIsObjectValid(oPlayer) == TRUE )
            {
             if (GetPlayerTeam(oPlayer) == 1 && oPlayer != oBestPC)
            { int nReward = REWARD_MVM_TEAM * GetHitDice(oBestPC);
              GiveGoldToCreature(oPlayer,  nReward);
              SetXP(oPlayer,(GetXP(oPlayer)+ nReward));
              //GiveXPToCreature(oPlayer,  nReward);
              }
              oPlayer = GetNextPC();
            }
    }
    else if (nEvilScore > nGoodScore)
    {
        BroadcastMessage(GetTeamColour(TEAM_EVIL)+"Evil wins the day </c>" + IntToString(nEvilScore) + " to " + IntToString(nGoodScore) + ".");

            oPlayer = GetFirstPC(); //Reward all Evil Team
            while ( GetIsObjectValid(oPlayer) == TRUE )
            {
             if (GetPlayerTeam(oPlayer) == 2 && oPlayer != oBestPC)
            { int nReward = REWARD_MVM_TEAM * GetHitDice(oBestPC);
              GiveGoldToCreature(oPlayer,  nReward);
              SetXP(oPlayer,(GetXP(oPlayer)+ nReward));
              //GiveXPToCreature(oPlayer,  nReward);
               }
              oPlayer = GetNextPC();
            }
    }
    else
    {
        BroadcastMessage("The round is tied, " + IntToString(nGoodScore) + " to " + IntToString(nEvilScore) + ". We have two losers!");
    }
    SetLocalInt(GetModule(), "nScore_1", 0);
    SetLocalInt(GetModule(), "nScore_2", 0);
    BroadcastMessage("Most valuable mercenary: "+ GetTeamColour(GetPlayerTeam(oBestPC))+ GetName(oBestPC) + "</c> with " + IntToString(nBestPCScore) + " points!");
    int nReward = REWARD_MVM * GetHitDice(oBestPC) *2;
    FloatingTextStringOnCreature("Congratulation!", oBestPC, FALSE);
    ///MVM REWARD ///
    DelayCommand(1.0 ,FloatingTextStringOnCreature("You can chose a special item!", oBestPC, FALSE));
    GiveGoldToCreature(oBestPC, nReward-1);
    SetXP(oBestPC,(GetXP(oBestPC)+ nReward));
    if (GetGender(oBestPC) == GENDER_FEMALE)
    {
    CreateItemOnObject("specialitemf",oBestPC);
    }
    else
    {
    CreateItemOnObject("specialitem",oBestPC);
    }
    if (GetLocalInt(GetModule(),"ValentineDay") == 1)
              {
              BroadcastMessage("Best Valentines Couple: "+GetName(oBestCouple)+ " & "+GetName(oHisValentine)+" with: "+IntToString(nBestCoupleScore)+ " points!");
              string sItemString = GetName(oBestCouple)+" & "+GetName(oHisValentine)+" are the Best Couple of 2006!";
              object oReward = CreateItemOnObject("valentinesitem",oBestCouple,1);
              SetLocalString(oReward,"OnUseShout",sItemString);
              oReward =  CreateItemOnObject("valentinesitem",oHisValentine,1);
              SetLocalString(oReward,"OnUseShout",sItemString);
              }
    //GiveXPToCreature(oBestPC, nReward);
    // Record MPV winnings
    SetLocalInt(oBestPC,"m_nGoldwinnings", (GetLocalInt(oBestPC,"m_nGoldwinnings") + nReward));
    BroadcastMessage("--------------------");
    // BroadcastMessage("Next Round: " + IntToString(GetLocalInt(GetModule(), "nRound")));
    CleanTheGame();
    ResetMapVote();
    SetRound(); //this teleport the flag bearer to the new area.
}

/////////////////////////////////////////////////////////


//decreaase Palemaster ac - riddler
void PmACDecrease(object oPC)
{

    object oAntiworld = GetObjectByTag("antiworld_npc");

    int nPmLevels = GetLevelByClass(CLASS_TYPE_PALE_MASTER,oPC);

    if (nPmLevels == 0)
    {
        nPmLevels = GetLevelByClass(CLASS_TYPE_PALEMASTER,oPC);
    }

    //FloatingTextStringOnCreature("PM Levels " + IntToString(nPmLevels),oPC);
    if (nPmLevels > 0)
    {
        int nDecrease = 1;

        nDecrease += (nPmLevels/4);

        AssignCommand(oAntiworld,ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectACDecrease(nDecrease, AC_NATURAL_BONUS)),oPC));
        FloatingTextStringOnCreature("Your ac has been decreased by " + IntToString(nDecrease),oPC,FALSE);
    }
    else return;




}


void LockCastleDoors()
{

    SetLocked(GetObjectByTag("GoodCastleExit"), TRUE);
    SetLocked(GetObjectByTag("EvilCastleExit"), TRUE);
    BroadcastMessage("The castle doors are locked.");
    SendMessageToAllDMs("Locked castle doors.");
    SetLocalInt(GetModule(), "nAllCastlesLocked", TRUE);
}


void UnlockCastleDoors()
{
    SetLocked(GetObjectByTag("GoodCastleExit"), FALSE);
    SetLocked(GetObjectByTag("EvilCastleExit"), FALSE);
    BroadcastMessage("The castle doors are unlocked!");
    SendMessageToAllDMs("Unlocked castle doors.");
    SetLocalInt(GetModule(), "nAllCastlesLocked", FALSE);
}

void ToggleAllStuff(object oPlayer)
{
    RemoveAllEffects(oPlayer);
    ApplyHaste(oPlayer);
    ApplyTumble(oPlayer);
    PmACDecrease(oPlayer);
    effect effSlow = EffectSlow();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, effSlow, oPlayer);
    DelayCommand(0.1, RemoveEffect(oPlayer, effSlow));
    effect eDarkness = EffectDarkness();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDarkness, oPlayer);
    RemoveEffect(oPlayer, eDarkness);
}

void RespawnPlayer(object oPlayer, int nSpawn)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);
    SetLocalInt(oPlayer, "SaveChar",0);
    ToggleAllStuff(oPlayer);
    if(nSpawn == TRUE)
    {
        MovePlayerToSpawn(oPlayer);
    }
}

int GetTrapsAcquired(object oPlayer)
{
    return GetLocalInt(oPlayer, "nTrapsAcquired");
}


void SetTrapsAcquired(object oPlayer, int nTraps)
{
    SetLocalInt(oPlayer, "nTrapsAcquired", nTraps);
}


void CleanTheGame()
{
//can't we just start from the first area to the last? AHAH there's not GetFirstArea() *cry*//
// 1 to 20  All areas
// 50 51 52 53 Halloween Reserved
// 98  KotH
// 100 Sudden
// 200 Tug of war
//also unlock all doors into the arenas
object oArea;
int nNumber;
for (nNumber=1;nNumber<=TOTAL_ARENAS;nNumber++)
   {
   oArea =  GetObjectByTag("arena_"+IntToString(nNumber));
   CleanDroppedItems(oArea);
   DisableTrapsInArea(oArea,100);
  }
   CleanDroppedItems(GetObjectByTag("arena_"+IntToString(98)));
   DisableTrapsInArea(GetObjectByTag("arena_"+IntToString(98)), 100);
   CleanDroppedItems(GetObjectByTag("arena_"+IntToString(100)));
   DisableTrapsInArea(GetObjectByTag("arena_"+IntToString(100)), 100);
   CleanDroppedItems(GetObjectByTag("arena_"+IntToString(200)));
   DisableTrapsInArea(GetObjectByTag("arena_"+IntToString(200)), 100);

    CleanDroppedItems(GetObjectByTag("DuelArea"));
    DisableTrapsInArea(GetObjectByTag("DuelArea"), 100);
    CleanDroppedItems(GetObjectByTag("antiworld_area"));
    DisableTrapsInArea(GetObjectByTag("antiworld_area"), 100);
    CleanDroppedItems(GetObjectByTag("HallofGods"));
    DisableTrapsInArea(GetObjectByTag("HallofGods"), 100);
    CleanDroppedItems(GetObjectByTag("Wingery"));
    DisableTrapsInArea(GetObjectByTag("Wingery"), 100);
    CleanDroppedItems(GetObjectByTag("Welcome"));
    DisableTrapsInArea(GetObjectByTag("Welcome"), 100);
    CleanDroppedItems(GetObjectByTag("Jail"));
    DisableTrapsInArea(GetObjectByTag("Jail"), 100);
    CleanDroppedItems(GetObjectByTag("GoodCastle"));
    DisableTrapsInArea(GetObjectByTag("GoodCastle"), 100);
    CleanDroppedItems(GetObjectByTag("EvilCastle"));
    DisableTrapsInArea(GetObjectByTag("EvilCastle"), 100);
    CleanDroppedItems(GetObjectByTag("DmsTemple"));
    DisableTrapsInArea(GetObjectByTag("DmsTemple"), 100);

    CleanStores();
}
//this also unlock doors
void DisableTrapsInArea(object oArea, int nChance)
{
    object oObject;

    oObject = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oObject))
    {
        if (GetIsTrapped(oObject) && d100() <= nChance)
        {
            SetTrapDisabled(oObject);
        }
        if (GetLocked (oObject)  )
        {
            SetLocked(oObject,FALSE);
        }
        oObject = GetNextObjectInArea(oArea);
    }
}


void CleanDroppedItems(object oArea)
{
    object oObject;
    oObject = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oObject))
    {
        if (GetObjectType(oObject) == OBJECT_TYPE_ITEM)
        {
            DestroyObject(oObject);
        }
        oObject = GetNextObjectInArea(oArea);
    }
}


//::///////////////////////////////////////////////
//:: CheckTeamBalance
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Compare team counts and announce if one team
    has more players than the other.
*/
//:://////////////////////////////////////////////
//:: Created By: Erich Delcamp
//:: Created On: Jul/12/02
//:://////////////////////////////////////////////

void CheckTeamBalance()
{
    int nGood = GetTeamCount(TEAM_GOOD);
    int nEvil = GetTeamCount(TEAM_EVIL);

    // Check if the larger team has at least 2 more players than the other
    // team. We don't care if a team has a 1 player advantage.
    // An odd number of players will always have a team with a 1 player
    // advantage, you see.
    if ((nGood - 1) > nEvil)
    {
        SetPlayersNeeded((nGood - 1) - nEvil, TEAM_EVIL);
    }
    else if ((nEvil - 1) > nGood)
    {
        SetPlayersNeeded((nEvil - 1) - nGood, TEAM_GOOD);
    }
    else
    {
        SetPlayersNeeded(0, TEAM_NONE);
    }
}


void SetPlayersNeeded(int nPlayers, int nTeam)
{
    int nGood = GetTeamCount(TEAM_GOOD);
    int nEvil = GetTeamCount(TEAM_EVIL);
    SetLocalInt(GetModule(), "nPlayersNeeded", nPlayers);
    SetLocalInt(GetModule(), "nTeamPlayersNeeded", nTeam);
    object oPlayer;
    if (nTeam != TEAM_NONE)
    {
        // Remember, we only care if a team is outnumbered by more than
        // 2 players. The nPlayers variable is actually the number of players
        // nTeam is short, minus 1. When we broadcast the next warning, nPlayers
        // needs a +1 so it's not confusing to the players.
        BroadcastMessage("YOU OUTNUMBER THE ENEMY TEAM BY " + IntToString(nPlayers + 1 ) , 3 - nTeam);
        if (nPlayers >= 2 || nGood == 0 || nEvil == 0)
        {
            BroadcastMessage(GetTeamName(3 - nTeam) + " CANNOT LEAVE THEIR CASTLE UNTIL THE TEAMS ARE MORE EVEN!");
            if ((3 - nTeam) == TEAM_GOOD)
            {
                SetLocked(GetObjectByTag("GoodCastleExit"), TRUE);
            }
            else if ((3 - nTeam) == TEAM_EVIL)
            {
                SetLocked(GetObjectByTag("EvilCastleExit"), TRUE);
            }
        }
    }
    if (GetLocalInt(GetModule(), "nAllCastlesLocked") == FALSE &&
        nPlayers < 2 &&
        (GetLocked(GetObjectByTag("GoodCastleExit")) == TRUE ||
         GetLocked(GetObjectByTag("EvilCastleExit")) == TRUE))
    {
        UnlockCastleDoors();
        BroadcastMessage("THE CASTLE DOORS ARE OPEN AGAIN.");
    }
}




int GetPlayersNeeded()
{
    return GetLocalInt(GetModule(), "nPlayersNeeded");
}


int GetWeakTeam()
{
    return GetLocalInt(GetModule(), "nTeamPlayersNeeded");
}


//:://///////////////////////////////////////////////////
//:: GetKillRangeResult()
//:://///////////////////////////////////////////////////
//::       Return true if  the two players are into allowed kill range
//:://///////////////////////////////////////////////////
//:: Created By: Jantima
//:: Created On: Feb/13/05
//:://///////////////////////////////////////////////////
// Return true if  the two players are into allowed kill range.
int GetKillRangeResult(object oPC, object oPlayer)
{
int nLevel = GetTotalPlayerLevel(oPC);
int nUserLevel = GetTotalPlayerLevel(oPlayer);

if((nLevel+5) >= nUserLevel && nUserLevel >= (nLevel-5))
return TRUE;
else return FALSE;
}
//:://///////////////////////////////////////////////////
//:: SelectPlayer()
//:://///////////////////////////////////////////////////
//::      Store on the GM the selected player
//:://///////////////////////////////////////////////////
//:: Created By: Jantima
//:: Created On: Feb/13/05
//:://///////////////////////////////////////////////////
void SelectPlayer(object oGM, int nNumber)
{
 string sMyTarget = GetLocalString(oGM,IntToString(nNumber));
 object oPlayer = GetFirstPC();
 object oMyTarget;
 int bValid = 0;
 while (GetIsObjectValid(oPlayer) && bValid != 1)
    {
    if(GetName(oPlayer) ==  sMyTarget)
       {
       SetLocalObject(oGM,"MyTarget",oPlayer);
       bValid = 1;
       oMyTarget = oPlayer;
       }
    oPlayer = GetNextPC();
    }

if (  bValid != 1)   FloatingTextStringOnCreature("Player not found",oGM,FALSE);
else FloatingTextStringOnCreature("Player found: "+ GetName(oMyTarget),oGM,FALSE);
  //the target is stored now , se let's delete all the other local string on the gm
    int count = 101;
    int TotalPlayers = GetLocalInt(oGM,"playersnumber");
    for ( count=101;count<=TotalPlayers; count++)
        {
        DeleteLocalString(oGM,IntToString(count));
        }
DeleteLocalInt(oGM,"playersnumber");
}

//////////////////////////////////////////

//:://///////////////////////////////////////////////////
//:: SelectValentine()
//:://///////////////////////////////////////////////////
//::      Store on the Player the selected valentine
//:://///////////////////////////////////////////////////
//:: Created By: Jantima
//:: Created On: Feb/13/05
void SelectValentine(object oPC, int nNumber);
//:://///////////////////////////////////////////////////
void SelectValentine(object oPC, int nNumber)
{
 object oValentine = GetLocalObject(oPC,IntToString(nNumber));
if (!GetIsObjectValid( oValentine))   FloatingTextStringOnCreature("<céOÙ>Player not found!</c>",oPC,FALSE);
else
{
FloatingTextStringOnCreature("Player found: "+ GetName(oValentine),oPC,FALSE);
//Send the message to the chosed player
FloatingTextStringOnCreature("<céOÙ>"+GetName(oPC)+" want you to be your Valentine!</c>",oValentine, FALSE);
DelayCommand(2.0,FloatingTextStringOnCreature("<céOÙ>Talk to Cupid in castle to know how to accept!</c>",oValentine, FALSE));
///Increase the number of invitations, and store the inviter
SetLocalInt(oValentine,"invitations",GetLocalInt(oValentine,"invitations")+1);
SetLocalObject(oValentine,"inviter"+IntToString(GetLocalInt(oValentine,"invitations")+400),oPC);
//check if the is already a inviter !///
}
    int count = 301;
    int TotalPlayers = GetLocalInt(oPC,"playersnumber");
    for ( count=301;count<=TotalPlayers; count++)
        {
        DeleteLocalObject(oPC,IntToString(count));
        }
DeleteLocalInt(oPC,"playersnumber");
}

///ValentineResult: 0= match found: valentine saved
///// 1= no allowed killrange  2= same team 3= object invalid(left/crashed)
//// 4= the object already have another valentine!
void AcceptValentine(object oPC,int nNumber);
void AcceptValentine(object oPC,int nNumber)
{
object oMyValentine = GetLocalObject(oPC,"inviter"+IntToString(nNumber));
SetCustomToken(5000,GetName(oMyValentine));
if(GetIsObjectValid(oMyValentine))
   {
   if (3-GetPlayerTeam(oPC)== GetPlayerTeam(oMyValentine))
      {
      if (GetKillRangeResult(oPC,oMyValentine))
         {
         if (GetLocalObject(oMyValentine,"MyValentine") != OBJECT_INVALID)
            {
            //// This player already have a Valentine, You're Late!
            FloatingTextStringOnCreature( "This player already have a Valentine, You're Late!",oPC, FALSE);
            SetLocalInt(oPC,"ValentineResult",4);
            }
         else
            {
            SetLocalObject(oPC,"MyValentine",oMyValentine);
            SetLocalObject(oMyValentine,"MyValentine",oPC);
            FloatingTextStringOnCreature(GetName(oPC)+" Accepted to be your Valentine! Enjoy Valentine's Day!",oMyValentine, FALSE);
            FloatingTextStringOnCreature(GetName(oMyValentine)+" Is Your Valentine! Enjoy Valentine's Day!",oPC, FALSE);
            SetLocalInt(oPC,"ValentineResult",0);
            ///match accepted.
            }
         }
      else
         {
         FloatingTextStringOnCreature( "This object is no longer into your kill range...",oPC, FALSE);
         SetLocalInt(oPC,"ValentineResult",1);
         }
      }
   else
       {
       FloatingTextStringOnCreature( "the selected player is on your same team!",oPC, FALSE);
       SetLocalInt(oPC,"ValentineResult",2);
       }
   }
else
    {
    FloatingTextStringOnCreature( "Object is not valid",oPC, FALSE);
    SetLocalInt(oPC,"ValentineResult",3);
    }

}

void CleanStores()
{ // start main
string sShop1 = "ArmorStore";
string sShop2 = "CloackBootsStore";
string sShop3 = "MageStore";
string sShop4 = "ThievesStore";
string sShop5 = "WeaponStore" ;
//string sShop6 = "JailKeeperStore"
// create object variable for store object (self)
int nStr, nNth;
for(nStr=1;nStr<=5;nStr++)
   {
   for (nNth=0;nNth<=1;nNth++)
     {
     object oStore = GetObjectByTag("sShop"+IntToString(nStr),nNth);
     object oItem = GetFirstItemInInventory(oStore);
     while(GetIsObjectValid(oItem))
        {
        if(GetLocalInt(oItem, "PCItem") != 0)
          {
          DestroyObject(oItem);
          }
       oItem = GetNextItemInInventory(oStore);
       }
    }
  }
object oStore = GetObjectByTag("JailKeeperStore",0);
     object oItem = GetFirstItemInInventory(oStore);
     while(GetIsObjectValid(oItem))
        {
        if(GetLocalInt(oItem, "PCItem") != 0)
          {
          DestroyObject(oItem);
          }
       oItem = GetNextItemInInventory(oStore);
       }
}


int Max(int val1, int val2)
{
    if (val1 > val2) { return val1; }
    else { return val2; }
}

int Min(int val1, int val2)
{
    if (val1 < val2) { return val1; }
    else { return val2; }
}

void SendMessageToGM(string sMessage)
{
    object oMod = GetModule();
    object oGM;
    int i;
    for (i = 0; i < 32; i++)
    {
        oGM = GetLocalObject(oMod, "GM" + IntToString(i));
        if (GetIsObjectValid(oGM))
        {
            SendMessageToPC(oGM, sMessage);
        }
    }

}
///////////////////////////////
// tow_utility
// Scripted By: Demon X
// For: Antiworld
// this is an include file for all the functions used in Tug-of-War
//////////////////////////////////////////////////////////////////

void TOW_BroadcastMessage(string sString)
{
object oPC = GetFirstPC();
while(oPC != OBJECT_INVALID)
    {
    SendMessageToPC(oPC,sString);
    oPC = GetNextPC();
    }
}
void TOW_AddTeamScore(int nTeam, int nScore)
{
    string szScoreVar = "nScore_" + IntToString(nTeam);
    int nCurrentScore = GetLocalInt(GetModule(), szScoreVar);
    int nGoodScore, nEvilScore;
    nCurrentScore += nScore;
    SetLocalInt(GetModule(), szScoreVar, nCurrentScore);
    nGoodScore = GetLocalInt(GetModule(), "nScore_1");
    nEvilScore = GetLocalInt(GetModule(), "nScore_2");
    TOW_BroadcastMessage("Good: " + IntToString(nGoodScore) + "  Evil: " + IntToString(nEvilScore));
}
void RewardTugOfWar(int nReward, object oPC, int nTeam, int nScore)
{
    object oPlayer;
    oPlayer = GetFirstPC();
    while ( GetIsObjectValid(oPlayer) == TRUE  )
    {
        if ((nTeam == GetLocalInt(oPlayer, "nTeam")) &&
            (GetTag(GetArea(oPlayer)) == ("arena_"+IntToString(GetLocalInt(GetModule(), "nRound"))))
            && (nTeam == 1 || nTeam == 2))
        {
            GiveGoldToCreature(oPlayer, nReward);
            SetLocalInt(oPlayer,"m_nGoldwinnings", (GetLocalInt(oPlayer,"m_nGoldwinnings") +  nReward));
            SetXP(oPlayer,(GetXP(oPlayer)+ nReward));
        }
        oPlayer = GetNextPC();
    }
    TOW_AddTeamScore(nTeam, nScore);
}

/* void RemoveAllEffects(object oObject)
{
effect eEffect = GetFirstEffect(oObject);
while(GetIsEffectValid(eEffect) != FALSE)
    {
    RemoveEffect(oObject,eEffect);
    eEffect = GetNextEffect(oObject);
    }
RemoveEffect(oObject,eEffect);
}
*/
void RemoveAllBeams(object oObject)
{
effect eEffect = GetFirstEffect(oObject);
while(GetIsEffectValid(eEffect) != FALSE)
    {
    if(GetEffectType(eEffect)==EFFECT_TYPE_BEAM)
        RemoveEffect(oObject,eEffect);
    eEffect = GetNextEffect(oObject);
    }
RemoveEffect(oObject,eEffect);
}
void StartAvatars()
{
object oGoodAvatar = GetNearestObjectByTag("0");
object oEvilAvatar = GetNearestObjectByTag("9");
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_HOLY,GetNearestObjectByTag("Middle0"),BODY_NODE_CHEST)),oGoodAvatar);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_EVIL,GetNearestObjectByTag("Middle8"),BODY_NODE_CHEST)),oEvilAvatar);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_HOLY,GetNearestObjectByTag("1"),BODY_NODE_CHEST)),GetNearestObjectByTag("Middle0"));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_EVIL,GetNearestObjectByTag("8"),BODY_NODE_CHEST)),GetNearestObjectByTag("Middle8"));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_ICESKIN)),oGoodAvatar);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_BLUR)),oGoodAvatar);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR)),oEvilAvatar);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_PARALYZED)),oEvilAvatar);
}
void ResetTugOfWar(object oAvatar)
{
int nVFX, nVFX2, nLink, nDirection, nLoop;
string sLock, sLink;
string sTag = GetTag(oAvatar);
object oLink;
if(sTag == "0")
    {
    sLock = "UnlockEvil";
    sLink = "9";
    nDirection = 1;
    nVFX = VFX_IMP_HARM;
    nVFX2 = VFX_FNF_PWKILL;
    }
if(sTag == "9")
    {
    sLock = "UnlockGood";
    sLink = "0";
    nDirection = 2;
    nVFX = VFX_FNF_STRIKE_HOLY;
    nVFX2 = VFX_FNF_WORD;
    }
SetLocalInt(oAvatar,sLock,0);
nLoop = 0;
oLink = GetNearestObjectByTag(sLink);
SetLocalInt(oLink,"AvatarHP",500);
nLink = StringToInt(sLink);
float fLoop;
while(nLoop != 9)
    {
    fLoop = IntToFloat(nLoop);
    DelayCommand(fLoop,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(nVFX),oLink));
    DelayCommand(fLoop,AssignCommand(oLink,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
    SetLocalInt(oLink,"LinkHP",100);
    if(nLoop != 0)
        DelayCommand(fLoop,RemoveAllEffects(oLink));
        SetLocalInt(oLink,"LinkClaimed",0);
    if(nLoop != 1)
        {
            SetLocalInt(oLink,sLock,0);
        }
    if(nDirection == 2)
        {nLink = nLink+1;}
    else if(nDirection == 1)
        {nLink = nLink-1;}
    sLink = IntToString(nLink);
    oLink = GetNearestObjectByTag(sLink);
    nLoop = nLoop+1;
    }
RemoveAllEffects(GetNearestObjectByTag("Middle08"));
RemoveAllEffects(GetNearestObjectByTag("Middle0"));
DelayCommand(fLoop+1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(nVFX2),oAvatar));
SetLocalInt(oAvatar,"AvatarHP",500);
DelayCommand(fLoop+2.0,StartAvatars());
}
void EndTugOfWar(int nRound)
{
/* object oArea = GetObjectByTag("arena_"+IntToString(nRound));
object oFirst = GetFirstObjectInArea(oArea);
object oAvatar = GetNearestObjectByTag("0",oFirst);
if(oAvatar != OBJECT_INVALID)    */
 ExecuteScript("tow_reset", GetObjectByTag("0"));
  //  ResetTugOfWar(GetObjectByTag("0"));
}
//////////////////////////
//end Tug of War utility
/*void TrackShifterEnter(object oPC);

void TrackShifterEnter(object oPC)
{
  if (GetLevelByClass(CLASS_TYPE_SHIFTER, oPC) > 0)
  {
    string SQL = "INSERT INTO player_shifters VALUES ('";
    SQL += GetPCPlayerName(oPC) + "','";
    SQL += GetName(oPC) + "','";
    SQL += IntToString(GetLevelByClass(CLASS_TYPE_SHIFTER, oPC)) + "','";
    SQL += IntToString(GetAppearanceType(oPC)) + "',now(),'0')";
    SQL += "ON DUPLICATE KEY UPDATE shifter_level = '";
    SQL += IntToString(GetLevelByClass(CLASS_TYPE_SHIFTER, oPC));
    SQL += "', shifter_shape = '";
    SQL += IntToString(GetAppearanceType(oPC));
    SQL += "', loggedin = now()";
    SQLExecDirect(SQL);
  }
}

void TrackShifterExit(object oPC)
{
  if (GetLevelByClass(CLASS_TYPE_SHIFTER, oPC) > 0)
  {
    string SQL = "DELETE FROM player_shifters WHERE charname = '";
    SQL += GetName(oPC) + "')";
    SQLExecDirect(SQL);
  }
}

void TrackShifterModuleLoad()
{
  string SQL = "SELECT account, charname, shifter_level, shifter_shape, loggedin FROM player_shifters GROUP BY account, charname, shifter_level, shifter_shape, loggedin";
  SQLExecDirect(SQL);
  while (SQLFetch() == SQL_SUCCESS)
  {
    WriteTimestampedLogEntry("Shifter account: " + SQLGetData(1) + " char:" + SQLGetData(2) + " lvl:" + SQLGetData(3) + " shape:" + SQLGetData(4) + " logintime:" + SQLGetData(5));

  }
  SQL = "TRUNCATE TABLE player_shifters";
  SQLExecDirect(SQL);
}     */


