#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();       //Which event triggered this
    object oPC;                                     //The player character using the item
    object oItem;                                   //The item being used
    object oSpellOrigin;                            //The origin of the spell
    object oTarget;                                 //The target of the spell
    location lTarget;

    string sDesc;

    //Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    { case X2_ITEM_EVENT_ACTIVATE:
      { oPC   = GetItemActivator();             // The player who activated the item
        oItem = GetItemActivated();             // The item that was activated
        oTarget = GetItemActivatedTarget();
        lTarget = (GetIsObjectValid(oTarget) ? GetLocation(oTarget) : GetItemActivatedTargetLocation());

        sDesc = GetDescription(oItem, FALSE, FALSE);

        if (sDesc == "EMPTY")
        { SendMessageToPC(oPC, "This device is empty! Toss it in the trash, it's useless."); }
        else
        { SetLocalLocation(oPC, "lMCS_Spawn", lTarget);
          SetLocalObject(oPC, "oMCS_Device", oItem);
          ExecuteScript("mcs_release", oPC);
        }
      }
    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
    return;
}

