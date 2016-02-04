// This script will teleport the player to the OOC Player Lounge.
// Created by Zunath on August 2, 2007
// Edited by Naia September 12, 2010

#include "_incl_location"

void main()
{
    object oPC = GetPCSpeaker();

    // Apparently Sundered Desolation's tag is "carnival" ? XD
    // If the area is not Sundered Desolation, inform the player and do nothing else.
    if (GetTag(GetArea(oPC)) != "carnival")
    {
        SendMessageToPC(oPC, "You can only teleport to the player lounge from the Sundered Desolation!");
        return;
    }

    SetLocalLocation(oPC,"ReturnToRestSpot", GetLocation(oPC));
    
    ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_IMP_UNSUMMON, FALSE), oPC);

    PortToWaypoint(oPC, "WP_PLAYER_LOUNGE");
}
