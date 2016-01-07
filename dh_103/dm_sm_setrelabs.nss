//------------------------------------------------------------------
// dm_sm_setrelabs  unpacks props with relative coords, absolute
//                  facing.
//
// 10/25/2009       Malishara: recoded to use include file
//------------------------------------------------------------------
#include "dm_sm_inc"


void main()
{
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
   Unpack(oWidget, GetLocation(OBJECT_SELF), OBJECT_SELF, TRUE);
}
