//::///////////////////////////////////////////////
//:: ANTIWORLD CAPTURE THE FLAG Death Script
//::
//::
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a player dies.
*/
//:://////////////////////////////////////////////
//:: Created By: Erich Delcamp
//:: Edited and developed by Jantima
//:: Created On: Jul/05/2002
//:: Modified By: Scott "Seira" Shepherd (Winnings Code)
//:: Modified By: Nilas_87  (king of the hill)
//:: Modified On: Nov/17/2004
//:://////////////////////////////////////////////
#include "inc_bs_module"
#include "ld_inc_gwshp"
#include "x0_i0_position"
#include "aw_include"
#include "zzz_huntinclude"
//:://////////////////////////////////////////////
//::Apply the Effy Kill Penguin Effect To The killer
//::The Duration is found by the effy killed level
//:://////////////////////////////////////////////
//I'm attempting to modify this function by adding the variable 'nSkin' which determines whether
//the killer is turned into a penguin (for killing an effy) a chicken (for killing someone more than
//five levels above) or a cow (for killing a team member). Also, I'm defining the duration of the effect
//in in a different part of the script rather than within the penguin function to make things easier (hopefully).
//-Moff
void PenguinizeEffyKiller(object oKiller,object oDead, int nSkin, float PenguDuration);
void PenguinizeEffyKiller(object oKiller,object oDead, int nSkin, float PenguDuration)
{
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(), oKiller, PenguDuration/2);
    effect ePenguinEffect = EffectPolymorph(nSkin, TRUE);
    effect eSlow =  EffectSlow();
    ePenguinEffect = EffectLinkEffects(ePenguinEffect, eSlow);
    ePenguinEffect = SupernaturalEffect(ePenguinEffect);

    effect eLook = GetFirstEffect(oKiller);
    while(GetIsEffectValid(eLook))
    {
        if( GetEffectType(eLook) == EFFECT_TYPE_ETHEREAL ||
            GetEffectType(eLook) == IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE ||
            GetEffectType(eLook) == EFFECT_TYPE_SANCTUARY ||
            GetEffectType(eLook) == EFFECT_TYPE_INVISIBILITY
            || GetEffectSpellId(eLook) == SPELL_FREEDOM_OF_MOVEMENT)
        {
            RemoveEffect(oKiller, eLook);
        }
        eLook = GetNextEffect(oKiller);
    }

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePenguinEffect, oKiller, PenguDuration);
    SetLocalInt(oKiller, "Pengy", TRUE);
    DelayCommand(PenguDuration, DeleteLocalInt(oKiller, "Pengy"));
}
//:://////////////////////////////////////////////
//::Apply the cow polymorph effect To The killer
//::
//:://///////////////////////////////////////////
void TeamKillPenalise(object oKiller, object oDead);
void TeamKillPenalise(object oKiller, object oDead)
{
   AddPlayerScore(oKiller, -PLAYERS_EASY_KILL_CONSTANT);
   //SendMessageToAllDMs (GetName(oKiller)+ " Killed " + GetName(oDead)+ " Who is same Team!");
   SendMessageToGM(GetName(oKiller)+ " Killed " + GetName(oDead)+ " Who is same Team!");
   FloatingTextStringOnCreature("You killed your team member!", oKiller, FALSE);
   int nSkin = POLYMORPH_TYPE_COW;
   float PenguDuration = 60.0f;
   PenguinizeEffyKiller(oKiller,oDead,nSkin,PenguDuration);
}
//:://////////////////////////////////////////////
//::ReWard The Kill
//::
//:://////////////////////////////////////////////
void RewardKill(object oKiller,object oDead,int nKillerTeam, int nDeadTeam);
void RewardKill(object oKiller,object oDead,int nKillerTeam, int nDeadTeam)
{
    SendMessageToPC(oKiller, "Good kill! The King of " + GetTeamName(GetPlayerTeam(oKiller)) + " rewards you.");
    int nHitDice = GetHitDice(oKiller);
    int nScore = 0;
    if (nHitDice != 0)
    {
        nScore = (((GetHitDice(oDead) * 10) / nHitDice)-PLAYERS_EASY_KILL_CONSTANT);
    }
    ///Valentine's Day double player points
    if ((GetLocalInt(GetModule(),"ValentineDay") == 1) && (oKiller == GetLocalObject(oDead,"MyValentine")) && (oDead == GetLocalObject(oKiller,"MyValentine")))  nScore = nScore*2;
    AddPlayerScore(oKiller, nScore);
    FloatingTextStringOnCreature("Kill Bonus", oKiller, FALSE);
    int nReward = 0;
    if (nHitDice != 0) //do not divide by zero!!!
    {
       nReward = REWARD_KILLER * (((GetHitDice(oDead) * 10) / nHitDice)-PLAYERS_EASY_KILL_CONSTANT);
    }
    ///Valentine's Day double reward
    if ((GetLocalInt(GetModule(),"ValentineDay") == 1) && (oKiller == GetLocalObject(oDead,"MyValentine")) && (oDead == GetLocalObject(oKiller,"MyValentine")))  nReward = nReward*2;
    GiveGoldToCreature(oKiller,  nReward);
    // Record winnings
    SetLocalInt(oKiller,"m_nGoldwinnings", (GetLocalInt(oKiller,"m_nGoldwinnings") + nReward));
    // Increment kills by one.
    SetLocalInt(oKiller,"m_nKills", (GetLocalInt(oKiller,"m_nKills") +1) );
    SetXP(oKiller,(GetXP(oKiller)+ nReward)); //CTF focus
    //GiveXPToCreature(oKiller,  nReward);
    // REWARD XP Team
    RewardTeamKill(REWARD_XP_TEAM_WINNERS * (((GetHitDice(oDead) * 10) / nHitDice)-PLAYERS_EASY_KILL_CONSTANT), oKiller, nKillerTeam, nScore);
}
//::////////////////////////////////////////////////
//::RewardHuntKill
//::Different XP rewards in The Hunt from normal game
//::////////////////////////////////////////////////
void RewardHuntKill(object oKiller,object oDead,int nKillerTeam, int nDeadTeam, int nKillType);
void RewardHuntKill(object oKiller,object oDead,int nKillerTeam, int nDeadTeam, int nKillType)
{
    switch (nKillType)
    {
    //////////////////////////////////////////////////////
    // 1 means Hunter kills Hunter. Same as killing a -5.
    /////////////////////////////////////////////////////
    case 1:
    {
    SendMessageToPC(oKiller, "Good kill! The King of " + GetTeamName(GetPlayerTeam(oKiller)) + " rewards you.");
    int nHitDice = GetHitDice(oKiller);
    int nScore = 1;
    ///Valentine's Day double player points
    if ((GetLocalInt(GetModule(),"ValentineDay") == 1) && (oKiller == GetLocalObject(oDead,"MyValentine")) && (oDead == GetLocalObject(oKiller,"MyValentine")))
        {
            nScore = nScore*2;
        }
    AddPlayerScore(oKiller, nScore);
    FloatingTextStringOnCreature("Kill Bonus", oKiller, FALSE);
    int nReward = 0;
    if (nHitDice != 0) //do not divide by zero!!!
        {
            nReward = REWARD_KILLER * ((((nHitDice-5) * 10) / nHitDice)-PLAYERS_EASY_KILL_CONSTANT);
        }
    ///Valentine's Day double reward
    if ((GetLocalInt(GetModule(),"ValentineDay") == 1) && (oKiller == GetLocalObject(oDead,"MyValentine")) && (oDead == GetLocalObject(oKiller,"MyValentine")))
        {
            nReward = nReward*2;
        }
    GiveGoldToCreature(oKiller,  nReward);
    // Record winnings
    SetLocalInt(oKiller,"m_nGoldwinnings", (GetLocalInt(oKiller,"m_nGoldwinnings") + nReward));
    // Increment kills by one.
    SetLocalInt(oKiller,"m_nKills", (GetLocalInt(oKiller,"m_nKills") +1) );
    SetXP(oKiller,(GetXP(oKiller)+ nReward)); //CTF focus
    //GiveXPToCreature(oKiller,  nReward);
    // REWARD XP Team
    RewardTeamKill((REWARD_XP_TEAM_WINNERS * ((((nHitDice-5) * 10) / nHitDice)-PLAYERS_EASY_KILL_CONSTANT)), oKiller, nKillerTeam, nScore);
    break;
    }

    ///////////////////////////////////////////////////////////////////
    // 2 means Hunter kills Monster. 25 points and XP/GP = capped flag
    ///////////////////////////////////////////////////////////////////
    case 2:
    {
    FloatingTextStringOnCreature("Well done!", oKiller, FALSE);
    //Reward player for killing the monster
    int nReward;
    nReward = REWARD_XP_WINNERS * GetHitDice(oKiller) * 2;
    GiveGoldToCreature(oKiller,nReward);
    SetXP(oKiller,(GetXP(oKiller)+ nReward));
    //GiveXPToCreature(oCapturingPlayer, nReward);

    //Reward all the team
    float fDelay;
    object oPlayer = GetFirstPC();
    while ( GetIsObjectValid(oPlayer) == TRUE )
    {
        ///SendMessageToPC(oPlayer, sMessage);
        if (nKillerTeam == GetLocalInt(oPlayer, "nTeam") && oPlayer != oKiller && (GetTag(GetArea(oPlayer)) == ("arena_"+IntToString(GetLocalInt(GetModule(), "nRound")))) && GetTag(GetArea(oPlayer)) != "RedWings")
        {   nReward = REWARD_XP_WINNERS * GetHitDice(oPlayer);
            GiveGoldToCreature(oPlayer, nReward);
            SetLocalInt(oPlayer,"m_nGoldwinnings", (GetLocalInt(oPlayer,"m_nGoldwinnings") + nReward));
            DelayCommand(fDelay, SetXP(oPlayer,(GetXP(oPlayer)+ nReward)));
            fDelay += 0.1;
        }
        oPlayer = GetNextPC();
    }
    AddPlayerScore(oKiller, 25);
    AddTeamScore(nKillerTeam, 25);
    break;
    }
    //////////////////////////////////////////////////////////////////////////////////////
    // 3 means Monster kills Hunter. 5 points and XP/GP = killing person who is your level.
    //////////////////////////////////////////////////////////////////////////////////////
    case 3:
    {
    SendMessageToPC(oKiller, "Good kill! The King of " + GetTeamName(GetPlayerTeam(oKiller)) + " rewards you.");
    int nHitDice = GetHitDice(oKiller);
    int nScore = 5;
    ///Valentine's Day double player points
    if ((GetLocalInt(GetModule(),"ValentineDay") == 1) && (oKiller == GetLocalObject(oDead,"MyValentine")) && (oDead == GetLocalObject(oKiller,"MyValentine")))  nScore = nScore*2;
    AddPlayerScore(oKiller, nScore);
    FloatingTextStringOnCreature("Kill Bonus", oKiller, FALSE);
    int nReward = 0;
        if (nHitDice != 0) //do not divide by zero!!!
        {
            nReward = REWARD_KILLER * ((((nHitDice) * 10) / nHitDice)-PLAYERS_EASY_KILL_CONSTANT);
        }
    ///Valentine's Day double reward
    if ((GetLocalInt(GetModule(),"ValentineDay") == 1) && (oKiller == GetLocalObject(oDead,"MyValentine")) && (oDead == GetLocalObject(oKiller,"MyValentine")))  nReward = nReward*2;
    GiveGoldToCreature(oKiller,  nReward);
    // Record winnings
    SetLocalInt(oKiller,"m_nGoldwinnings", (GetLocalInt(oKiller,"m_nGoldwinnings") + nReward));
    // Increment kills by one.
    SetLocalInt(oKiller,"m_nKills", (GetLocalInt(oKiller,"m_nKills") +1) );
    SetXP(oKiller,(GetXP(oKiller)+ nReward)); //CTF focus
    //GiveXPToCreature(oKiller,  nReward);
    // REWARD XP Team
    RewardTeamKill((REWARD_XP_TEAM_WINNERS * ((((nHitDice) * 10) / nHitDice)-PLAYERS_EASY_KILL_CONSTANT)), oKiller, nKillerTeam, nScore);
    break;
    }
    //////////////////////////////////////////////////////////////////////////////////////////////
    // 4 means Monster kills Monster. 10 points, flag cap XP/GP
    // I want to encourage hunter vs monster rather than monster vs monster hence the lower score
    /////////////////////////////////////////////////////////////////////////////////////////////
    case 4:
    {
    if ( GetLocalInt(oKiller, "LegendHunter") == TRUE )
    {
    FloatingTextStringOnCreature("Well done!", oKiller, FALSE);
    //Reward player for killing the monster
    int nReward;
    nReward = 90 * GetHitDice(oKiller) * 2;
    GiveGoldToCreature(oKiller,nReward);
    SetXP(oKiller,(GetXP(oKiller)+ nReward));
    //GiveXPToCreature(oCapturingPlayer, nReward);

    //Reward all the team
    float fDelay;
    object oPlayer = GetFirstPC();
    while ( GetIsObjectValid(oPlayer) == TRUE )
    {
        ///SendMessageToPC(oPlayer, sMessage);
        if (nKillerTeam == GetLocalInt(oPlayer, "nTeam") && oPlayer != oKiller && (GetTag(GetArea(oPlayer)) == ("arena_"+IntToString(GetLocalInt(GetModule(), "nRound")))) && GetTag(GetArea(oPlayer)) != "RedWings")
        {   nReward = 90 * GetHitDice(oPlayer);
            GiveGoldToCreature(oPlayer, nReward);
            SetLocalInt(oPlayer,"m_nGoldwinnings", (GetLocalInt(oPlayer,"m_nGoldwinnings") + nReward));
            DelayCommand(fDelay, SetXP(oPlayer,(GetXP(oPlayer)+ nReward)));
            fDelay += 0.1;
        }
        oPlayer = GetNextPC();
    }
    AddPlayerScore(oKiller, 15);
    AddTeamScore(nKillerTeam, 15);
    }
    else
    {
    FloatingTextStringOnCreature("Well done!", oKiller, FALSE);
    //Reward player for killing the monster
    int nReward;
    nReward = REWARD_XP_WINNERS * GetHitDice(oKiller) * 2;
    GiveGoldToCreature(oKiller,nReward);
    SetXP(oKiller,(GetXP(oKiller)+ nReward));
    //GiveXPToCreature(oCapturingPlayer, nReward);

    //Reward all the team
    float fDelay;
    object oPlayer = GetFirstPC();
    while ( GetIsObjectValid(oPlayer) == TRUE )
    {
        ///SendMessageToPC(oPlayer, sMessage);
        if (nKillerTeam == GetLocalInt(oPlayer, "nTeam") && oPlayer != oKiller && (GetTag(GetArea(oPlayer)) == ("arena_"+IntToString(GetLocalInt(GetModule(), "nRound")))) && GetTag(GetArea(oPlayer)) != "RedWings")
        {   nReward = REWARD_XP_WINNERS * GetHitDice(oPlayer);
            GiveGoldToCreature(oPlayer, nReward);
            SetLocalInt(oPlayer,"m_nGoldwinnings", (GetLocalInt(oPlayer,"m_nGoldwinnings") + nReward));
            DelayCommand(fDelay, SetXP(oPlayer,(GetXP(oPlayer)+ nReward)));
            fDelay += 0.1;
        }
        oPlayer = GetNextPC();
    }
    AddPlayerScore(oKiller, 10);
    AddTeamScore(nKillerTeam, 10);
    }
    break;
    }
    ///////////////////////////////////////////////////////
    //Team kill, subtract 5 points and KD + Stun the player
    ////////////////////////////////////////////////////////
    case 5:
    {
        AddPlayerScore(oKiller, -PLAYERS_EASY_KILL_CONSTANT);
        SendMessageToGM(GetName(oKiller)+ " Killed " + GetName(oDead)+ " Who is same Team!");
        FloatingTextStringOnCreature("You killed your team member!", oKiller, FALSE);
        effect eKD = EffectKnockdown();
        effect eStun = EffectStunned();
        effect ePenalty;
        ePenalty = EffectLinkEffects(eKD, eStun);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePenalty, oKiller, TurnsToSeconds(1));
    }
    }
}
//:://////////////////////////////////////////////
//:: ManageDeathEvent
//::
//:://////////////////////////////////////////////
void ManageDeathEvent(int nRound, object oKiller, object oDead,int nKillerTeam, int nDeadTeam);
void ManageDeathEvent(int nRound, object oKiller, object oDead,int nKillerTeam, int nDeadTeam)
{
    DeleteLocalInt(oKiller, "Pengy");
    if (nRound == 98)         //........... King Of The Hill ..........//
    {
        object oThrone = GetObjectByTag("ThroneKH");
        object oKing = GetLocalObject(oThrone,"oKing") ;
        object oLastking = GetLocalObject(oThrone, "oLastKing");
        if (oKing == oDead)
        {
            BroadcastMessage(GetTeamColour(nKillerTeam)+GetName(oKiller)+"["+IntToString(GetHitDice(oKiller))+"]</c> killed " +GetTeamColour(nDeadTeam)+GetName(oDead)+"["+IntToString(GetHitDice(oDead))+"], who was sitting in the Throne</c>.");
            //SpeakString(GetTeamColour(nPCTeam)+GetTeamName(nPCTeam)+" has lost the hill", TALKVOLUME_SHOUT);
            BroadcastMessage(GetTeamColour(nDeadTeam)+GetTeamName(nDeadTeam)+" has lost the hill </c>");
        }
        else
        {
            BroadcastMessage(GetTeamColour(nKillerTeam)+GetName(oKiller)+"["+IntToString(GetHitDice(oKiller))+"]</c> killed " +GetTeamColour(nDeadTeam)+GetName(oDead)+"["+IntToString(GetHitDice(oDead))+"]</c>.");
        }

        if (GetIsPC(oKiller) == TRUE && GetIsEnemyTeam(oKiller,oDead))   // if enemy team
        {
        if (GetIsPC(oKiller) == TRUE && GetIsEnemyTeam(oKiller, oDead)) // if enemy team
        {
            if ( abs(GetHitDice(oKiller) - GetHitDice(oDead) ) > 5 )   //if easy/imp kill
            {
                if ((GetHitDice(oKiller) - GetHitDice(oDead)) > 5)
                {
                  FloatingTextStringOnCreature("Effy Kill!", oKiller, FALSE);
                 if (((oKing != oDead) && (oKing != oKiller) && (oLastking != oDead) && (oLastking != oKiller)))// if no one was the king or the lastking
                  {
                     ///PENGUINIZE////
                     float PenguDuration = (IntToFloat(GetHitDice(oKiller) - GetHitDice(oDead))*3);
                     int nSkin = POLYMORPH_TYPE_PENGUIN;
                     PenguinizeEffyKiller(oKiller,oDead,nSkin,PenguDuration);
                  }
                }
                else
                {
                    FloatingTextStringOnCreature("You have killed someone above your level range!", oKiller, FALSE);
                    if (((oKing != oDead) && (oKing != oKiller) && (oLastking != oDead) && (oLastking != oKiller) && (GetLocalInt(oDead, "Pengy") != TRUE) && !GetLocalInt(oDead, "UsingBackToCastle") ))// if no one was the king or the lastking
                    {
                        ///PENGUINIZE////
                        float PenguDuration = (IntToFloat(abs(GetHitDice(oKiller) - GetHitDice(oDead)))*3);
                        int nSkin = POLYMORPH_TYPE_CHICKEN;
                        PenguinizeEffyKiller(oKiller,oDead,nSkin,PenguDuration);
                    }
                        else //We want the effies to be able to kill penguins/chickens/cows!
                        {
                            RewardKill(oKiller,oDead,nKillerTeam,nDeadTeam);
                        }
                 }

            }
                ///else: one of the two is the king
            }
            // Else reward  // is not  a easy/imp kill
            else
            {
                RewardKill(oKiller,oDead,nKillerTeam, nDeadTeam);
            }
            /////else:  is a team kill
        }
        else if ((nKillerTeam != TEAM_NONE) &&  GetIsPC(oKiller) == TRUE && !GetIsEnemyTeam(oKiller, oDead))
        {
            TeamKillPenalise(oKiller, oDead);
        }
    } // End of Koth Special

    else if (nRound == 999)         //........... The Hunt ..........//
    {
        int nMonsterKiller = GetLocalInt(oKiller, "Monster");
        int nMonsterDead = GetLocalInt(oDead, "Monster");
        int nLegend = GetLocalInt(oKiller, "LegendHunter");
        SetLocalInt(oDead,"m_nDeaths", (GetLocalInt(oDead,"m_nDeaths") + 1) );
        int nStatue = d4(1);
        if ((nStatue == 1) && (GetLocalInt(GetObjectByTag("zzz_statnw"), "StatueUsed") != TRUE))
        {
            nStatue = 2;
            if ((nStatue == 2) && (GetLocalInt(GetObjectByTag("zzz_statne"), "StatueUsed") != TRUE))
            {
                nStatue = 3;
            }
            if ((nStatue == 3) && (GetLocalInt(GetObjectByTag("zzz_statsw"), "StatueUsed") != TRUE))
            {
                nStatue = 4;
            }
        }
        if ((nStatue == 2) && (GetLocalInt(GetObjectByTag("zzz_statne"), "StatueUsed") != TRUE))
        {
            nStatue = 3;
            if ((nStatue == 3) && (GetLocalInt(GetObjectByTag("zzz_statsw"), "StatueUsed") != TRUE))
            {
                nStatue = 4;
            }
            if ((nStatue == 4) && (GetLocalInt(GetObjectByTag("zzz_statse"), "StatueUsed") != TRUE))
            {
                nStatue = 1;
            }
        }
        if ((nStatue == 3) && (GetLocalInt(GetObjectByTag("zzz_statsw"), "StatueUsed") != TRUE))
        {
            nStatue = 4;
            if ((nStatue == 4) && (GetLocalInt(GetObjectByTag("zzz_statse"), "StatueUsed") != TRUE))
            {
                nStatue = 1;
            }
            if ((nStatue == 1) && (GetLocalInt(GetObjectByTag("zzz_statnw"), "StatueUsed") != TRUE))
            {
                nStatue = 2;
            }
        }
        if ((nStatue == 4) && (GetLocalInt(GetObjectByTag("zzz_statse"), "StatueUsed") != TRUE))
        {
            nStatue = 1;
            if ((nStatue == 1) && (GetLocalInt(GetObjectByTag("zzz_statnw"), "StatueUsed") != TRUE))
            {
                nStatue = 2;
            }
            if ((nStatue == 2) && (GetLocalInt(GetObjectByTag("zzz_statne"), "StatueUsed") != TRUE))
            {
                nStatue = 3;
            }
        }
        //notify of kill:
        BroadcastMessage(GetTeamColour(nKillerTeam)+GetName(oKiller)+"["+IntToString(GetHitDice(oKiller))+"]</c> killed " +GetTeamColour(nDeadTeam)+GetName(oDead)+"["+IntToString(GetHitDice(oDead))+"]</c>.");
        if (GetIsPC(oKiller) == TRUE && GetIsEnemyTeam(oKiller,oDead))   // Is oDead on the enemy team?
        {
            if (nMonsterKiller == 9)
            {
                FloatingTextStringOnCreature("You devour the corpse of your victim!", oKiller);
                effect eHP = EffectTemporaryHitpoints(200);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oKiller, HoursToSeconds(24));
            }
            if ((nMonsterKiller > 0) || (nLegend == TRUE) ) //Was the killer a monster or the legend?
            {
                if (nMonsterDead > 0) //Did a monster die?
                {
                    int nKillType = 4;
                    RewardHuntKill(oKiller, oDead, nKillerTeam, nDeadTeam, nKillType);

                        if (nStatue == 1)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the northwest statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statnw");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oDead, "Monster");
                            string sTeam = IntToString(nDeadTeam);
                            sTeam = "Monster" + sTeam;
                            int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                            SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        else if (nStatue == 2)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the northeast statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statne");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oDead, "Monster");
                            string sTeam = IntToString(nDeadTeam);
                            sTeam = "Monster" + sTeam;
                            int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                            SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        else if (nStatue == 3)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the southwest statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statsw");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oDead, "Monster");
                            string sTeam = IntToString(nDeadTeam);
                            sTeam = "Monster" + sTeam;
                            int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                            SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        else if (nStatue == 4)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the southeast statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statse");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oDead, "Monster");
                            string sTeam = IntToString(nDeadTeam);
                            sTeam = "Monster" + sTeam;
                            int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                            SetLocalInt(GetModule(), sTeam, nSet);
                        }
                }
                else if (GetLocalInt(oDead, "LegendHunter") == TRUE)
                {
                    RewardHuntKill(oKiller, oDead, nKillerTeam, nDeadTeam, 4);
                    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("The Legend dies valiantly in battle! A new one may arise if need be.", TALKVOLUME_SHOUT));
                    DeleteLocalInt(GetModule(), "StatueUsed");
                }
                else //If not a monster, then a hunter must have died
                {
                    int nKillType = 3;
                    RewardHuntKill(oKiller, oDead, nKillerTeam, nDeadTeam, nKillType);
                    DeleteLocalInt(oDead, "Hunter");
                }

            }
            else //If not a monster, then the killer must be a hunter
            {
                if (nMonsterDead > 0) //Did a monster die?
                {
                    int nKillType = 2;
                    RewardHuntKill(oKiller, oDead, nKillerTeam, nDeadTeam, nKillType);
                    switch (nMonsterDead)
                    {
                        case 1:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntBoar(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 2:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntRat(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 3:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntWolf(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 4:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntCat(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 5:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntMutant(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 6:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntSpider(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 7:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntFrog(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 8:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntSkink(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 9:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntVulture(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 10:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntFish(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 11:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntBull(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 12:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntLouse(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 13:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntAnt(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 14:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntGoat(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 15:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntBeetle(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                        case 16:
                        {
                            DeleteLocalInt(oDead, "Monster");
                            DeleteLocalInt(oKiller, "Hunter");
                            HuntScorpion(oKiller);
                            string sTeam = IntToString(nKillerTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            break;
                        }
                    }
                }
                else if (GetLocalInt(oDead, "LegendHunter") == TRUE)
                {
                    RewardHuntKill(oKiller, oDead, nKillerTeam, nDeadTeam, 2);
                    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("The Legend dies valiantly in battle! A new one may arise if need be.", TALKVOLUME_SHOUT));
                    DeleteLocalInt(GetModule(), "StatueUsed");
                    DeleteLocalInt(GetModule(), "LegendHunter");
                }
                else //If not a monster, then a hunter must have died
                {

                    int nKillType = 1;
                    RewardHuntKill(oKiller, oDead, nKillerTeam, nDeadTeam, nKillType);
                    DeleteLocalInt(oDead, "Hunter");
                }
            }
         }
         else //if oDead not on enemy team, must have been on oKiller's team
         {
            int nKillType = 5;
            RewardHuntKill(oKiller, oDead, nKillerTeam, nDeadTeam, nKillType);
            if (nMonsterDead > 0) //Did a monster die?
            {

                        if (nStatue == 1)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the northwest statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statnw");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oDead, "Monster");
                            string sTeam = IntToString(nDeadTeam);
                            sTeam = "Monster" + sTeam;
                            int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                            SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        if (nStatue == 2)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the northeast statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statne");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oDead, "Monster");
                            string sTeam = IntToString(nDeadTeam);
                            sTeam = "Monster" + sTeam;
                            int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                            SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        if (nStatue == 3)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the southwest statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statsw");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oDead, "Monster");
                            string sTeam = IntToString(nDeadTeam);
                            sTeam = "Monster" + sTeam;
                            int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                            SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        if (nStatue == 4)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the southeast statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statse");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oDead, "Monster");
                            string sTeam = IntToString(nDeadTeam);
                            sTeam = "Monster" + sTeam;
                            int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                            SetLocalInt(GetModule(), sTeam, nSet);
                        }
            }
            else if (GetLocalInt(oDead, "LegendHunter") == TRUE)
                {
                    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("The Legend was backstabbed by a team member! A new one may arise if need be.", TALKVOLUME_SHOUT));
                    DeleteLocalInt(GetModule(), "StatueUsed");
                    DeleteLocalInt(oDead, "LegendHunter");
                }

            else // it was a hunter
            {
                DeleteLocalInt(oDead, "Hunter");
            }
         }
    } // End of Hunt special

    else   //........... CTF ROUNDS ..........//
    {
        object oEnemyFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(3 - GetLocalInt(oDead, "nTeam")));

        int i = 0;
        for (i = 0; i < 5; i++)
        {
            object oWaitPlayer = GetLocalObject(oEnemyFlagHolder, "WaitPlayer" + IntToString(i));
            if (oWaitPlayer == oDead)
            {
                DeleteLocalObject(oEnemyFlagHolder, "WaitPlayer" + IntToString(i));
            }
        }

        string szEnemyHasFlag = "oHasFlag_" +IntToString(3-nDeadTeam);
        string szFriendlyHasFlag = "oHasFlag_"+IntToString(nDeadTeam);

        object oHasFlag;
        ////Checks if the player has the flag////  to drop it

        if (GetLocalObject(GetModule(), szEnemyHasFlag) == oDead)
        {
            DropFlag(oDead);
            oHasFlag = oDead;
        }

        BroadcastMessage(GetTeamColour(nKillerTeam)+GetName(oKiller)+"["+IntToString(GetHitDice(oKiller))+"]</c> killed " +GetTeamColour(nDeadTeam)+GetName(oDead)+"["+IntToString(GetHitDice(oDead))+"]</c>.");

        // Reward the PK, or punish the TK.
        //Check if is a Easy/Imp Kill //
        if (GetIsPC(oKiller) == TRUE && GetIsEnemyTeam(oKiller, oDead)) // if enemy team
        {
            if ( abs(GetHitDice(oKiller) - GetHitDice(oDead) ) > 5 )   //if easy/imp kill
            {
                if ((GetHitDice(oKiller) - GetHitDice(oDead)) > 5)
                {
                  FloatingTextStringOnCreature("Effy Kill!", oKiller, FALSE);
                  if ((oHasFlag != oDead) &&  (GetLocalObject(GetModule(), szFriendlyHasFlag) != oKiller)) // se uno dei due ha la bandiera non pinguinare
                  {
                     ///PENGUINIZE////
                     float PenguDuration = (IntToFloat(GetHitDice(oKiller) - GetHitDice(oDead))*3);
                     int nSkin = POLYMORPH_TYPE_PENGUIN;
                     PenguinizeEffyKiller(oKiller,oDead,nSkin,PenguDuration);
                  }
                }
                else
                {
                    FloatingTextStringOnCreature("You have killed someone above your level range!", oKiller, FALSE);
                    if ((oHasFlag != oDead) &&  (GetLocalObject(GetModule(), szFriendlyHasFlag) != oKiller) && (GetLocalInt(oDead, "Pengy") != TRUE) && !GetLocalInt(oDead, "UsingBackToCastle")) // se uno dei due ha la bandiera non pinguinare
                    {
                        ///PENGUINIZE////
                        float PenguDuration = (IntToFloat(abs(GetHitDice(oKiller) - GetHitDice(oDead)))*3);
                        int nSkin = POLYMORPH_TYPE_CHICKEN;
                        PenguinizeEffyKiller(oKiller,oDead,nSkin,PenguDuration);
                    }
                        else //We want the effies to be able to kill penguins/chickens/cows!
                        {
                            RewardKill(oKiller,oDead,nKillerTeam,nDeadTeam);
                        }
                 }

            }
            // Else reward  // is not  an illegal kill
            else
            {
                RewardKill(oKiller,oDead,nKillerTeam,nDeadTeam);
            }
        /////else:  is a team kill
        }
        else if ((nKillerTeam != TEAM_NONE) &&  GetIsPC(oKiller) == TRUE && !GetIsEnemyTeam(oKiller, oDead))
        {
            TeamKillPenalise(oKiller, oDead);
        }
        //killed by an NPC - is it the flag bearer?
        else if (GetTag(oKiller) == "FlagHolder_2" || GetTag(oKiller) == "FlagHolder_1")
        {
            if      (GetTag(oKiller) == "FlagHolder_2") nKillerTeam = 2;
            else if (GetTag(oKiller) == "FlagHolder_1") nKillerTeam = 1;
            //reward the team and lower the player score as punishment for being so noob
            RewardTeamKill(50, oKiller, nKillerTeam, PLAYERS_EASY_KILL_CONSTANT);
            AddPlayerScore(oDead, -PLAYERS_EASY_KILL_CONSTANT);
        }

        // Increment deaths by one.
        SetLocalInt(oDead,"m_nDeaths", (GetLocalInt(oDead,"m_nDeaths") + 1) );
    }//end of CTF
}

/////////////////////////////////
//PLATINUM ANGEL CARD
/// Summon the Angel to resurrect
////////////////////////////////
void SummonPlatinumAngel(object oDead, location lSpawn,object oAngel);
void ResurrectAndRest (object oDead,object oAngel);
void SummonPlatinumAngel(object oDead, location lSpawn, object oAngel)
{
       DelayCommand(0.5, AssignCommand(oAngel,SpeakString("<cºé°>You can't lose the game and your opponents can't win the game.</c>")));
       DelayCommand(1.5, AssignCommand(oAngel,ActionCastFakeSpellAtObject(SPELL_RESURRECTION,oDead)));
       DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_RAISE_DEAD),oDead));
       DelayCommand(3.5, ResurrectAndRest(oDead,oAngel));
}
void ResurrectAndRest (object oDead, object oAngel)
{
       ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oDead);
       ForceRest(oDead);
       ToggleAllStuff(oDead);
       effect eDamageImmunity = EffectDamageImmunityIncrease(AC_VS_DAMAGE_TYPE_ALL, 100);
       effect eSpellImmunity = EffectSpellImmunity(SPELL_ALL_SPELLS);
       effect eMindImmunity = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
       effect eLink = EffectLinkEffects(eMindImmunity, eSpellImmunity);
       eLink = ExtraordinaryEffect(EffectLinkEffects(eLink, eDamageImmunity));
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oDead, 6.0f);
       DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappear(),oAngel));
}

void main()
{
    object oDead = GetLastPlayerDied();
    object oKiller = GetLastHostileActor(oDead);
    // this prints Killed By Someone // if (!GetIsPC(oKiller) ) SendMessageToPC( oDead, "killed by "+(GetName(oKiller)));
    int nDeadTeam = GetLocalInt(oDead, "nTeam");
    int nKillerTeam = GetLocalInt(oKiller, "nTeam");
    //int nEnemyTeam = 3 - nDeadTeam;
    if( nDeadTeam == 0 ) nKillerTeam = 0 ;
    string sArea = GetTag(GetArea(oDead));
    // Check if oKiller has a PC Master. If so, let's set oKiller to the Master,
    // so all those Druids and whatnot can stop complaining about their pets
    // hogging the glory.
    if (GetIsPC(oKiller) == FALSE)
    {
        object oTemp = GetMaster(oKiller);
        if (GetIsPC(oTemp) == TRUE)
        {
            oKiller = oTemp;
            nKillerTeam = GetLocalInt(oKiller, "nTeam");
        }
     }

     ///TRAPS !!//
    if (!GetIsPC(oKiller))
    {
        object oTemp = GetLocalObject(oDead,"sKiller");
        if (GetIsPC(oTemp) == TRUE)
        {
            oKiller = oTemp;
            nKillerTeam = GetLocalInt(oKiller, "nTeam");
        }
        DeleteLocalObject(oDead,"sKiller");
     }


  //// PLATINUM ANGEL CARD /////
   // Running this first so it does happen in sudden death or Duel area and everywhere
   // possessing the Angel Card will make a random chances of an angel to appear and resurrect you...//
   //(Oracle):Flying Artifact Creature - Angel
   // "You can't lose the game and your opponents can't win the game."
   if (GetItemPossessedBy(oDead,"PlatinumAngel") != OBJECT_INVALID)
   {
       if ( Random(60) == 0 )
       {
               int crimes;
               if (!GetIsGMNormalChar(oDead))   //if is not a GM
               {
                    crimes = GetCriminalRecords(oDead);
               }
               else //is a GM
               {
                   crimes = 0;
               }
               // check criminal
               if ( crimes == 0 || Random(crimes) == 0 )
               {
                   //If the player was holding the flag, then drop it.
                    string szEnemyHasFlag = "oHasFlag_" +IntToString(3-GetPlayerTeam(oDead));
                    object oHasFlag;
                    ////Checks if the player has the flag////  to drop it
                    if (GetLocalObject(GetModule(), szEnemyHasFlag) == oDead)
                    {
                        DropFlag(oDead);
                    }

                   location lDead = GetLocation(oDead);
                   location lSpawn = GenerateNewLocationFromLocation(lDead, 2.0f, 90.0f,GetFacingFromLocation(lDead) + 180.0f);
                   DelayCommand(0.8,FloatingTextStringOnCreature("<c¤ßÎ>...Oracle... </c>",oDead, TRUE));
                   DelayCommand(1.4,FloatingTextStringOnCreature("<cÄóÎ>Flying Artifact Creature</c>",oDead, TRUE));
                   DelayCommand(2.0,FloatingTextStringOnCreature("<cÚýÝ>Platinum Angel</c>",oDead, TRUE));
                   effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
                   DelayCommand(0.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lSpawn,2.0));
                   object oAngel = CreateObject(OBJECT_TYPE_CREATURE,"PlatinumAngel",lSpawn,TRUE);
                   DelayCommand(2.5,SummonPlatinumAngel(oDead,lSpawn,oAngel));
                   // spawn and resurrect
                   return;   //do not port to castle or stuff
               }
        }

    }
    /////////////////Sudden Death////////////////
    if (sArea == "arena_100")
    {
        int DeathCount = GetLocalInt(GetModule(),"deathcount");
        SetXP(oDead,(GetXP(oDead)+ 20*DeathCount));
        GiveGoldToCreature(oDead,  20*DeathCount);
        BroadcastMessage(GetTeamColour(nKillerTeam)+GetName(oKiller)+"["+IntToString(GetHitDice(oKiller))+"]</c> killed " +GetTeamColour(nDeadTeam)+GetName(oDead)+"["+IntToString(GetHitDice(oDead))+"]</c>.");
        SetLocalInt(GetModule(),"deathcount",(GetLocalInt(GetModule(),"deathcount")+1));
        ChooseTeam(oDead);
        DelayCommand(RESPAWN_TIMER, RespawnPlayer(oDead,TRUE));
        return;
    }
    //If the area is  a No CTF area, then do not reward or check for teamkill/easykill
    else if (sArea == "DuelArea" || sArea == "antiworld_area" || sArea ==  "HallofGods" || sArea == "Wingery" || sArea == "Jail")
    {
        DelayCommand(RESPAWN_TIMER, RespawnPlayer(oDead,FALSE));
        return;
    }
    else // CTF Areas
    {
        int nRound  = GetLocalInt(GetModule(),"nRound");
        ManageDeathEvent(nRound, oKiller, oDead, nKillerTeam, nDeadTeam );
    }
    // Set Faction reputations, in case they've gotten buggy.
    SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oDead);
    SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oDead);
    DelayCommand(RESPAWN_TIMER, RespawnPlayer(oDead,TRUE));
    return;
   // ClearShifterStored(GetLastPlayerDied());
}

