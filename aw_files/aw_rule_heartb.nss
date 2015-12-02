//::///////////////////////////////////////////////
//:: Name aw_rule_heartbeat
//:: Copyright (c) 200 Antiworld Corp.
//:://////////////////////////////////////////////
/*
   Antiworld NPC Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Jantima
//:: Created On: somewhen 2004
//:://////////////////////////////////////////////
#include "inc_custom"
#include "aps_include"
void main()
{
    object oModule = GetModule();
    int nPirateStatus = GetLocalInt(oModule,"PirateDay");
    if (GetLocalInt(OBJECT_SELF,"Rules_Enforcing") == 1) //DM Activate / Deactivate
    {
        //SQLExecDirect("SELECT COUNT(*) FROM RulesShouting");

        if (nPirateStatus == 1)
        {
            SQLExecDirect("SELECT val FROM PirateDayShouts ORDER BY RAND() LIMIT 1");
        }
        else
        {
            SQLExecDirect("SELECT val FROM RulesShouting ORDER BY RAND() LIMIT 1");
        }
        SQLFetch();
        string sRule = SQLGetData(1);
        //string sRule = AntiworldRules(Random());
        ActionSpeakString(sRule, TALKVOLUME_SHOUT);
    }
}
