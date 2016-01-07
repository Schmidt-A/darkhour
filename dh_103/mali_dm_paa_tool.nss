void main()
{
    object oItemUser = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    location lTarget = GetSpellTargetLocation();

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
    string sConversationName = "mali_dm_paa";
    AssignCommand( oItemUser, ActionStartConversation( oItemUser, sConversationName, TRUE, FALSE));

}
