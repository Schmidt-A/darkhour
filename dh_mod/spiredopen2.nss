void main()
{
    object oDoor = GetObjectByTag("SpireRoofDoor");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    ActionOpenDoor(oDoor);
}
