void main()
{
    object oDoor1 = GetObjectByTag("SanctuaryToWHouse");
    object oDoor2 = GetObjectByTag("WHouseToSanctuary");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    if (GetLocked(oDoor1) == TRUE)
    {
        SetLocked(oDoor1,FALSE);
        SetLocked(oDoor2,FALSE);
    }
    else
    {
        SetLocked(oDoor1,TRUE);
        SetLocked(oDoor2,TRUE);
    }
}
