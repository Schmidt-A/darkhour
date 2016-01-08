void main()
{
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    if (GetIsObjectValid(oTarget))
    {
        string sMsg = "Now following " + GetName(oTarget);
        FloatingTextStringOnCreature(sMsg, oPC, FALSE);
        DelayCommand(2.0f, AssignCommand(oPC, 
                    ActionForceFollowObject(oTarget, 2.0f)));
    }

}
