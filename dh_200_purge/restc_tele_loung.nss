// This script will teleport the player to the OOC Player Lounge.
// Created by Zunath on August 2, 2007
// Edited by Naia September 12, 2010

#include "_incl_location"

void main()
{
    object oPC = GetPCSpeaker();
    object oRestObject = GetNearestObjectByTag("DH_RESTOBJ", oPC);

    // Player must be within 5 meters of a "DH_RESTOBJ" placeable to rest
    if (GetDistanceBetween(oRestObject, oPC) <= 5.0 && oRestObject != OBJECT_INVALID)
    {
        SetLocalLocation(oPC,"ReturnToRestSpot", GetLocation(oPC));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_IMP_UNSUMMON, FALSE), oPC);

        PortToWaypoint(oPC, "WP_PLAYER_LOUNGE");
    }
}
