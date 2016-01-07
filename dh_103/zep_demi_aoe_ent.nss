//::///////////////////////////////////////////////
//:: zep_demi_aoe_ent
//:: OnEnter event handler for a demilich's AoE.
//:://////////////////////////////////////////////
/*
    Intended to be called when a creature enters
    a demilich's "detector" -- an invisible area
    of effect surrounding the demilich's rest state.
*/
//:://////////////////////////////////////////////
//:: Created by: The Krit
//:: Created on: May 10, 2007
//:://////////////////////////////////////////////


#include "zep_inc_demi"


void main()
{
    // Only react if the one entering is a living (non-DM) enemy.
    object oIntruder = GetEnteringObject();
    if ( GetIsEnemy(oIntruder)  &&  !GetIsDead(oIntruder)  &&
         !GetIsDM(oIntruder)    &&  !GetLocalInt(OBJECT_SELF, "DO_ONCE") )
    {
        // Prevent double firings.
        SetLocalInt(OBJECT_SELF, "DO_ONCE", TRUE);

        // Locate the associated placeables.
        object oBones = GetLocalObject(OBJECT_SELF, ZEP_DEMI_LOCAL_SOURCE);
        object oDust = GetLocalObject(OBJECT_SELF, ZEP_DEMI_LOCAL_AMBIENT);

        // Spawn the demilich.
        ZEPDemilichFromBones(oBones, GetLocalString(OBJECT_SELF, ZEP_DEMI_LOCAL_RESREF), TRUE);
        // Destroy the placeables.
        DestroyObject(oBones);
        DestroyObject(oDust);
        // Destroy the detector.
        DestroyObject(OBJECT_SELF);
    }
}

