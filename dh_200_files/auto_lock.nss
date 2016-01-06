// Should be put on any doors we automatically want to lock once closed.

void main()
{
    object oPC = GetLastClosedBy();
    if (!GetIsPC(oPC))
        return;

    DelayCommand(1.0, SetLocked(OBJECT_SELF, TRUE));
}

