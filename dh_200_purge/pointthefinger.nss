// DM Target Tool
// by Malishara
//:://////////////////////////////////////////////////////////
#include "x2_inc_switches"

string ShowVector(vector vSomewhere)
{   string sVector = FloatToString(vSomewhere.x, 0, 2) + "x "
                   + FloatToString(vSomewhere.y, 0, 2) + "y "
                   + FloatToString(vSomewhere.z, 0, 2) + "z";
    return sVector;
}

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

            if(!GetIsObjectValid(oTarget))
            { string sTargetLoc = ShowVector(GetPositionFromLocation(lTarget));
              SendMessageToPC(oItemUser, "Targeted location " + sTargetLoc);
              SetLocalString(oItemUser, "DM_Tool_TargetLoc", sTargetLoc);
              return;
            }

            SetLocalObject(oItemUser, "DM_Tool_Target", oTarget);
            SendMessageToPC(oItemUser, "Targeted " + GetName(oTarget));

            if (GetHasInventory(oTarget) &&
               ((GetObjectType(oTarget) == OBJECT_TYPE_ITEM) ||
                (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)))
            { SetLocalObject(oItemUser, "oDM_Bag1", GetLocalObject(oItemUser, "oDM_Bag2"));
              SetLocalObject(oItemUser, "oDM_Bag2", oTarget);
            }

         }
         SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_END);
         return;

   }
   SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
}
