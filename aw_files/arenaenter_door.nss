#include "inc_bs_module"
#include "aw_include"
#include "team_balance"
 int GetIsShifted(object oTarget)
{
effect eCheck = GetFirstEffect(oTarget);
while(GetIsEffectValid(eCheck))
    {
        if(GetEffectType(eCheck) == EFFECT_TYPE_POLYMORPH)
            return TRUE;
        else eCheck = GetNextEffect(oTarget);
    }
return FALSE;
}

void main()
{
    object oPlayer = GetLastOpenedBy();
    int nRound = GetLocalInt(GetModule(), "nRound");
    int noDev = GetLocalInt(GetModule(),"noDev");
        ///////////Check if the player can levelup - if so, force him to levelup before continue ///

    if (nRound == 0)
    {
        FloatingTextStringOnCreature("Next Round will start in a few moment, please wait.",oPlayer, FALSE);
    }
 /*   else if (GetTotalPlayerGOLD(oPlayer,FALSE) > GetXP(oPlayer) && !GetIsShifted(oPlayer))
     {
      //You have too much gold!
      FloatingTextStringOnCreature("Your Gold amount is exceeding your Experience Points!.",oPlayer, FALSE);
      DelayCommand(2.5, FloatingTextStringOnCreature("Please Drop the extra money you have in the jail.",oPlayer, FALSE));
      DelayCommand(5.0,MovePlayerToJail(oPlayer));
    }   */
    else if (GetIsGM(oPlayer) || GetIsDMAW(oPlayer) || (GetIsGMNormalChar(oPlayer) && (GetPlayerTeam(oPlayer) == TEAM_NONE)))
    {
        AssignCommand(oPlayer, MoveMeToLocation(GetLocation(GetObjectByTag(GetStringLeft(GetName(GetArea(oPlayer)), 4) + "Spawn" + IntToString(nRound)))));
    }
    else if (GetXP(oPlayer) >= GetXPRequiredForLevel(GetHitDice(oPlayer)+1)  && GetHitDice(oPlayer) < 40)
    {
        //Please Levelup Before enter the Battle!
        FloatingTextStringOnCreature("Please Levelup Before enter the Battle!",oPlayer,FALSE);
    }
    else if (noDev && GetHasDev(oPlayer))
    {
        FloatingTextStringOnCreature("Sorry, Anti Dev mode is currently active, please come back at another time or change builds",oPlayer,FALSE);
        DelayCommand(2.0,AssignCommand(oPlayer, JumpToLocation(GetLocation(GetObjectByTag("spawnpoint_inn")))));

    }
    else if (GetLocalInt(GetModule(), "TeamBalance") && !GetLocalInt(GetModule(), "NearEndOfRound") && (nRound != 999))
    {
        if (CheckHasEnemyInRange(oPlayer))
        {
            MovePlayerToArena(oPlayer);
        }
    }
    else
    {
        MovePlayerToArena(oPlayer);
    }

    ActionWait(1.0);
    ActionCloseDoor(OBJECT_SELF);
}
