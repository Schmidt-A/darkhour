//New Meteor Swarm
//All within Colossal Radius automaticly take 24d6 Blud. Damage.
//6d6 Fire Damage reflex ST for half.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
    //If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
    return;
    }
    //End of Spell Cast Hook
    //Declare major variables
    int nMetaMagic;
    int nBDamage;
    int nFireDamage;
    effect eFire;
    effect eBloud;
    effect eMeteor = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    //Apply the meteor swarm VFX area impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, GetLocation(OBJECT_SELF));
    //Get first object in the spell area
    float fDelay;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
    {
    fDelay = GetRandomDelay();
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_METEOR_SWARM));
    //Make sure the target is outside the 2m safe zone
    if (GetDistanceBetween(oTarget, OBJECT_SELF) > 2.0)
    {
     //Make SR check
     if (!MyResistSpell(OBJECT_SELF, oTarget, 0.5))
     {
     //Roll damage
      nBDamage = d6(24);
      nFireDamage = d6(6);
      //Enter Metamagic conditions
      if (nMetaMagic == METAMAGIC_MAXIMIZE)
      {
      //Damage is at max
      nBDamage = 120;
      nFireDamage =36;
      }
      if (nMetaMagic == METAMAGIC_EMPOWER)
      {
      //Damage/Healing is +50%
      nBDamage = nBDamage + (nBDamage/2);
      nFireDamage = nFireDamage + (nFireDamage/2);
      }
      nFireDamage = GetReflexAdjustedDamage(nFireDamage, oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_FIRE);
      //Set the fire damage effect
      eFire = EffectDamage(nFireDamage, DAMAGE_TYPE_FIRE);
      //Set the bloudgouning damage effect
      eBloud = EffectDamage(nBDamage, DAMAGE_TYPE_BLUDGEONING);
      if((nBDamage + nFireDamage) > 0)
      {
      //Apply damage effect and VFX impact.
      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBloud, oTarget));
      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
      }
      }
      }
      }
      //Get next target in the spell area
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
      }
      }
