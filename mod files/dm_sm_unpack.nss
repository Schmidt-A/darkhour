//------------------------------------------------------------------
// dm_sm_unpack     unpacks props with relative coords & facing, and
//                  tracks number of sets currently spawned, and how
//                  many uses remain.
//
// 10/25/2009       Malishara: recoded to use include file
//------------------------------------------------------------------
#include "dm_sm_inc"


void main()
{
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
   Unpack(oWidget, GetLocation(OBJECT_SELF), OBJECT_SELF, TRUE, TRUE, TRUE);
}
