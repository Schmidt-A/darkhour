//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Apply VFX
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

void main()
{
struct CW2da data = Get2daData();
object oTarget = data.target;
effect eVFX = SupernaturalEffect(EffectVisualEffect(GetLocalInt(OBJECT_SELF, "CW_VFX")));
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oTarget);
}
