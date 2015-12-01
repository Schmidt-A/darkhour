#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();       //Which event triggered this
    object oPC;                                     //The player character using the item
    object oItem;                                   //The item being used
    object oTarget;                                 //The target of the spell
    location lTarget;


    //Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {  case X2_ITEM_EVENT_ACTIVATE:
          oPC = GetItemActivator();
          oItem = GetItemActivated();
          oTarget = GetItemActivatedTarget();
          lTarget = (GetIsObjectValid(oTarget) ? GetLocation(oTarget) : GetItemActivatedTargetLocation());

          SetLocalLocation(oPC, "lMCS_Spawn", lTarget);
          AssignCommand(oPC, ActionStartConversation(oPC, "enc_spawnmenu", TRUE, FALSE));

          break;
    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}

