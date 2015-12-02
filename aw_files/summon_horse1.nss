#include "x3_inc_horse"

void main()
{
   object oPC =  GetPCSpeaker();
    location lTarget = GetLocation(oPC);
    float fDuration = 120.0;


    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, lTarget);

    HorseCreateHorse("horsy001",lTarget,oPC);
}
