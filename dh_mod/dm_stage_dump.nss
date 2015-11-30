//----------------------------------------------------------------------------
// dm_sm_boxset
//
// 12/17/2009      Malishara: updated to use includes, V5 support
//----------------------------------------------------------------------------

#include "dmts_common_inc"


void main()
{
   int iConvChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
   int iCurrentSets = GetLocalInt(oWidget, "iCurrentSets");

   object oProp = OBJECT_INVALID;
   string sDesc = GetDescription(oWidget, FALSE, FALSE);
   int iVersion2 = FALSE;
   int iVersion3 = FALSE;
   int iVersion4 = FALSE;
   int iVersion5 = FALSE;

   if( (FirstWord(sDesc, "|") == "V2"))
   { iVersion2 = TRUE;
     sDesc = RestWords(sDesc, "|"); }
   else if( (FirstWord(sDesc, "|") == "V3"))
   { iVersion2 = TRUE;
     iVersion3 = TRUE;
     sDesc = RestWords(sDesc, "|"); }
   else if( (FirstWord(sDesc, "|") == "V4"))
   { iVersion2 = TRUE;
     iVersion3 = TRUE;
     iVersion4 = TRUE;
     sDesc = RestWords(sDesc, "|"); }
   else if( (FirstWord(sDesc, "|") == "V5"))
   { iVersion2 = TRUE;
     iVersion3 = TRUE;
     iVersion4 = TRUE;
     iVersion5 = TRUE;
     sDesc = RestWords(sDesc, "|"); }


   int iCounter = StringToInt(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");

   location lMyLocation = GetLocation(OBJECT_SELF);
   object oMyArea = GetAreaFromLocation(lMyLocation);

   float fMyOldX = StringToFloat(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");
   float fMyOldY = StringToFloat(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");
   float fMyOldZ = StringToFloat(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");
   vector vZero = Vector(fMyOldX, fMyOldY, fMyOldZ);
   float fMyOldFacing = StringToFloat(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");

   string sPropX;
   string sPropY;
   string sPropZ;
   string sPropFacing;
   location lPropLocation = lMyLocation;
   string sResRef = "";
   string sNewName = "";
   string sNewTag = "";
   int iFlags = 0;
   int iHasPlot = 0;
   int iHasUseable = 0;
   int iRetagged = 0;

   int iLoop = 0;

   while( iLoop < iCounter)
   {
      sResRef = FirstWord(sDesc, "|");
      sDesc = RestWords(sDesc, "|");
      if( iVersion2 == TRUE)
      { sNewName = FirstWord(sDesc, "|");
        sDesc = RestWords(sDesc, "|"); }
      if( iVersion4 == TRUE)
      { sNewTag = FirstWord(sDesc, "|");
        sDesc = RestWords(sDesc, "|"); }
      if( iVersion3 == TRUE)
      { iFlags = StringToInt(FirstWord(sDesc, "|"));
        sDesc = RestWords(sDesc, "|");
        iHasPlot = iFlags & 1;
        iHasUseable = (iFlags & 2) / 2;
        iRetagged = (iFlags & 4) / 4; }

      sPropX = FirstWord(sDesc, "|");
      sDesc = RestWords(sDesc, "|");
      sPropY = FirstWord(sDesc, "|");
      sDesc = RestWords(sDesc, "|");
      sPropZ = FirstWord(sDesc, "|");
      sDesc = RestWords(sDesc, "|");
      sPropFacing = FirstWord(sDesc, "|");
      sDesc = RestWords(sDesc, "|");

      if (iConvChoice == 2)
      { float fFacing = StringToFloat(sPropFacing);
        if (fFacing < 90.0f)
        { fFacing = fFacing + 270.0f; }
        else
        { fFacing = fFacing - 90.0f; }
        sPropFacing = FloatToString(fFacing, 0, 2);
      }

//      lPropLocation = Location(oMyArea, Vector(fPropX, fPropY, fPropZ), fPropFacing);
//      oProp = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lPropLocation, FALSE, sNewTag);
      SendMessageToPC(OBJECT_SELF, sResRef + ": (" + sPropX + ", " + sPropY + ", " + sPropZ + ")  facing " + sPropFacing);

//      if( (iVersion2 == TRUE) && (sNewName != ""))
//      { SetName(oProp, sNewName); }
//      if( iVersion3 == TRUE)
//      { SetPlotFlag(oProp, iHasPlot);
//        SetUseableFlag(oProp, iHasUseable); }
//      SetLocalString(oProp, "sNameTag", GetName(OBJECT_SELF) + " (" + GetPCPlayerName(OBJECT_SELF) + ")");
//      SetLocalInt(oProp, "iRetagged", iRetagged);

//      SetLocalObject(oWidget, "oSet"+IntToString(iCurrentSets)+"Prop"+IntToString(iLoop), oProp);

      if (iVersion5)
      { sDesc = RestoreVariables(OBJECT_SELF, sDesc, FALSE); }

      iLoop++;
   }

//   iCurrentSets++;
//   SetLocalInt(oWidget, "iCurrentSets", iCurrentSets);
}


