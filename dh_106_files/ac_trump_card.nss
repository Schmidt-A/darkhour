#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent !=  X2_ITEM_EVENT_ACTIVATE)
    {
    return;
    }
object oPC = oPC = GetItemActivator();
object oTarget = GetWaypointByTag("SUNDESSTART");
location lTarget = GetLocation(oTarget);
AssignCommand(oPC, ClearAllActions(TRUE));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_WIND), GetLocation(oPC));
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_DARKNESS), GetLocation(oPC), 5.0);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CALTROPS), GetLocation(oPC), 30.0);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), GetLocation(oPC));
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_STARBURST_GREEN), oPC);
DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
}
