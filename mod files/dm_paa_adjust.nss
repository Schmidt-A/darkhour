
// code to adjust location of placeable

#include "x0_i0_position"
#include "dmts_common_inc"

void main()
{
   // Retrieve variables from user, set up working variables
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
   int iDirection = GetLocalInt(OBJECT_SELF, "DM_PAA_iDirection");
   int iConvChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
   float fAdjustment = 0.0f;

   location lTargetLocation = GetLocation(oTarget);
   object oArea = GetAreaFromLocation(lTargetLocation);
   float fFacing = GetFacingFromLocation(lTargetLocation);
   vector vPosition = GetPositionFromLocation(lTargetLocation);

   switch (iConvChoice)
   { case 1:
       fAdjustment = 0.01f; break;
     case 2:
       fAdjustment = 0.05f; break;
     case 3:
       fAdjustment = 0.10f; break;
     case 4:
       fAdjustment = 0.25f; break;
     case 5:
       fAdjustment = 1.0f; break;
     case 6:
       fAdjustment = 5.0f; break;
     case 7:
       fAdjustment = 10.0f; break;
     case 8:
       fAdjustment = 25.0f; break;
     case 9:
       fAdjustment = 100.0f; break;
     default:
       fAdjustment = 0.0f; break;
   }

   switch (iDirection)
   { case 1:
       vPosition = GetChangedPosition(vPosition, fAdjustment, fFacing);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 2:
       vPosition = GetChangedPosition(vPosition, fAdjustment, fFacing + 180.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 3:
       vPosition = GetChangedPosition(vPosition, fAdjustment, fFacing + 90.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 4:
       vPosition = GetChangedPosition(vPosition, fAdjustment, fFacing - 90.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 5:
       vPosition = Vector(vPosition.x, vPosition.y, (vPosition.z + fAdjustment));
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 6:
       vPosition = Vector(vPosition.x, vPosition.y, (vPosition.z - fAdjustment));
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 7:
       vPosition = GetChangedPosition(vPosition, fAdjustment, 90.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 8:
       vPosition = GetChangedPosition(vPosition, fAdjustment, 270.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 9:
       vPosition = GetChangedPosition(vPosition, fAdjustment, 0.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 10:
       vPosition = GetChangedPosition(vPosition, fAdjustment, 180.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 11:
       vPosition = GetChangedPosition(vPosition, fAdjustment, 45.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 12:
       vPosition = GetChangedPosition(vPosition, fAdjustment, 135.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 13:
       vPosition = GetChangedPosition(vPosition, fAdjustment, 315.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     case 14:
       vPosition = GetChangedPosition(vPosition, fAdjustment, 225.0f);
       lTargetLocation = Location(oArea, vPosition, fFacing);
       break;
     default:
       SendMessageToPC(OBJECT_SELF, "ERROR: Invalid direction."); break;
   }

   RecreateObjectAtLocation(oTarget, lTargetLocation);
}

