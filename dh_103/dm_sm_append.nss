#include "mali_string_fns"
#include "dm_sm_inc"
#include "x0_i0_position"


void main()
{   object oPC = OBJECT_SELF;
    object oWidget = GetLocalObject(oPC, "DM_SM_oWidget");

    int iChoice = GetLocalInt(oPC, "iConvChoice");
    object oProp = GetLocalObject(oPC, "DM_SM_oPlaceable" + IntToString(iChoice - 1));

    if (!GetIsObjectValid(oProp))
    { SendMessageToPC(oPC, "ERROR: Prop has been destroyed!"); return; }

    string sDesc = Upgrade(GetDescription(oWidget, FALSE, FALSE));

    sDesc = RestWords(sDesc, "|");
    int iCount = StringToInt(FirstWord(sDesc, "|"));
    iCount++;
    sDesc = RestWords(sDesc, "|");
    string sNewDesc = "V5|" + IntToString(iCount) + "|" + sDesc + "|";

    location lZero = GetLocalLocation(oWidget, "lZero");
    int iType = GetLocalInt(oWidget, "iDM_SM_SpawnType");

    vector vProp = GetPosition(oProp);
    float fFacing = GetFacing(oProp);

    if (iType != 1)
    { vector vZero = GetPositionFromLocation(lZero);
      float fZeroFacing = GetFacingFromLocation(lZero);

      float fAbsZeroX = StringToFloat(FirstWord(sDesc, "|"));
      sDesc = RestWords(sDesc, "|");
      float fAbsZeroY = StringToFloat(FirstWord(sDesc, "|"));
      sDesc = RestWords(sDesc, "|");
      float fAbsZeroZ = StringToFloat(FirstWord(sDesc, "|"));
      sDesc = RestWords(sDesc, "|");
      float fAbsZeroFacing = StringToFloat(FirstWord(sDesc, "|"));
      sDesc = RestWords(sDesc, "|");

      vector vAbsZero = Vector(fAbsZeroX, fAbsZeroY, fAbsZeroZ);

      if (iType == 2)
      { vector vRelative = Vector(vProp.x - vZero.x, vProp.y - vZero.y, vProp.z - vZero.z);
        vProp = Vector(vAbsZero.x + vRelative.x, vAbsZero.y + vRelative.y, vAbsZero.z + vRelative.z);
      }
      else if (iType == 3)
      { float fRelativeZ = vProp.z + vAbsZero.z - vZero.z;

        location lTemp = Location(GetArea(oPC), Vector(vProp.x, vProp.y, vZero.z), fFacing);
        float fDistance = GetDistanceBetweenLocations(lTemp, lZero);
        float fTheta = GetTheta(vZero, vProp);
        vProp = GetChangedPosition(vAbsZero, fDistance, fTheta + fAbsZeroFacing - fZeroFacing);

        fFacing = fFacing + fAbsZeroFacing - fZeroFacing;
        if (fFacing < 0.0f)
        { fFacing = fFacing + 360.0f; }

        vProp = Vector(vProp.x, vProp.y, fRelativeZ);
      }
    }

    sNewDesc += GetResRef(oProp) + "|";
    if( GetName(oProp, TRUE) != GetName(oProp, FALSE))
    { sNewDesc += SearchAndReplace(GetName(oProp, FALSE), "|", ":"); }
    sNewDesc += "|";
    if( GetLocalInt(oProp, "iRetagged") == TRUE)
    { sNewDesc += GetTag(oProp); }
    sNewDesc += "|" + IntToString(GetPlotFlag(oProp) + (GetUseableFlag(oProp) * 2) + (GetLocalInt(oProp, "iRetagged") * 4)) + "|";
    sNewDesc += FloatToString(vProp.x, 0, 2) + "|";
    sNewDesc += FloatToString(vProp.y, 0, 2) + "|" + FloatToString(vProp.z, 0, 2) + "|";
    sNewDesc += FloatToString(fFacing, 0, 2) + "|";
    sNewDesc += SaveVariables(oProp, FALSE);

    SetDescription(oWidget, sNewDesc, FALSE);

    string sPropList = GetLocalString(oWidget, "sPropList");
    sPropList += "." + ObjectToString(oProp) + ".";
    SetLocalString(oWidget, "sPropList", sPropList);

    iCount = GetLocalInt(oWidget, "iPropsSpawned_Set0");
    SetLocalObject(oWidget, "oSet0Prop"+IntToString(iCount), oProp);
    SetLocalInt(oWidget, "iPropsSpawned_Set0", iCount + 1);

    string sPropID_VarName = "oSet0Prop" + IntToString(iCount);
    SetLocalObject(oWidget, sPropID_VarName, oProp);
    SetLocalObject(oProp, "oStageManager", oWidget);
    SetLocalString(oProp, "sPropID_VarName", sPropID_VarName);
}

