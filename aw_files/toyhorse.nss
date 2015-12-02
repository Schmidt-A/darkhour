#include "aw_include2"

void main()
{
    object oPC = GetItemActivator();

    BroadcastMessage("<cëLÊ>"+GetName(oPC)+" used the Toy Horse!</c>");
    location lTarget = GetItemActivatedTargetLocation();
    float fDuration = 120.0;

    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetItemActivatedTargetLocation());

    //generate random tag for horse - makes it easier to find again
    string sHorseTag = IntToString(d100()) +  IntToString(d100()) +  IntToString(d100());
    object oHorse = HorseCreateHorse("nightmare001",lTarget,oPC,sHorseTag);

    DelayCommand(fDuration,DestroyHorse(oHorse,oPC,sHorseTag));
}
