// dn_inc_dm
//
//
// some custom DM related code for DN
//

// Used in OnClientEnter to help track DMs by caching their status on them
//
void DN_SetIsDM( object oPC );
void DN_SetIsDM( object oPC )
{
    SetLocalInt( oPC, "DN_I_AM_A_DM", TRUE );
}

// Returns TRUE if oPC is using the DM Client or a DMPossessedCreature, or marked
// as a DM by OnClientEnter
//
int DN_GetIsDM( object oPC );
int DN_GetIsDM( object oPC )
{
    if( GetLocalInt( oPC, "DN_I_AM_A_DM" ) ||
        GetIsDM( oPC ) ||
        GetIsDMPossessed( oPC ) )
        return TRUE;

    return FALSE;
}

// Returns TRUE if oPC is using a certain (hardcoded) builder gamespy account, or the DM Client, or a DM possessed creature.
//
int DN_GetIsBuilder( object oPC );
int DN_GetIsBuilder( object oPC )
{
    string sPC = GetPCPlayerName(oPC);

    if( DN_GetIsDM(oPC)
             || (sPC == "arQon")
             || (sPC == "Chevalis")
             || (sPC == "Duster47")
             || (sPC == "Emaleth of Donnelaith")
             || (sPC == "exm")
             || (sPC == "Faewyn")
             || (sPC == "He Who Watches")
             || (sPC == "Kallicat")
             || (sPC == "Maerlande")
             || (sPC == "Phage82")
             || (sPC == "shadguy")
             || (sPC == "StriderNL")
             || (sPC == "Lula Lamore")
             || (sPC == "Liquid Bliss")
             || (sPC == "Torrilin")
             || (sPC == "Tylic")
             || (sPC == "witetower")
             || (sPC == "DNDMTest")
            )
        return TRUE;

    return FALSE;
}


// Returns TRUE for DMs and Builders.
//
int DN_GetCanUseDMandBuilderTools( object oPC );
int DN_GetCanUseDMandBuilderTools( object oPC )
{
    if( DN_GetIsBuilder( oPC ) ||
        DN_GetIsDM( oPC ) )
            return TRUE;

    return FALSE;
}


// Sends a message to all DMs within range of oObject
//
void DN_SendMessageToAllNearbyDMsInArea( string sMessage, object oObject=OBJECT_SELF, float fRange=30.0f );
void DN_SendMessageToAllNearbyDMsInArea( string sMessage, object oObject=OBJECT_SELF, float fRange=30.0f )
{
    location loc = GetLocation( oObject );
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, loc);

    while( GetIsObjectValid( oTarget ) )    {
        if( GetDistanceBetween( oTarget, oObject ) < fRange &&  DN_GetIsDM( oTarget ) )
            SendMessageToPC( oTarget, sMessage );

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, loc);
    }
}

