////////////bs_bashplotdoor//////////
#include "inc_bs_module"
void main()
{

    object oAttacker = GetLastAttacker();
    int nTeam = GetPlayerTeam(oAttacker);
        if( (nTeam == 1 && GetLockKeyTag(OBJECT_SELF) == "GoodKey") || ( nTeam == 2 && GetLockKeyTag(OBJECT_SELF) == "EvilKey"))
        {
            AssignCommand(oAttacker, ClearAllActions());
            return;
         }
    int nLockDC = GetLockUnlockDC(OBJECT_SELF);
    int nSTRMod = GetAbilityScore(oAttacker,ABILITY_STRENGTH, FALSE);
    int nRoll = d20();


    if (GetIsPC(oAttacker))
    {
        SendMessageToPC(oAttacker, "10+ "+IntToString(nRoll) + " (roll) + " + IntToString(nSTRMod) + " (STR) versus DC " + IntToString(nLockDC));
    }
    if (nLockDC <= (10+ nRoll + nSTRMod ) /* || nRoll == 20 */)
    {
        ClearAllActions();
        SetLocalInt(OBJECT_SELF,"InUse",0);
        SetLocked(OBJECT_SELF, FALSE);
        ActionOpenDoor(OBJECT_SELF);
        if (GetIsPC(oAttacker))
        {
            SendMessageToPC(oAttacker, "You pry the lock open!");
        }
        AssignCommand(oAttacker, ClearAllActions());
    }
    else if (nRoll == 20)
    {
        ClearAllActions();
        ActionOpenDoor(OBJECT_SELF);
        //decrease the DC of the lock
        if (nLockDC>15)
        {
            SetLockUnlockDC(OBJECT_SELF,nLockDC-10);
            SendMessageToPC(oAttacker, "You pry the door open!");
        }
        else
        {
           SetLocked(OBJECT_SELF, FALSE);
           SendMessageToPC(oAttacker, "You unlock the door!");
        }
    }
    else if (GetIsPC(oAttacker))
    {
        SendMessageToPC(oAttacker, "The lock resists your efforts.");
    }
}
