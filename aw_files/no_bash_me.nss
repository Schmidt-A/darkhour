void main()
{
    object oPC = GetLastAttacker();
    if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
    {
        oPC = GetLastSpellCaster();
    }

    if (GetIsObjectValid(oPC) && GetIsPC(oPC))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneParalyze(), oPC, 30.0f);
        DelayCommand (2.0, FloatingTextStringOnCreature("Please stop, we need to rest here! :P", oPC, FALSE));
    }
}
