#include "_incl_location"

void DoSunDesPort(object oPC)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDispelMagicAll(40), oUser);
    effect eVanish = EffectVisualEffect(VFX_FNF_PWSTUN);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVanish, GetLocation(oUser));
    DelayCommand(1.0, PortToWaypoint(oPC, "ZHOBUSSTART"));
}

void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    DoSunDesPort(oUser);
    if(GetIsPC(oTarget))
        DoSunDesPort(oTarget);
}
