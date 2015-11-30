void main()
{
    if(GetNearestObjectByTag("ZN_ZOMBIEL") != OBJECT_INVALID)
        {
        SendMessageToPC(GetLastUsedBy(), "This door will not open while the Zombie Lord lives.");
        return;
        }
    object oDoor = GetObjectByTag("VaultDoor5");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    ActionOpenDoor(oDoor);
}
