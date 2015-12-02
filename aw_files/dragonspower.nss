#include "inc_bs_module"
void main()
{
object oPC = GetItemActivator();
BroadcastMessage("<cëLÊ>"+GetName(oPC)+" used Dragon's Power!</c>");
effect eDragonEffect = EffectVisualEffect(VFX_IMP_POLYMORPH);
     eDragonEffect = SupernaturalEffect(eDragonEffect);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eDragonEffect , oPC);

         eDragonEffect = EffectPolymorph(POLYMORPH_TYPE_ANCIENT_RED_DRAGON , TRUE);
         eDragonEffect = SupernaturalEffect(eDragonEffect);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDragonEffect, oPC,180.0f);
   eDragonEffect = EffectSkillIncrease(SKILL_DISCIPLINE,50);
   eDragonEffect = SupernaturalEffect(eDragonEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDragonEffect, oPC,180.0f);
   eDragonEffect = EffectACIncrease(50);
   eDragonEffect = SupernaturalEffect(eDragonEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDragonEffect, oPC,180.0f);
   //eDragonEffect = EffectHaste();
   //eDragonEffect = SupernaturalEffect(eDragonEffect);
   //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDragonEffect, oPC,180.0f);
   eDragonEffect = EffectTrueSeeing();
   eDragonEffect = SupernaturalEffect(eDragonEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDragonEffect, oPC,180.0f);
   eDragonEffect = EffectSpellImmunity(SPELL_ALL_SPELLS);
   eDragonEffect = SupernaturalEffect(eDragonEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDragonEffect, oPC,180.0f);
   eDragonEffect = EffectModifyAttacks(5);
   eDragonEffect = SupernaturalEffect(eDragonEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDragonEffect, oPC,180.0f);
    SetPlotFlag (GetItemActivated(),FALSE);
    DestroyObject(GetItemActivated(), 2.0f);
}
