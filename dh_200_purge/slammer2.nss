// Tweek: I don't like this. Need to do something cleaner with it, but doesn't
// fit into door refactor. Comes from Dark Stairwell area trigger.

void DoSlam(string sTag)
{
    object oTarget = GetObjectByTag(sTag);
    AssignCommand(oTarget, ActionCloseDoor(oTarget));
    SetLocked(oTarget, TRUE);
    SetLockUnlockDC(oTarget, 26);
}

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC))
        return;

    DoSlam("slam1");
    DoSlam("slam2");
}

