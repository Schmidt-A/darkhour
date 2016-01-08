// Tweek: Cleaning this up, but need to confirm if this actually gets used
// ever.

#include "_incl_location"

void main()
{
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();

    if(!GetIsPC(oTarget))
    {
        SendMessageToPC(GetItemActivator(),"Target must be a PC.");
        return;
    }

    string sItem = GetTag(oItem);
    location lLoc1 = GetLocation(oTarget);
    effect eVanish;

    if (sItem == "Banisher")
    {
        eVanish = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
        int nCount = 0;
        while (nCount < 10)
        {
            nCount += 1;
            CreateItemOnObject("ZombieDisease",oTarget);
        }
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVanish, lLoc1);
        DelayCommand(1.0, PortToWaypoint(oPC, "lostsoularrive"));
    }
    else if (sItem == "ToAfterlife")
    {
        eVanish = EffectVisualEffect(VFX_FNF_PWSTUN);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVanish,lLoc1);
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,
                    EffectResurrection(),oTarget));
        DelayCommand(1.0,AssignCommand(oTarget, PortToWaypoint(oPC, "GoToFugue")));
    }
    else if (sItem == "ReturnToLife")
    {
        eVanish = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVanish,lLoc1);
        DelayCommand(1.0,AssignCommand(oTarget, PortToWaypoint(oPC,
                        "restoredlocation")));
        DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                    EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL),
                    "restoredlocation"));
        }
    }
}
