void main()
{
object oPC= GetItemActivator();
effect ePoly = EffectPolymorph(108, TRUE);
int nLvL = GetHitDice(oPC);
int nDmg = nLvL/4;
int nAB = nLvL/4;
effect eDamage = EffectDamage(nDmg, DAMAGE_TYPE_BLUDGEONING);
effect eAB = EffectAttackIncrease(nAB);
effect eZombie;
eZombie = EffectLinkEffects(ePoly, eDamage);
eZombie = EffectLinkEffects(ePoly, eAB);
eZombie = ExtraordinaryEffect(ePoly);
FloatingTextStringOnCreature("You crave flesh!", oPC);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eZombie, oPC, HoursToSeconds(2));
}
