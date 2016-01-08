#include "dmts_common_inc"

void main()
{
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
   location lOriginal = GetLocalLocation(oTarget, "DM_PAA_lOriginal");

   RecreateObjectAtLocation(oTarget, lOriginal);
}
