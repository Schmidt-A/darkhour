#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSummonCreature("slappyskull"),oPC);
    }
}
