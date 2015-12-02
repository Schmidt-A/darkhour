//Modified undeath to death script. The spell is made single target
//and the HD check is removed. -Moff

#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"

void DoUndeadToDeath(object oCreature)
{
    SignalEvent(oCreature, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    if (!MySavingThrow(SAVING_THROW_WILL,oCreature,GetSpellSaveDC(),SAVING_THROW_TYPE_NONE,OBJECT_SELF))
    {
       float fDelay = GetRandomDelay(0.2f,0.4f);
       if (!MyResistSpell(OBJECT_SELF, oCreature, fDelay))
       {
            effect eDeath = EffectDamage(GetCurrentHitPoints(oCreature),DAMAGE_TYPE_DIVINE,DAMAGE_POWER_ENERGY);
            effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
            DelayCommand(fDelay+0.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oCreature));
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oCreature));
       }
    }
}

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();


// End of Spell Cast Hook

    object oTarget = GetSpellTargetObject();
    location lLocation = GetSpellTargetLocation();
// Impact VFX
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_STRIKE_HOLY),oTarget);
    TLVFXPillar(VFX_FNF_LOS_HOLY_20, lLocation,3,0.0f);

     if  (GetIsObjectValid(oTarget))
     {
       if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
       {
       DoUndeadToDeath(oTarget);
       }
     }
 }
