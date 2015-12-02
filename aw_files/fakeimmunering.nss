#include "inc_bs_module"
void main()
{
    object oPC = GetItemActivator();
    FloatingTextStringOnCreature("<cÍ>You were not the killer of the Dragon<c/>", oPC, FALSE);
    BroadcastMessage("<cëLÊ>"+GetName(oPC)+" used a fake Immunity Ring!</c>");
    effect ePenguinEffect;
    ePenguinEffect = EffectPolymorph(POLYMORPH_TYPE_PENGUIN , TRUE);
    ePenguinEffect = SupernaturalEffect(ePenguinEffect);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePenguinEffect, oPC, 120.0f);
    SetPlotFlag (OBJECT_SELF,FALSE);
    DestroyObject(OBJECT_SELF, 2.0f);
}
