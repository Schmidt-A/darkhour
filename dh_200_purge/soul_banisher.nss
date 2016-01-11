void main()
{
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sItem = GetTag(oItem);
    location lLoc1 = GetLocation(oTarget);
    location lLoc2;
    effect eVanish;

    if (sItem == "Banisher")
    {
        lLoc2 = GetLocation(GetWaypointByTag("lostsoularrive"));
        if ((GetIsPC(oTarget) == TRUE) && (GetIsDM(oTarget) == FALSE))
        {
            eVanish = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
            int nCount = 0;
            while (nCount < 10)
            {
                nCount += 1;
                CreateItemOnObject("ZombieDisease",oTarget);
            }
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVanish,lLoc1);
            DelayCommand(1.0,AssignCommand(oTarget,JumpToLocation(lLoc2)));
        }
        else
        {
            SendMessageToPC(GetItemActivator(),"Target must be a PC.");
        }
    }
    else if (sItem == "ToAfterlife")
    {
        if ((GetIsPC(oTarget) == TRUE) && (GetIsDM(oTarget) == FALSE))
        {
            int nAlign = GetAlignmentGoodEvil(oTarget);
            eVanish = EffectVisualEffect(VFX_FNF_PWSTUN);
            if (nAlign == ALIGNMENT_EVIL)
            {
                lLoc2 = GetLocation(GetWaypointByTag("GoToHell"));
            }
            else if (nAlign == ALIGNMENT_GOOD)
            {
                lLoc2 = GetLocation(GetWaypointByTag("GoToHeaven"));
            }
            else
            {
                lLoc2 = GetLocation(GetWaypointByTag("GoToLimbo"));
            }
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVanish,lLoc1);
            DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget));
            DelayCommand(1.0,AssignCommand(oTarget,JumpToLocation(lLoc2)));
        }
        else
        {
            SendMessageToPC(GetItemActivator(),"Target must be a PC.");
        }
    }
    else if (sItem == "ReturnToLife")
    {
        lLoc2 = GetLocation(GetWaypointByTag("restoredlocation"));
        if ((GetIsPC(oTarget) == TRUE) && (GetIsDM(oTarget) == FALSE))
        {
            eVanish = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVanish,lLoc1);
            DelayCommand(1.0,AssignCommand(oTarget,JumpToLocation(lLoc2)));
            DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL),lLoc2));
        }
        else
        {
            SendMessageToPC(GetItemActivator(),"Target must be a PC.");
        }
    }
}
