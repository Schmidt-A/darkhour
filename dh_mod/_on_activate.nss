//
//
//
#include "x2_inc_switches"
void main()
{
    object oItem = GetItemActivated();
    object oActivator = GetItemActivator();
    location lActivator = GetLocation(oActivator);
    string sItemTag = GetTag(oItem);
    location lTarget = GetItemActivatedTargetLocation();




        if (sItemTag == "SummonHorse")
    {
        ExecuteScript("hench_pony", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonHorse2")
    {
        ExecuteScript("hench_pony2", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonHorse3")
    {
        ExecuteScript("hench_pony3", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonHorse4")
    {
        ExecuteScript("hench_pony4", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonHorse5")
    {
        ExecuteScript("hench_pony5", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonHorse6")
    {
        ExecuteScript("hench_pony6", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonHorse7")
    {
        ExecuteScript("hench_pony7", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonHorse8")
    {
        ExecuteScript("hench_pony8", OBJECT_SELF);
        return;
    }

        if (sItemTag == "horse_dismt")
    {
        object oPC = GetItemActivator();
        object oMount = GetHenchman(oPC, 1);
        AssignCommand(oMount, ActionForceFollowObject(oPC));
        SetLocalInt(oPC, "VAR_HORSEMOUNT", 0);//horselord class variable
        return;
    }

        if (GetTag(oItem) == "Horse_Management")
    {
        AssignCommand(oActivator, ActionStartConversation(oActivator, "horse_magmt", TRUE));
        return;
    }

        if (sItemTag == "SummonCamel")
    {
        ExecuteScript("hench_pack1", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonpkHorse")
    {
        ExecuteScript("hench_pack2", OBJECT_SELF);
        return;
    }

        if (sItemTag == "SummonpkOx")
    {
        ExecuteScript("hench_pack3", OBJECT_SELF);
        return;
    }

        if (sItemTag == "Summonpkpony")
    {
        ExecuteScript("hench_pack4", OBJECT_SELF);
        return;
    }

       if (GetTag(oItem) == "fly_widget")
    {
        AssignCommand(oActivator, ActionStartConversation(oActivator, "fly_control", TRUE));
        return;
    }

//---------------------------------START DLA HORSE WIDGETS-------------------------------
///////////////////////////////////////////////////////////////////////////////
    // Horse_1
///////////////////////////////////////////////////////////////////////////////
    if (sItemTag == "Horse_1")
    {
    object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_hvywarhorse2", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_2
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_2")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_hvywarhorse3", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_3
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_3")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_hvywarhorse4", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_4
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_4")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_hvywarhorse", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_5
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_5")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_horse001", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_6
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_6")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_jousthorse1", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_7
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_7")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_jousthorse2", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_8
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_8")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_jousthorse3", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_9
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_9")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_jousthorse4", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_10
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_10")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "x3_jousthorse5", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_11
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_11")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "horse002", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_12
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_12")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "jousthorse002", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_13
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_13")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "jousthorse003", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_14
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_14")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "jousthorse004", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }/* end else (valid owyrmling) */
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Horse_15
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_15")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "unicorn", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Unicorn");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Unicorn"));
    }/* end else (valid owyrmling) */
      return;
    }
/////////////////////END DLA HORSE WIDGETS////////////////////
     //X2 Tag based system code

    ExecuteScript(sItemTag, OBJECT_SELF);

     //object oItem = GetItemActivated();

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


