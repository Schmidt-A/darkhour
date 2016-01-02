#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectSummonCreature("huggles", VFX_IMP_UNSUMMON, 1.0, 1), oPC);
    SetLocalInt(oPC, "hashuggles", 1);
    DelayCommand(3600.0, ExecuteScript("hugglesunsummon", oPC));
    }
}
