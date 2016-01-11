void main()
{
    object oPC = GetLastUsedBy();
    object oDoor = GetObjectByTag("Reclaimed_Bathroom");
    object oDoor2 = GetObjectByTag("Reclaimed_BathroomOut");
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
