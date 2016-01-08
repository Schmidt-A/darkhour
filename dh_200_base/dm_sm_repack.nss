//------------------------------------------------------------------
// dm_sm_repack  repacks all props spawned from this widget by the
//               the player
//
// 10/25/2009    Malishara: recoded to use include file
//------------------------------------------------------------------

#include "dm_sm_inc"

void main()
{  object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
   Repack(oWidget, OBJECT_SELF);
}

