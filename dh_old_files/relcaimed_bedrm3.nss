void main()
{
    object oPC = GetLastUsedBy();
    object oDoor = GetObjectByTag("ReclaimedBedroom1_2");
    object oDoor2 = GetObjectByTag("ReclaimedBedroom1");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    if (GetLocked(oDoor) == TRUE)
    {
        SetLocked(oDoor,FALSE);
        SetLocked(oDoor2,FALSE);
        FloatingTextStringOnCreature("*You unlock the door*", oPC);
    }
    else
    {
        SetLocked(oDoor,TRUE);
        SetLocked(oDoor2,TRUE);
        FloatingTextStringOnCreature("*You lock the door*", oPC);
    }
}
