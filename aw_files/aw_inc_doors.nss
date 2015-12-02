/****************************************************
*Lock, bash and unlock arena doors script by riddler*
*****************************************************/
#include "inc_bs_module"

float OPEN_DOOR_DURATION = 30.0;
float DC_MULTIPLIER = 0.5;
int BASH_DC = 20;


void OpenLock(object oDoor,object oUnlocker)
{

   FloatingTextStringOnCreature("The door is unlocked for " + IntToString(FloatToInt(OPEN_DOOR_DURATION)) +  " seconds",oUnlocker,FALSE);
   DelayCommand(OPEN_DOOR_DURATION,ActionLockObject(oDoor));

}

void LockDoor (object oDoor,object oLocker)
{

    FloatingTextStringOnCreature("The door is locked",oLocker,FALSE);
    ActionLockObject(oDoor);
    SetLockLockDC(oDoor,FloatToInt(GetSkillRank(SKILL_OPEN_LOCK,oLocker)*DC_MULTIPLIER));
}

void BashDoor (object oDoor,object oBasher)
{


    int nSTRMod = GetAbilityModifier(ABILITY_STRENGTH, oBasher);
    int nRoll = d20();
    SendMessageToPC(oBasher, IntToString(nRoll) + " (roll) + " + IntToString(nSTRMod) + " (STR mod) versus DC " + IntToString(BASH_DC));
    if ((nRoll + nSTRMod) >= BASH_DC)
    {
        FloatingTextStringOnCreature("Your bulging muscles have forced the door open for " + IntToString(FloatToInt(OPEN_DOOR_DURATION)) +  " seconds",oBasher,FALSE);
        ActionUnlockObject(oDoor);
        DelayCommand(OPEN_DOOR_DURATION,ActionLockObject(oDoor));
    }
    else if (nRoll == 20)
    {
        FloatingTextStringOnCreature("Your bulging muscles have forced the door open for " + IntToString(FloatToInt(OPEN_DOOR_DURATION)) +  " seconds",oBasher,FALSE);
        ActionUnlockObject(oDoor);
        DelayCommand(OPEN_DOOR_DURATION,ActionLockObject(oDoor));
    }
    else
    {

        FloatingTextStringOnCreature("You need to work out more",oBasher,FALSE);
    }
}

void EnterDoor(object oDoor,location locTarget,object oEnterer,int isAllowed = 0)
{

   int nTeam = GetPlayerTeam(oEnterer);
   int nEnemyTeam = 3 - nTeam;
   string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
   string szAllyHasFlag = "oHasFlag_" + IntToString(nTeam);

   if (!GetLocked(oDoor) || isAllowed)
   {

        if (oEnterer == GetLocalObject(GetModule(), szEnemyHasFlag))
        {
            FloatingTextStringOnCreature("You can't go in with Flag!",oEnterer,FALSE);
            //RemoveAllEffects(oClicker);
        }
        else if (oEnterer == GetLocalObject(GetModule(), szAllyHasFlag))
        {
            FloatingTextStringOnCreature("You can't go in with Flag!",oEnterer,FALSE);
            //RemoveAllEffects(oClicker);
        }
        AssignCommand(oEnterer,ClearAllActions());
        AssignCommand(oEnterer,JumpToLocation(locTarget));


   }
   else
   {

        FloatingTextStringOnCreature("Ha! You can't go in there! You need to bash or unlock the trapdoor first!",oEnterer,FALSE);
   }



}


