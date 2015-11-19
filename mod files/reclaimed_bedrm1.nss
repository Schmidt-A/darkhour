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
        SetLockUnlockDC(oDoor,34);
        SetLocked(oDoor2,TRUE);
        SetLockUnlockDC(oDoor2,34);
        FloatingTextStringOnCreature("*You lock the door*", oPC);
    }
}
