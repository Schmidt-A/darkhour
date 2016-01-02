// DM Placeable Attitude Adjuster widget
// by Malishara
//:://////////////////////////////////////////////////////////
#include "x2_inc_switches"
#include "x0_i0_position"

// This is the main function for the tag-based script.
void main()
{ switch( GetUserDefinedItemEventNumber())
   { case X2_ITEM_EVENT_ACTIVATE:
         { // The item's CastSpell Activate or CastSpell UniquePower was just activated.
            object     oItemUser  = GetItemActivator();
            object     oItem          = GetItemActivated();
            object     oTarget      = GetItemActivatedTarget();
            location  lTarget      = (GetIsObjectValid( oTarget) ? GetLocation( oTarget) : GetItemActivatedTargetLocation());
            if( !GetIsObjectValid( oItemUser) || !GetIsObjectValid( oItem))
            { SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
               return;
            }


            SetLocalObject(oItemUser, "DM_SM_oWidget", oItem);
            string sConversationName = GetTag( oItem);
            AssignCommand( oItemUser, ActionStartConversation( oItemUser, sConversationName, TRUE, FALSE));

         }
         SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_END);
         return;

   }
   SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
}
