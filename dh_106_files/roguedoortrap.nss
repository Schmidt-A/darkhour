/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Can go OnDamaged, OnDisturbed, OnSpellCastAt, creature heartbeats, etc.
void main()
{

object oPC = GetLastHostileActor();

if (!GetIsPC(oPC)) return;

effect eEffect;
eEffect = EffectDamage(5, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SPIKE_TRAP), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SPIKE_TRAP), GetLocation(oTarget));

}

