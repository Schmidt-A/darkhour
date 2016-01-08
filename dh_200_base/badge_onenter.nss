// This is my version of the badge system Ronin_DM thought up.
// Instead of relying on heartbeats (which eat up resources),
// this system relies on the use of triggers. As soon as the PC
// enters the trigger they get the badge and exp.
// Variables are set on the trigger.

// Created by Zunath on July 22, 2007
// coolty3001@yahoo.com

void main()
{
    object oPC = GetEnteringObject();
    int iExp = GetLocalInt(OBJECT_SELF, "EXP");
    string sMessage = GetLocalString(OBJECT_SELF, "MSG");
    string sBadgeResref = GetLocalString(OBJECT_SELF, "RESREF");

    if (GetIsPC(oPC) && GetItemPossessedBy(oPC, sBadgeResref) == OBJECT_INVALID)
    {
        SendMessageToPC(oPC, sMessage);
        CreateItemOnObject(sBadgeResref, oPC, 1, sBadgeResref);
        GiveXPToCreature(oPC, iExp);
    }
}
