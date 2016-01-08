// dn_w_name_onconv
//
//  Wand of Naming - Name Fairy On Conversation Event
//

#include "dn_inc_dm"

void main()
{
    object oDM = GetLastSpeaker();

    // only allow DMs to use this tool
    if( !DN_GetIsDM( oDM )      ||
        oDM != GetMaster() )    {
        //SpeakString( "Nothing happens!" );
        //SetListening( OBJECT_SELF, FALSE );
        return;
    }

    string sName = GetMatchedSubstring( 0 );
    object oTarget = GetLocalObject( oDM, "oNamingWandTarget" );

    // using "." reset's the target's name to the default orignial
    if( "." == sName )        {
        AssignCommand( oTarget, SpeakString( "I am reverting to my original name." ) );
        SetName( oTarget, "" );
    } else  {
        AssignCommand( oTarget, SpeakString( "My new name is changed to: " + sName ) );
        SetName( oTarget, sName );
    }

    //cleanup
    DeleteLocalObject( oDM, "oNamingWandTarget" );
    SetListening( OBJECT_SELF, FALSE );
}
