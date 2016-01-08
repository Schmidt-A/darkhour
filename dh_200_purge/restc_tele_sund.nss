// This script will teleport the player to the OOC Player Lounge.
// Created by Zunath on August 2, 2007

void main()
{
    object oPC = GetPCSpeaker();

    if (GetTag(GetArea(oPC)) != "OOCPlayerLounge")
    {
        SendMessageToPC(oPC, "You can only teleport back to the game from the OOC Lounge!");
        return;
    }
    location lWPLocation = GetLocalLocation(oPC,"ReturnToRestSpot");
    ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_IMP_UNSUMMON, FALSE), oPC);
    PortToWaypoint(oPC, lWPLocation);
}
