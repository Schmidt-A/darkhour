#include "inc_bs_module"
void main()
{
object oPC = GetItemActivator();

BroadcastMessage("<cëLÊ>"+GetName(oPC)+" used Time Stop!</c>");

location lTarget = GetLocation(oPC);
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eTime = EffectTimeStop();
    int nRoll = 1 + d4();


    {
        //Fire cast spell at event for the specified target
        SignalEvent(oPC, EventSpellCastAt(oPC, SPELL_TIME_STOP,FALSE));

        //Apply the VFX impact and effects
        DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, oPC, 9.0));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
    }
       SetPlotFlag (OBJECT_SELF,FALSE);
DestroyObject(OBJECT_SELF, 2.0f);
}
