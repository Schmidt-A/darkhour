void main()
{
    object oPC = GetItemActivator();
    int DwD = CLASS_TYPE_DWARVEN_DEFENDER;
    int instant = DURATION_TYPE_INSTANT;
    if (GetLevelByClass(DwD, oPC) > 0)
    {
        if( GetTag(GetArea(oPC)) != "arena_"+IntToString(GetLocalInt(GetModule(),"nRound")))
        {
        effect eOwn = EffectDamage(100000, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);
        effect ePwn = EffectDeath();
        ApplyEffectToObject(instant, eOwn, oPC);
        ApplyEffectToObject(instant, ePwn, oPC);
        }
    }
    else
    {
    FloatingTextStringOnCreature("You can't use that item since you're not a Dwarven Defender!", oPC, FALSE);
    }
}
