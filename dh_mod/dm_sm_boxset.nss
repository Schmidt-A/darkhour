//----------------------------------------------------------------------------
// dm_sm_boxset
//
// 12/17/2009      Malishara: updated to use includes
//                            V5 - added support for saving/restoring variables
//----------------------------------------------------------------------------

#include "dmts_common_inc"


void main()
{
   string sDesc = "";
   location lMyLocation = GetLocation(OBJECT_SELF);
   vector vMyPos = GetPositionFromLocation(lMyLocation);
   float fMyFacing = GetFacing(OBJECT_SELF);

   sDesc = FloatToString(vMyPos.x, 0, 2) + "|" + FloatToString(vMyPos.y, 0, 2) + "|";
   sDesc += FloatToString(vMyPos.z, 0, 2) + "|" + FloatToString(fMyFacing, 0, 2);

   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
   int iConvChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
   int iPropIndex = GetLocalInt(oWidget, "iPropIndex");
   object oProp = OBJECT_SELF;
   location lProp = lMyLocation;
   int iRetagged = FALSE;
   vector vPos = vMyPos;
   float fFacing = fMyFacing;
   int iLoop = 0;
   int iCounter = 0;

   while( iLoop < iPropIndex)
   {   oProp = GetLocalObject(oWidget, "oProp" + IntToString(iLoop+1));
       if( GetIsObjectValid(oProp))
       {  lProp = GetLocation(oProp);
          vPos = GetPositionFromLocation(lProp);
          fFacing = GetFacing(oProp);
          sDesc += "|" + GetResRef(oProp) + "|";
          if( GetName(oProp, TRUE) != GetName(oProp, FALSE))
          { sDesc += SearchAndReplace(GetName(oProp, FALSE), "|", ""); }
          sDesc += "|";
          if( GetLocalInt(oProp, "iRetagged") == TRUE)
          { sDesc += GetTag(oProp); }
          sDesc += "|" + IntToString(GetPlotFlag(oProp) + (GetUseableFlag(oProp) * 2) + (GetLocalInt(oProp, "iRetagged") * 4)) + "|";
          sDesc += FloatToString(vPos.x, 0, 2) + "|";
          sDesc += FloatToString(vPos.y, 0, 2) + "|" + FloatToString(vPos.z, 0, 2) + "|";
          sDesc += FloatToString(fFacing, 0, 2) + "|";
          sDesc += SaveVariables(oProp, FALSE);

          iCounter++;

          if (iConvChoice == 1)
          { if (GetHasInventory(oProp))
            { DestroyContents(oProp); }
            DestroyObject(oProp);
          }

       }
       iLoop++;
   }

   sDesc = "V5|" + IntToString(iCounter) + "|" + sDesc;
   SetDescription(oWidget, sDesc, FALSE);
}
