void main()
{
    object oDoor = GetObjectByTag("BH_LD2");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    if (GetLocked(oDoor) == TRUE)
    {
        SetLocked(oDoor,FALSE);
    }
    else
    {
        SetLocked(oDoor,TRUE);
    }
}
