//::///////////////////////////////////////////////
//:: zep_demi_onspawn
//:: OnSpawn event handler for the demilich creature
//:://////////////////////////////////////////////
/*
    Special configuration for the demilich --
    flag heartbeat and spell cast at events.
*/
//:://////////////////////////////////////////////
//:: Created by: The Krit
//:: Created on: May 10, 2007
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

void main()
{
    // Call the default spawn-in handling.
    ExecuteScript("nw_c2_default9", OBJECT_SELF);

    // Request that the "heartbeat" event get redirected to the user-defined event.
    // (So the demilich will revert to a pile of bones when no enemies are near.)
    SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);

    // Request that the "spell cast at" event get redirected to the user-defined event.
    // (So the demilich will try to trap the souls of casters.)
    SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);

    // Force a higher AI level.
    // This will cause the user-defined heartbeat to be thrown, even if there is
    // no PC in the area.
    // Since the user-defined heartbeat will despawn the demilich whenever the
    // AI level would have been lower (i.e. not in combat), this will not cause
    // lag (despite usually being a lag-suspect).
    SetAILevel(OBJECT_SELF, AI_LEVEL_NORMAL);
}

