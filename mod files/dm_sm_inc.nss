//------------------------------------------------------------------
// dm_sm_inc     include file for the DM Stage Manager
//
// 10/25/2009    Malishara: include file created
// 10/26/2009    Malishara: oReference changed to lReference
//                          iTrackingType added
// 11/03/2009    Malishara: added tracking options for appending
//                          props to existing sets
// 11/04/2009    Malishara: added Upgrade() function to upgrade a
//                          database string to the latest version
// 12/17/2009    Malishara: updated to V5
//
//
// database format
//  v1:   prop count|DM x|DM y|DM z|DM facing   |resref|x|y|z|facing
//  v2:   V2|prop count|DM x|DM y|DM z|DM facing   |resref|name|x|y|z|facing
//  v3:   V3|prop count|DM x|DM y|DM z|DM facing   |resref|name|flags|x|y|z|facing
//  v4:   V4|prop count|DM x|DM y|DM z|DM facing   |resref|name|tag|flags|x|y|z|facing
//  v5:   V5|prop count|DM x|DM y|DM z|DM facing   |resref|name|tag|flags|x|y|z|facing   |variable data
//------------------------------------------------------------------

#include "x0_i0_position"
#include "dmts_common_inc"


// Destroy the props that have been spawned from oWidget.  If oSpawnedBy
// is OBJECT_INVALID, all props will be destroyed, otherwise, only props
// spawned by character oSpawnedBy will be destroyed.
void Repack(object oWidget, object oSpawnedBy = OBJECT_INVALID);

// Spawn the props saved to oWidget.
// lReference:        "center" point used for calculating relative location.
// oSpawnedBy:        the PC that used the widget.
// iRelativeCoords:   TRUE for relative coordinates, FALSE for absolute.
// iRelativeFacing:   TRUE for relative facing, FALSE for absolute (original).
// iRestrictedUse:    tracks simultaneous uses, and charges.
// iTrackingType:     type of tracking used for destroying objects when done
//                    1: internal tracking
//                    2: Sparky spawns
void Unpack(object oWidget, location lReference, object oSpawnedBy = OBJECT_INVALID, int iRelativeCoords = FALSE, int iRelativeFacing = FALSE, int iRestrictedUse = FALSE, int iTrackingType = 1);


float GetTheta(vector vAlpha, vector vBeta)
{
   float fLengthX = vBeta.x - vAlpha.x;
   float fLengthY = vBeta.y - vAlpha.y;

   if( (fLengthX > 0.0f) && (fLengthY >= 0.0f))
   { return atan(fLengthY/fLengthX); }
   if( (fLengthX > 0.0f) && (fLengthY < 0.0f ))
   { return atan(fLengthY/fLengthX) + 360.0f; }
   if( fLengthX < 0.0f)
   { return atan(fLengthY/fLengthX) + 180.0f; }
   if( (fLengthX == 0.0f) && (fLengthY > 0.0f))
   { return 90.0f; }
   if( (fLengthX == 0.0f) && (fLengthY < 0.0f))
   { return 270.0f; }
   return 0.0f; // error somewhere...
}

string Upgrade(string sDesc)
{  if (FirstWord(sDesc, "|") == "V5")
   { return sDesc; }

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

   string sNewDesc = "V5|" + IntToString(iCounter);
   string sData = "";
   string sVarList;
   int iVarCount;

   int iCount = 0;
   int iLoop = 0;

   for (iLoop = 0; iLoop < 4; iLoop++)
   { sData = FirstWord(sDesc, "|");
     sDesc = RestWords(sDesc, "|");

     sNewDesc += "|" + FloatToString(StringToFloat(sData), 0, 2);
   }

   while (iCount < iCounter)
   { sNewDesc += "|" + FirstWord(sDesc, "|") + "|";      // resref
     sDesc = RestWords(sDesc, "|");

     if (iVersion2)
     { sNewDesc += FirstWord(sDesc, "|");                // name
       sDesc = RestWords(sDesc, "|");
     }
     sNewDesc += "|";
     if (iVersion4)
     { sNewDesc += FirstWord(sDesc, "|");                 // tag
       sDesc = RestWords(sDesc, "|");
     }
     sNewDesc += "|";
     if (iVersion3)
     { sNewDesc += FirstWord(sDesc, "|");                // flags
       sDesc = RestWords(sDesc, "|");
     }
     else
     { sNewDesc += "-1"; }

     for (iLoop = 0; iLoop < 4; iLoop++)
     { sData = FirstWord(sDesc, "|");
       sDesc = RestWords(sDesc, "|");

       sNewDesc += "|" + FloatToString(StringToFloat(sData), 0, 2);
     }

     sNewDesc += "|";
     if (iVersion5)
     { sVarList = FirstWord(sDesc, "|");
       sDesc = RestWords(sDesc, "|");

       sNewDesc += sVarList + "|";
       iVarCount = CountWords(sVarList + ",", ",");

       for (iLoop = iVarCount; iLoop > 0; iLoop--)
       { sNewDesc += "|" + RestWords(sDesc, "|");
         sDesc = RestWords(sDesc, "|");
       }
     }

     iCount++;
   }

   return sNewDesc;
}


void Repack(object oWidget, object oSpawnedBy = OBJECT_INVALID)
{  int iCurrentSets = GetLocalInt(oWidget, "iCurrentSets");

   object oProp = OBJECT_INVALID;
   string sNameTag = "";
   string sProp = "";

   int iSetLoop = 0;
   int iPropLoop = 0;

   int iProps = GetLocalInt(oWidget, "iPropsSpawned_Set" + IntToString(iSetLoop));

   while ((iSetLoop < iCurrentSets) && (iPropLoop < iProps))
   {   sProp =  "oSet" + IntToString(iSetLoop) + "Prop" + IntToString(iPropLoop);
       oProp = GetLocalObject(oWidget, sProp);

       if ((oSpawnedBy == OBJECT_INVALID) || (!(oProp == OBJECT_INVALID)))
       { if (GetHasInventory(oProp))
         { DestroyContents(oProp); }
         DestroyObject(oProp);
       }

       DeleteLocalObject(oWidget, sProp);
       iPropLoop++;

       if(iPropLoop == iProps)
       { DeleteLocalInt(oWidget, "iPropsSpawned_Set" + IntToString(iSetLoop));
         iSetLoop++;
         iPropLoop = 0;
         iProps = GetLocalInt(oWidget, "iPropsSpawned_Set" + IntToString(iSetLoop));
       }
   }
   DeleteLocalInt(oWidget, "iCurrentSets");
   DeleteLocalString(oWidget, "sPropList");
   DeleteLocalLocation(oWidget, "lZero");
   DeleteLocalInt(oWidget, "iDM_SM_SpawnType");

}

void Unpack(object oWidget, location lReference, object oSpawnedBy = OBJECT_INVALID, int iRelativeCoords = FALSE, int iRelativeFacing = FALSE, int iRestrictedUse = FALSE, int iTrackingType = 1)
{  int iCurrentSets = GetLocalInt(oWidget, "iCurrentSets");

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

   object oMyArea = GetAreaFromLocation(lReference);
   vector vMyNewPos = GetPositionFromLocation(lReference);

   float fMyOldX = StringToFloat(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");
   float fMyOldY = StringToFloat(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");
   float fMyOldZ = StringToFloat(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");
   vector vZero = Vector(fMyOldX, fMyOldY, fMyOldZ);
   float fMyOldFacing = StringToFloat(FirstWord(sDesc, "|"));
   sDesc = RestWords(sDesc, "|");
   location lMyOldLoc = Location(oMyArea, vZero, fMyOldFacing);

   float fPropX = 0.0f;
   float fPropY = 0.0f;
   float fPropZ = 0.0f;
   float fPropFacing = 0.0f;
   location lPropLocation = lReference;
   string sResRef = "";
   string sNewName = "";
   string sNewTag = "";
   string sPropList = "";
   string sPropID_VarName;
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
        if (iFlags != -1)
        { iHasPlot = iFlags & 1;
          iHasUseable = (iFlags & 2) / 2;
          iRetagged = (iFlags & 4) / 4;
        }
      }

      fPropX = StringToFloat(FirstWord(sDesc, "|"));
      sDesc = RestWords(sDesc, "|");
      fPropY = StringToFloat(FirstWord(sDesc, "|"));
      sDesc = RestWords(sDesc, "|");
      fPropZ = StringToFloat(FirstWord(sDesc, "|"));
      sDesc = RestWords(sDesc, "|");
      fPropFacing = StringToFloat(FirstWord(sDesc, "|"));
      sDesc = RestWords(sDesc, "|");

      lPropLocation = Location(oMyArea, Vector(fPropX, fPropY, fPropZ), fPropFacing);

      DeleteLocalLocation(oWidget, "lZero");

      if (iRelativeCoords)
      { lPropLocation = Location(oMyArea, Vector(fPropX, fPropY, fMyOldZ), fPropFacing);
        vector vNewProp = vZero;
        if (iRelativeFacing)
        { float fDistance = GetDistanceBetweenLocations(lMyOldLoc, lPropLocation);
          float fTheta = GetTheta(vZero, Vector(fPropX, fPropY, fMyOldZ));

          vNewProp = GetChangedPosition(vMyNewPos, fDistance, fTheta - fMyOldFacing + GetFacingFromLocation(lReference));
          float fRelativeZ = fPropZ - fMyOldZ + vMyNewPos.z;
          fPropFacing = fPropFacing - fMyOldFacing + GetFacingFromLocation(lReference);

          lPropLocation = Location(oMyArea, Vector(vNewProp.x, vNewProp.y, fRelativeZ), fPropFacing);

          SetLocalLocation(oWidget, "lZero", lReference);
          SetLocalInt(oWidget, "iDM_SM_SpawnType", 3);
        }
        else
        { vector vRelative = Vector(fPropX - fMyOldX, fPropY - fMyOldY, fPropZ - fMyOldZ);
          vNewProp = Vector(vMyNewPos.x + vRelative.x, vMyNewPos.y + vRelative.y, vMyNewPos.z + vRelative.z);
          lPropLocation = Location(oMyArea, vNewProp, fPropFacing);

          SetLocalLocation(oWidget, "lZero", lReference);
          SetLocalInt(oWidget, "iDM_SM_SpawnType", 2);
        }
      }
      else
      { SetLocalLocation(oWidget, "lZero", lMyOldLoc);
        SetLocalInt(oWidget, "iDM_SM_SpawnType", 1);
      }

      oProp = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lPropLocation, FALSE, sNewTag);
      sPropList += "." + ObjectToString(oProp) + ".";

      if( (iVersion2 == TRUE) && ( sNewName != ""))
      { SetName(oProp, sNewName); }
      if ((iVersion3 == TRUE) && (iFlags != -1))
      { SetPlotFlag(oProp, iHasPlot);
        SetUseableFlag(oProp, iHasUseable);
        SetLocalInt(oProp, "iRetagged", iRetagged);
      }

      if (iVersion5)
      { SetLocalString(oProp, "sDMTS_VarList", FirstWord(sDesc, "|"));
        sDesc = RestoreVariables(oProp, sDesc); }

      switch (iTrackingType)
      { case 1:  SetLocalString(oProp, "sNameTag", GetName(oSpawnedBy) + " (" + GetPCPlayerName(oSpawnedBy) + ")");
                 sPropID_VarName = "oSet" + IntToString(iCurrentSets) + "Prop" + IntToString(iLoop);
                 SetLocalObject(oWidget, sPropID_VarName, oProp);
                 SetLocalObject(oProp, "oStageManager", oWidget);
                 SetLocalString(oProp, "sPropID_VarName", sPropID_VarName);
                 break;
        case 2:  SetLocalInt(oProp, "iSparkySpawn", TRUE);
                 break;
        default: break;
      }

      iLoop++;
   }

   if (iTrackingType == 1)
   { SetLocalInt(oWidget, "iPropsSpawned_Set" + IntToString(iCurrentSets), iLoop);
     iCurrentSets++;
     SetLocalInt(oWidget, "iCurrentSets", iCurrentSets);
     SetLocalString(oWidget, "sPropList", sPropList);
   }

   if (iRestrictedUse)
   { int iCurrentUses = GetLocalInt(oWidget, "iCurrentUses");
     int iCurrentSets = GetLocalInt(oWidget, "iCurrentSets");
     int iMaxUses = GetLocalInt(oWidget, "iMaxUses");
     int iSimUses = GetLocalInt(oWidget, "iSimUses");

     if(iMaxUses != -1)
     { iCurrentUses--;
       SetLocalInt(oWidget, "iCurrentUses", iCurrentUses);
     }
   }

}

