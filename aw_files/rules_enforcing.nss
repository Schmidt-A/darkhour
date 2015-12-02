void main()
{
    object antiworld = GetObjectByTag("antiworld_npc");
    int nHour = GetTimeHour();

    if (GetLocalInt(antiworld,"Rules_Enforcing") == 1) //DM Activate / Deactivate
    {
        SetLocalInt(antiworld,"Rules_Enforcing",0);
        FloatingTextStringOnCreature ("Rules Enforcing Disabled",GetLastUsedBy(),FALSE);
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    }
    else if (GetLocalInt(antiworld,"Rules_Enforcing") == 0)
    {
        SetLocalInt(antiworld,"Rules_Enforcing",1);
        SetLocalInt(antiworld, "LastShout", nHour);
        FloatingTextStringOnCreature ("Rules Enforcing Enabled",GetLastUsedBy(),FALSE);
         ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    }

}

