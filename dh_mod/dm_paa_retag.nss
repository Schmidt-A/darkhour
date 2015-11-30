//----------------------------------------------------------------------------
//    dm_paa_retag        retag placeable from name
//
// 04/19/2010      Malishara: recoded to use RecreteObjectAtLocation() from
//                   include
//----------------------------------------------------------------------------

#include "dmts_common_inc"


void main()
{    object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
     location lTargetLocation = GetLocation(oTarget);
     string sName = GetName(oTarget);

     oTarget = RecreateObjectAtLocation(oTarget, lTargetLocation, sName);
     SetLocalInt(oTarget, "iRetagged", TRUE);
}

