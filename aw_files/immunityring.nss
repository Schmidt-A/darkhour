#include "inc_bs_module"
void main()
{
    object oPC= GetItemActivator();
    BroadcastMessage("<cëLÊ>"+GetName(oPC)+" used Immunity Ring!</c>");
    effect eImmuneEffect =  EffectVisualEffect(497);
    eImmuneEffect = SupernaturalEffect(eImmuneEffect);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmuneEffect, oPC,180.0);
    eImmuneEffect = EffectDamageReduction(400, DAMAGE_POWER_PLUS_TWENTY ,0);
    eImmuneEffect = SupernaturalEffect(eImmuneEffect);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmuneEffect, oPC,180.0f);

    eImmuneEffect =     EffectSpellImmunity(SPELL_ALL_SPELLS);
    eImmuneEffect = SupernaturalEffect(eImmuneEffect);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmuneEffect, oPC,180.0f);

    SetPlotFlag (GetItemActivated(),FALSE);
    DestroyObject(GetItemActivated(), 2.0f);
}

