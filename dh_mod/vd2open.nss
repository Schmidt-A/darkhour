void main()
{
    object oDoor = GetObjectByTag("VaultDoor2");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    ActionOpenDoor(oDoor);
}
