void main()
{
    object oPC = GetLastUsedBy();
    object oDoor = GetObjectByTag("SunDesBed3");
    object oDoor2 = GetObjectByTag("SunDesBed3");
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
        SetLockUnlockDC(oDoor,43);
        SetLocked(oDoor2,TRUE);
        SetLockUnlockDC(oDoor2,43);
        FloatingTextStringOnCreature("*You lock the door*", oPC);
    }
}
