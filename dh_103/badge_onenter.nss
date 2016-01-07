#include "_incl_xp"
// This is my version of the badge system Ronin_DM thought up.
// Instead of relying on heartbeats (which eat up resources),
// this system relies on the use of triggers. As soon as the PC
// enters the trigger they get the badge and exp.
// Variables are set on the trigger.

// Created by Zunath on July 22, 2007
// coolty3001@yahoo.com
void Badge(object oPC, string sRes, int iExp)
    {
    if(GetItemPossessedBy(oPC, sRes) != OBJECT_INVALID)
        {
        GiveXPToCreatureDH(oPC, iExp);
        }
    }
void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE)
        {
        return;
        }
    int iExp = GetLocalInt(OBJECT_SELF, "EXP");
    string sMessage = GetLocalString(OBJECT_SELF, "MSG");
    string sBadgeResref = GetLocalString(OBJECT_SELF, "RESREF");
    if (GetIsPC(oPC) && GetItemPossessedBy(oPC, sBadgeResref) == OBJECT_INVALID)
    {
        SendMessageToPC(oPC, sMessage);
        CreateItemOnObject(sBadgeResref, oPC, 1);
        DelayCommand(0.5, Badge(oPC, sBadgeResref, iExp));
    }
}
