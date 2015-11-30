//----------------------------------------------------------------------------
//                      DMTS Common Functions Include
//
// 12/17/2009      Malishara: created
// 04/19/2010      Malishara: moved RecreteObjectAtLocation() here
//----------------------------------------------------------------------------

#include "mali_string_fns"


void DestroyContents(object oObject)
{  object oItem = GetFirstItemInInventory(oObject);
   while (GetIsObjectValid(oItem))
   { DestroyObject(oItem);
     oItem = GetNextItemInInventory(oObject);
   }
}

void CopyContents(object oSource, object oDest, string sTag = "")
{   object oItem = GetFirstItemInInventory(oSource);
    while (GetIsObjectValid(oItem))
    {   CopyObject(oItem, GetLocation(oDest), oDest, sTag);
        oItem = GetNextItemInInventory(oSource);
    }
}

string SaveVariables(object oObject, int iSaveInternals = TRUE)
{   string sNewList = "";
    string sData = "";
    string sVarType;
    string sVarName;

    string sDMTS_VarList = GetLocalString(oObject, "sDMTS_VarList");
    string sInternal_VarList = "int iRetagged,string sNameTag,int DM_PAA_iOriginal,"
                             + "int iSparkySpawned,string sPropID_VarName";
    string sVarList = "string sDMTS_VarList,int iPlayAnimation" + ",";

    if (iSaveInternals)
    { sVarList += "," + sInternal_VarList; }

    if (sDMTS_VarList != "")
    { sVarList = sDMTS_VarList + "," + sVarList; }

    while (sVarList != "")
    { sVarType = FirstWord(sVarList);
      sVarName = RestWords(FirstWord(sVarList, ","));
      sVarList = RestWords(sVarList, ",");

      if (sVarType == "string")
      { if (GetLocalString(oObject, sVarName) != "")
        { sNewList += ",string " + sVarName;
         sData += "|" + GetLocalString(oObject, sVarName);
        }
      }
      else if (sVarType == "int")
      { if (GetLocalInt(oObject, sVarName) != 0)
        { sNewList += ",int " + sVarName;
         sData += "|" + IntToString(GetLocalInt(oObject, sVarName));
        }
      }
      else if (sVarType == "float")
      { if (GetLocalFloat(oObject, sVarName) != 0.0f)
        { sNewList += ",float " + sVarName;
          sData += "|" + FloatToString(GetLocalFloat(oObject, sVarName), 0, 2);
        }
      }
    }

    return RestWords(sNewList, ",") + sData;
}

string RestoreVariables(object oObject, string sVarList, int iWriteVars = TRUE)
{string sData = RestWords(sVarList, "|");
    sVarList = FirstWord(sVarList, "|");
    string sVarType;
    string sVarName;
    string sVariable;

    while (sVarList != "")
    { sVarType = FirstWord(sVarList);
      sVarName = FirstWord(RestWords(sVarList), ",");
      sVarList = RestWords(sVarList, ",");

      sVariable = FirstWord(sData, "|");
      sData = RestWords(sData, "|");

      if (iWriteVars)
      { if (sVarType == "string")
        { SetLocalString(oObject, sVarName, sVariable); }
        else if (sVarType == "int")
        { SetLocalInt(oObject, sVarName, StringToInt(sVariable)); }
        else if (sVarType == "float")
        { SetLocalFloat(oObject, sVarName, StringToFloat(sVariable)); }
      }
    }

    return sData;
}

object RecreateObjectAtLocation(object oTarget, location lTargetLocation, string sNewTag = "")
{   int iPlot = GetPlotFlag(oTarget);
    int iUseable = GetUseableFlag(oTarget);

    string sNewName = GetName(oTarget);
    string sResRef = GetResRef(oTarget);
    string sDesc = GetDescription(oTarget);
    if (sNewTag == "")
    { sNewTag = GetTag(oTarget); }

    location lOriginal = GetLocalLocation(oTarget, "DM_PAA_lOriginal");
    object oStageManager = GetLocalObject(oTarget, "oStageManager");
    string sPropID_VarName = GetLocalString(oTarget, "sPropID_VarName");

    string sVariables = SaveVariables(oTarget);


    // Destroy existing placeable, create new placeable, update variables
    if (GetHasInventory(oTarget))
    { DestroyContents(oTarget); }
    DestroyObject(oTarget);

    oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lTargetLocation, FALSE, sNewTag);

    SetPlotFlag(oTarget, iPlot);
    SetUseableFlag(oTarget, iUseable);
    if( sNewName != "")
    { SetName(oTarget, sNewName); }
    if (GetDescription(oTarget) != sDesc)
    { SetDescription(oTarget, sDesc); }

    if (GetIsObjectValid(oStageManager))
    { SetLocalObject(oTarget, "oStageManager", oStageManager);
      SetLocalObject(oStageManager, sPropID_VarName, oTarget);
    }
    SetLocalObject(OBJECT_SELF, "DM_PAA_oTarget", oTarget);
    SetLocalLocation(oTarget, "DM_PAA_lOriginal", lOriginal);
    RestoreVariables(oTarget, sVariables);

    ExecuteScript("playanimation", oTarget);

    return oTarget;
}

