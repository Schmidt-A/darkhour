#include "_incl_location"

void main()
{
    object oPC = GetLastUsedBy();

    // * note that nActive == 1 does  not necessarily mean the placeable is active
    // * that depends on the initial state of the object
    int nActive = GetLocalInt (OBJECT_SELF,"X2_L_PLC_OPEN_STATE");
    // * Play Appropriate Animation
    if (!nActive)
      ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN);
    else
    {
        if (!GetIsPC(oPC)) return;

        object oTarget = GetObjectByTag("miningwellrogue4");
        SoundObjectPlay(oTarget);

        oTarget = GetWaypointByTag("miningwellrogue3");
        location lTarget = GetLocation(oTarget);

        PortToWaypoint(oPC, lTarget);

        oTarget = GetObjectByTag("miningwellrogue4");
        SoundObjectStop(oTarget);
        ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE);
        DelayCommand(5.0, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
    }
}
