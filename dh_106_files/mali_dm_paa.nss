// DM Placeable Attitude Adjuster widget
// by Malishara
//:://////////////////////////////////////////////////////////
#include "x2_inc_switches"

// This is the main function for the tag-based script.
void main()
{ switch( GetUserDefinedItemEventNumber())
   { case X2_ITEM_EVENT_ACTIVATE:
         { // The item's CastSpell Activate or CastSpell UniquePower was just activated.
            object oItemUser = GetItemActivator();
            object oItem = GetItemActivated();
            object oTarget = GetItemActivatedTarget();
            location lTarget = (GetIsObjectValid( oTarget) ? GetLocation( oTarget) : GetItemActivatedTargetLocation());
            if( !GetIsObjectValid( oItemUser) || !GetIsObjectValid( oItem))
            { SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
               return;
            }

            // Display error message if used on something other than placeable or ground
            if( (GetIsObjectValid(oTarget)) && (GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE))
            { SendMessageToPC(oItemUser, "ERROR: Placeable Attitude Adjuster may only be used on placeables.");
              return;
            }

            if( !GetIsObjectValid(oTarget) )
            { oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lTarget, 1); }

            if( !GetIsObjectValid(oTarget) )
            { SendMessageToPC(oItemUser, "ERROR: No placeables in target area.");
              return;
            }

            // Pass information as local variables on user
            SetLocalObject(oItemUser, "DM_PAA_oTarget", oTarget);
            SetLocalLocation(oItemUser, "DM_PAA_lTarget", lTarget);

            // Initiate conversation tree
            string sConversationName = GetResRef( oItem);
            AssignCommand( oItemUser, ActionStartConversation( oItemUser, sConversationName, TRUE, FALSE));
         }
         SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_END);
         return;

   }
   SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
}
