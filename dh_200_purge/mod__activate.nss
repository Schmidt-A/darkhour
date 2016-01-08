//::///////////////////////////////////////////////
//:: Example XP2 OnActivate Script Script
//:: x2_mod_def_act
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemActivate Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////////
//:: Modified By: John Hawkins
//:: Created On: 07/30/2007
//:://////////////////////////////////////////////////

#include "x2_inc_switches"
void main()
{
     object oPC = GetItemActivator();
     object oTarget = GetItemActivatedTarget();
     string sTag = GetTag(oTarget);
     object oItem = GetItemActivated();
     string sItem = GetTag(oItem);
     object oArea = GetArea(oTarget);
     if(GetTag(oItem) == "TBX_DISMOUNT_OBJ")
     {
        if (GetPhenoType(oPC)==0) return;
        if (GetPhenoType(oPC)==2) return;
        ExecuteScript("tbx_dismount", oPC);
        return;
     }
     if(GetTag(oItem) == "TBX_MOUNT_OBJ")
     {
        int iTail = GetCreatureTailType(oPC);
        if((iTail > 3)&&(iTail < 135)) return;
        SetLocalObject(oTarget,"ITEM_ACTIVATOR",oPC);
        ExecuteScript("tbx_mount", oTarget);
        return;
     }

     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

     }

}
