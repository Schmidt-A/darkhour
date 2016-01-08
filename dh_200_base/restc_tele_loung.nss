// This script will teleport the player to the OOC Player Lounge.

// Created by Zunath on August 2, 2007
//Edited by Naia September 12, 2010

void main()
{
    object oPC = GetPCSpeaker();
        object oRestObject = GetNearestObjectByTag("DH_RESTOBJ", oPC);

    // Player must be within 5 meters of a "DH_RESTOBJ" placeable to rest
    // If not, trigger the conversation
    //if (GetDistanceBetween(oRestObject, oPC) > 5.0)
    //{SetLocalInt(oPC, "IS_RESTING", 0);
    //DelayCommand(0.10, DeleteLocalInt(oPC, "IS_RESTING"));}
    //iRestMsg = GetLocalInt(oPC, "REST_LIMIT");
    if (GetDistanceBetween(oRestObject, oPC) <= 5.0 && oRestObject != OBJECT_INVALID)
    {
    // Apparently Sundered Desolation's tag is "carnival" ? XD
    // If the area is not Sundered Desolation, inform the player and do nothing else.
    SetLocalLocation(oPC,"ReturnToRestSpot",GetLocation(oPC));
    // Otherwise, teleport them to the player lounge with a visual effect.
    location lWPLocation = GetLocation(GetWaypointByTag("WP_PLAYER_LOUNGE"));
    // Sorry Vision, I really wasn't sure what visual effect you wanted, so I just used the unsummon effect.
    // Replace this with the visual effect you want.
    int iVisualEffect = VFX_IMP_UNSUMMON;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(iVisualEffect, FALSE), oPC);
    // First clear his actions.
    AssignCommand(oPC, ClearAllActions());
    // Now make the jump!
    DelayCommand(0.2, AssignCommand(oPC, ActionJumpToLocation(lWPLocation)));
    }
}
