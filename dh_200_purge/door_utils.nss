/* Put this on one or more door events and use variables to cause desired
   behaviour.

 string sTargetTag - set if you want the script to apply to some other door
                     (provide its tag) after the PC uses a different object.
 int bLockBehind   - usually goes OnOpen or OnClose. If set to TRUE will cause 
                     door to lock behind the PC.
 float fLockDelay  - if the door should be locked but not right away, add a
                     number for this.
 int bCloseBehind  - If set to TRUE will cause door to close behind the PC.
 float fCloseDelay - if there should be a delay before the door closes, set a
                     number for this
 int bOpen         - Set to TRUE if PC action should open a target door.

 Tweek 2016
*/

object GetDoorInteractor()
{
    object oPC = GetLastClosedBy();
    if(oPC == OBJECT_INVALID)
        oPC == GetLastOpenedBy();
    if(oPC == OBJECT_INVALID)
        oPC = GetClickingObject();
    if(oPC == OBJECT_INVALID)
        oPC = GetLastKiller();
    if(oPC == OBJECT_INVALID)
        oPC = GetLastAttacker();
    if(oPC == OBJECT_INVALID)
        oPC = GetLastUnlocked();
    if(oPC == OBJECT_INVALID)
        oPC = GetLastUsedBy();

    return oPC;
}

void main()
{
    object oPC = GetDoorInteractor();

    if(oPC == OBJECT_INVALID)
    {
        WriteTimestampedLogEntry("ERROR: Door " + GetTag(OBJECT_SELF) + 
                " could not find its user.");
        return;
    }

    object oDoor = GetObjectByTag(GetLocalString(OBJECT_SELF, "sTargetTag"));
    object oUsed = OBJECT_INVALID;

    if(oDoor == OBJECT_INVALID)
        oDoor = OBJECT_SELF
    else
        object oUsed = OBJECT_SELF

    int bLockBehind = GetLocalInt(oDoor, "bLockBehind");
    float fLockDelay = GetLocalFloat(oDoor, "fLockDelay");

    int bClose = GetLocalInt(oDoor, "bClose");
    float fCloseDelay = GetLocalFloat(oDoor, "fCloseDelay");

    int bOpen = GetLocalInt(oDoor, "bOpen");
    float fOpenDelay = GetLocalFloat(oDoor, "fOpenDelay");

    int bAnimation = FALSE;
    int bToggle = GetLocalInt(oDoor, "bToggle");

    if(oUsed != OBJECT_INVALID)
        bAnimation = GetLocalInt(oUsed, "bAniamtion");

    if(bAnimation)
    {
        AssignCommand(oUsed, ACTION_PLACEABLE_ACTIVATE);
        AssignCommand(oUsed, ACTION_PLACEABLE_DEACTIVATE);
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
