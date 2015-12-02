#include "inc_bs_module"

void main()
{
    object oPC = GetLastPlayerDying();
    effect eDeath = EffectDeath(FALSE, FALSE);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
}
