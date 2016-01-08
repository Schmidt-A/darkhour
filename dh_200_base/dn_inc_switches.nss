//
//  dn_inc_switches
//


#include "x2_inc_switches"


// Tag Based Items script system wrapper function fixes by Axe Murderer
int GetTagBasedItemEventNumber();
int GetTagBasedItemEventNumber()
{
    int nEvent = GetLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT" );
    return( nEvent ? nEvent : GetLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT" ) );
}

// Tag Based Items script system wrapper function fixes by Axe Murderer
void SetTagBasedScriptExitBehavior( int nEndContinue );
void SetTagBasedScriptExitBehavior( int nEndContinue )
{
    DeleteLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT" );
    DeleteLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT" );
    SetExecutedScriptReturnValue( nEndContinue);
}
