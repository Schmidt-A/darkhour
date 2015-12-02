#include "inc_bs_module"

void main()
{
int nSearch = 1;
object oWpn = OBJECT_SELF;
object oUser = GetLastUsedBy();
int nUserTeam = GetPlayerTeam(oUser);
object oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oWpn, nSearch);
int nTargetTeam = GetPlayerTeam(oTarget);
int nAB = GetBaseAttackBonus(oUser);
nAB = nAB + GetAbilityModifier(ABILITY_DEXTERITY, oUser);
nAB = nAB + 5;
int nAC = GetAC(oTarget);
while(nUserTeam == nTargetTeam)
{
nSearch = nSearch++;
}
   if (d20(1)+nAB >= nAC)
  {
   effect eFire = EffectVisualEffect(VFX_FNF_FIREBALL);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFire, oTarget, 0.5f);
   EffectDamage(d6(4), DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_SIX);
   EffectDamage(d6(4), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);
   EffectDamage(d6(4), DAMAGE_TYPE_FIRE, DAMAGE_POWER_ENERGY);
   }
else
{
FloatingTextStringOnCreature("You missed", oUser, TRUE);

if (Random(100) >= 50)
{
effect eFire = EffectVisualEffect(VFX_FNF_FIREBALL);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFire, oTarget, 0.5f);
EffectDamage(d6(3), DAMAGE_TYPE_FIRE, DAMAGE_POWER_ENERGY);
}
}
 int iReloading = GetLocalInt(OBJECT_SELF, "reloading");
 if(iReloading ==TRUE)
    {
    return;
 SetLocalInt(OBJECT_SELF, "reloading", TRUE);
   }
}

