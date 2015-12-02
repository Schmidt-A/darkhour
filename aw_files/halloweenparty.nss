///////
/// Antiworld Halloween Party, special Item ////
/// only work if the variable "antiworld_party" is set to 1 ( 1 enabled  0 disabled)
/// created by Jantima
/// created on  25 October 2004.
///////
/* include Halloween Party appearance list */

/* function SetHalloweenCostume()    */
// get chosed costume from localvariable one the char.
// get correspondat voiceset.
// set the appearance
// set the voiceset


// Tag-Based Item Script
//:://////////////////////////////////////////////////////
#include "x2_inc_switches"

/*int GetTagBasedItemEventNumber()
{ int nEvent = GetLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
   return (nEvent ? nEvent : GetLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT"));
}

void SetTagBasedScriptExitBehavior( int nEndContinue)
{ DeleteLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
   DeleteLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT");
   SetExecutedScriptReturnValue( nEndContinue);
}    */


void main()
{
    int nEvent = GetUserDefinedItemEventNumber();    //Which event triggered this

    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    { // This is where you would process unique power activation
        object oPC = GetItemActivator();
        object oItem = GetItemActivated();
        if (GetTag(oItem) == "halloweenparty")
        {
            FloatingTextStringOnCreature("Item Activated!" , oPC);
            AssignCommand(oPC, ActionStartConversation(oPC, "halloween_conv", TRUE, FALSE ));
        }
    }
    SetExecutedScriptReturnValue();
}


