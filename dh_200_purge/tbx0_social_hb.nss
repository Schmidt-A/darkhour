//::///////////////////////////////////////////////
//:: FileName: tbx0_social_hb
//:://////////////////////////////////////////////
/*
    used to fire the social behaviors in user defined
*/
//:://////////////////////////////////////////////
//:: Created By: John Hawkins
//:: Created On: 03/07/2008
//:://////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
    if(GetHasEffect(EFFECT_TYPE_SLEEP))
    {
        // If we're asleep and this is the result of sleeping
        // at night, apply the floating 'z's visual effect
        // every so often
        if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            if(d10() > 6)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            }
        }
    }
    if ((!IsInConversation(OBJECT_SELF))&&(GetLocalInt(OBJECT_SELF,"SocialFoundSeat")!=1))
    {
        // Send the user-defined event signal if specified
        SignalEvent(OBJECT_SELF, EventUserDefined(4201));
    }
}

