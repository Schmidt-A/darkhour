#include "dmts_common_inc"

void main()
{
   // Retrieve variables from user, set up working variables
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
   location lTargetLocation = GetLocation(oTarget);
   vector vPosition = GetPositionFromLocation(lTargetLocation);

   location lMyLocation = GetLocation(OBJECT_SELF);
   object oMyArea = GetAreaFromLocation(lMyLocation);
   float fMyFacing = GetFacing(OBJECT_SELF);
   vector vMyPosition = GetPositionFromLocation(lMyLocation);

   vector vNewPosition = Vector(vMyPosition.x, vMyPosition.y, vPosition.z);

   lTargetLocation = Location(oMyArea, vNewPosition, fMyFacing + 180.0f);

   RecreateObjectAtLocation(oTarget, lTargetLocation);
}
