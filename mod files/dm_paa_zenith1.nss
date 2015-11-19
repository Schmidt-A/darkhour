// code to reset zenith of placeable to 1.0f

#include "dmts_common_inc"

void main()
{
   // Retrieve variables from user, set up working variables
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
   location lTargetLocation = GetLocation(oTarget);
   object oArea = GetAreaFromLocation(lTargetLocation);
   float fFacing = GetFacingFromLocation(lTargetLocation);
   vector vPosition = GetPositionFromLocation(lTargetLocation);

   // Adjust zenith
   vPosition = Vector(vPosition.x, vPosition.y, 1.0f);
   lTargetLocation = Location(oArea, vPosition, fFacing);

   RecreateObjectAtLocation(oTarget, lTargetLocation);
}

