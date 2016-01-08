//
// dn_w_name_wand
//

//::///////////////////////////////////////////////
//:: Tagbased Item Scripting Template
//:: tagased item template.txt
//:://////////////////////////////////////////////

// Template by shadguy based on stuff by Axe Murderer and Drycona on the BW forums
// unused event hooks can be deleted.
//

#include "dn_inc_dm"
#include "dn_inc_switches"

// The only reason this is a function is so I can delay it if the Fairy needs to be summoned first.
//
void DN_SpeakInstructions( object oTarget, object oItemUser )
{
    object oFairy = GetAssociate( ASSOCIATE_TYPE_SUMMONED, oItemUser );

    // Speak instructions for the user
    string sInstructions = "Speak a new name for " + GetName( oTarget ) +
        ".  You must be visible, so I can hear you, for this to work.  " +
        "To revert an object to it's original name, speak only a period, now.";
    DelayCommand( 0.1f, AssignCommand( oFairy, SpeakString( sInstructions ) ) );
    DelayCommand( 0.1f, SetListening( oFairy, TRUE ) );
}


void main()
{
    switch( GetTagBasedItemEventNumber() )  {

    case X2_ITEM_EVENT_ACTIVATE:
        object oItemUser = GetItemActivator();
        object oItem     = GetItemActivated();
        object oTarget   = GetItemActivatedTarget();

        // only allow DMs to use this tool
        if( !DN_GetIsDM( oItemUser ) )    {
            SpeakString( "Nothing happens!" );
            return;
        }

        //verify target is valid
        int nType = GetObjectType( oTarget );
        if( !GetIsObjectValid( oTarget )    ||
            GetIsPC( oTarget )              ||
            GetArea( oTarget ) == oTarget   ||
            GetModule() == oTarget          ||
            nType == OBJECT_TYPE_AREA_OF_EFFECT   ||
            nType == OBJECT_TYPE_ENCOUNTER        ||
            nType == OBJECT_TYPE_STORE            ||
            nType == OBJECT_TYPE_TRIGGER          ||
            nType == OBJECT_TYPE_WAYPOINT  )   {
             AssignCommand( oItemUser, SpeakString( "Invalid target!  The Wand of Naming only works on items, placeables, doors, monsters, and NPCs." ) );
             return;
        }
        SetLocalObject( oItemUser, "oNamingWandTarget", oTarget );

        // Get Naming Fairy!
        object oFairy = GetAssociate( ASSOCIATE_TYPE_SUMMONED, oItemUser );
        float tDelay = 0.01f;
        if( !GetIsObjectValid( oFairy )  ||
            "dn_w_name_fairy" != GetTag( oFairy ) )  {
            ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectSummonCreature( "dn_w_name_fairy", VFX_FNF_SUMMON_UNDEAD ), oItemUser );
            tDelay = 3.0f;
        }

        // use a bigger delay if Fairy was not already present
        DelayCommand( tDelay, DN_SpeakInstructions( oTarget, oItemUser ) );

        SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END );
        return;
    }
    SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE );
}





