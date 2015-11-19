//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Remove all VFX
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
object oCreator;
effect eVFX = GetFirstEffect(oTarget);
while(GetIsEffectValid(eVFX))
    {
    if(GetEffectType(eVFX) == EFFECT_TYPE_VISUALEFFECT &&
       GetEffectSubType(eVFX) == SUBTYPE_SUPERNATURAL)
        {
        oCreator = GetEffectCreator(eVFX);
        if(oCreator == OBJECT_SELF ||
           !GetIsObjectValid(oCreator))
            {
            RemoveEffect(oTarget, eVFX);
            }
        }
    eVFX = GetNextEffect(oTarget);
    }
}
