// This script will teleport the player to the OOC Player Lounge.

// Created by Zunath on August 2, 2007

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
    // Otherwise, teleport them to the player lounge with a visual effect.
    location lWPLocation = GetLocation(GetWaypointByTag("WP_PLAYER_LOUNGE"));
    // Sorry Vision, I really wasn't sure what visual effect you wanted, so I just used the unsummon effect.
    // Replace this with the visual effect you want.
    int iVisualEffect = VFX_IMP_UNSUMMON;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(iVisualEffect, FALSE), oPC);
    // First clear his actions.
    AssignCommand(oPC, ClearAllActions());
    // Now make the jump!
    DelayCommand(0.2, AssignCommand(oPC, JumpToLocation(lWPLocation)));
}
