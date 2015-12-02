void main()
{
object oTarget = GetSpellTargetObject();
if (GetLocalInt(oTarget, "ZombieInfected") != TRUE)
{
    SetLocalInt(oTarget, "ZombieInfected", TRUE);

    effect eDamage = EffectDamage(GetCurrentHitPoints(oTarget), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);
    effect eZombie = EffectPolymorph(107, TRUE);

    FloatingTextStringOnCreature("You have been bitten!", oTarget);
    DelayCommand(TurnsToSeconds(1), FloatingTextStringOnCreature("You feel... strange...", oTarget));
    DelayCommand(TurnsToSeconds(2), FloatingTextStringOnCreature("Ugh... you are in pain...", oTarget));
    DelayCommand(TurnsToSeconds(2), ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
    DelayCommand(TurnsToSeconds(3), FloatingTextStringOnCreature("You... crave flesh...", oTarget));
    DelayCommand(TurnsToSeconds(4), FloatingTextStringOnCreature("You turn into a zombie!", oTarget));
    DelayCommand(TurnsToSeconds(4), ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eZombie , oTarget, HoursToSeconds(2)));
    DelayCommand(HoursToSeconds(4), DeleteLocalInt(oTarget, "ZombieInfected"));

}
}
