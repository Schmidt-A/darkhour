//::///////////////////////////////////////////////
//:: zep_demi_ondeath
//:: OnDeath event handler for the demilich creature
//:://////////////////////////////////////////////
/*
    Handles the custom death routines of demiliches.
*/
//:://////////////////////////////////////////////
//:: Created by: The Krit
//:: Created on: May 10, 2007
//:://////////////////////////////////////////////
// NOTE: The standard handler is nw_c2_default7.


#include "zep_inc_demi"


void main()
{
    // Some visuals to mark the "end" of this formidable creature.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_IMPLOSION), GetLocation(OBJECT_SELF));

    // Call the module-specified OnDeath handling.
    ExecuteScript(GetLocalString(GetModule(), ZEP_DEMI_DEAD_SCRIPT), OBJECT_SELF);

    // Send the demilich to its regenerative state.
    ZEPDemilichSpawnBones(OBJECT_SELF, TRUE);

    // Make sure the creature disappears (immediately).
    SetIsDestroyable(TRUE);
    DestroyObject(OBJECT_SELF);
}
