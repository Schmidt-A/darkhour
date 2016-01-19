/* Driver for various door events that expects variables to cause desired
   behaviour.

 int bLockBehind   - usually goes OnOpen or OnClose. If set to TRUE will cause
                     door to lock behind the PC.
 float fLockDelay  - if the door should be locked but not right away, add a
                     number for this.
 int bCloseBehind  - If set to TRUE will cause door to close behind the PC.
 float fCloseDelay - if there should be a delay before the door closes, set a
                     number for this
 int bOpen         - Set to TRUE if PC action should open a target door.
 int bClose        - Set to TRUE if PC action should close a target door.

 string sTargetTag - Set if you want the script to apply to some other door
                     (provide its tag) after the PC uses a different object.
 int bAnimation    - Set to TRUE if the used object (a lever, for example)
                     should play its animation.
 int bToggle       - Set to TRUE if PC action should cause the door to
                     alternate between locked and unlocked.
 Tweek 2016
*/
void UniversalDoor(object oPC, object oLever=OBJECT_INVALID)
{
    if(oPC == OBJECT_INVALID)
    {
        WriteTimestampedLogEntry("ERROR: Door " + GetTag(OBJECT_SELF) +
                " could not find its user.");
        return;
    }

    object oDoor = OBJECT_SELF;
    object oOwner = oDoor;

    /* If a lever was provided, the variables are on that lever instead of the
     * door, and the door tag needs to be gotten off the lever variable. */
    if(oLever != OBJECT_INVALID)
    {
        oDoor = GetObjectByTag(GetLocalString(oLever, "sTargetTag"));
        oOwner = oLever;
    }

    int   bLockBehind   = GetLocalInt(oOwner, "bLockBehind");
    float fLockDelay    = GetLocalFloat(oOwner, "fLockDelay");

    int   bClose        = GetLocalInt(oOwner, "bClose");
    float fCloseDelay   = GetLocalFloat(oOwner, "fCloseDelay");

    int   bOpen         = GetLocalInt(oOwner, "bOpen");
    float fOpenDelay    = GetLocalFloat(oOwner, "fOpenDelay");

    int bToggle         = GetLocalInt(oOwner, "bToggle");
    int bAnimation      = GetLocalInt(oOwner, "bAniamtion");

    if(bAnimation)
    {
        AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }

    if(bToggle)
    {
        if(GetLocked(oDoor))
            SetLocked(oDoor, FALSE);
        else
            SetLocked(oDoor, TRUE);
        return;
    }

    if(bLockBehind)
    {
        if(fLockDelay == 0.0)
            fLockDelay = 1.0;
        DelayCommand(fLockDelay, SetLocked(oDoor, TRUE));
    }

    if(bClose)
        DelayCommand(fCloseDelay, AssignCommand(oDoor, ActionCloseDoor(oDoor)));
    if(bOpen)
        DelayCommand(fOpenDelay, AssignCommand(oDoor, ActionOpenDoor(oDoor)));
}
