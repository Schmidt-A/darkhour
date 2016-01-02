#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    int iLevel = GetLevelByPosition(1, oPC) + GetLevelByPosition(2, oPC) + GetLevelByPosition(3, oPC);
    if(iLevel < 5)
        {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectSummonCreature("amenhotep3", VFX_IMP_UNSUMMON, 1.0, 1), oPC);
        SetLocalInt(oPC, "hasamenhotep", 1);
        DelayCommand(3600.0, ExecuteScript("amenunsummon", oPC));
        }else
            {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectSummonCreature("amenhotep5", VFX_IMP_UNSUMMON, 1.0, 1), oPC);
            SetLocalInt(oPC, "hasamenhotep", 1);
            DelayCommand(3600.0, ExecuteScript("amenunsummon", oPC));
            }
    }
}
