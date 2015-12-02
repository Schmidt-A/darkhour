#include "inc_bs_module"
void main()
{
object oPC = GetItemActivator();
BroadcastMessage("<cëLÊ>"+GetName(oPC)+" used Fairy Dust!</c>");
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oPC);
effect eFayEffect;
         eFayEffect = EffectPolymorph(POLYMORPH_TYPE_PIXIE , TRUE);
         eFayEffect = SupernaturalEffect(eFayEffect);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFayEffect, oPC,180.0f);

         eFayEffect = EffectEthereal();
         eFayEffect = SupernaturalEffect(eFayEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFayEffect, oPC,180.0f);
    eFayEffect = EffectRegenerate(8,5.0);
    eFayEffect = SupernaturalEffect(eFayEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFayEffect, oPC,180.0f);
    //eFayEffect = EffectHaste();
    //eFayEffect = SupernaturalEffect(eFayEffect);
   //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFayEffect, oPC,180.0f);
    eFayEffect = EffectTrueSeeing();
    eFayEffect = SupernaturalEffect(eFayEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFayEffect, oPC,180.0f);
    eFayEffect = EffectSpellImmunity(SPELL_ALL_SPELLS);
    eFayEffect = SupernaturalEffect(eFayEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFayEffect, oPC,180.0f);
    eFayEffect = EffectDamageShield(50,DAMAGE_BONUS_2d8,DAMAGE_TYPE_MAGICAL);
    eFayEffect = SupernaturalEffect(eFayEffect);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFayEffect, oPC,180.0f);
      SetPlotFlag (OBJECT_SELF,FALSE);
DestroyObject(OBJECT_SELF, 2.0f);
}
