void main()
{

object oPC = GetFirstObjectInArea();
effect eEffect;
eEffect = EffectDamage(6, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);
ActionWait (10.0);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);
oPC = GetNextObjectInArea();
}

