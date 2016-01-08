//------------------------------------------------------------------
// dm_sm_update
//
// 05/16/2010    Malishara: created
//------------------------------------------------------------------

#include "dm_sm_inc"
#include "dmts_common_inc"


void main()
{   object oPC = OBJECT_SELF;
    object oWidget = GetLocalObject(oPC, "DM_SM_oWidget");

    int iType = GetLocalInt(oWidget, "iDM_SM_SpawnType");

    location lZero = GetLocalLocation(oWidget, "lZero");
    vector vZero = GetPositionFromLocation(lZero);
    float fZeroFacing = GetFacingFromLocation(lZero);

    string sDesc = GetDescription(oWidget, FALSE, FALSE);

    if( TestStringAgainstPattern("V*n", FirstWord(sDesc, "|")))
    { sDesc = RestWords(sDesc, "|"); }

    int iCount = StringToInt(FirstWord(sDesc, "|"));
    sDesc = RestWords(sDesc, "|");

    float fAbsZeroX = StringToFloat(FirstWord(sDesc, "|"));
    sDesc = RestWords(sDesc, "|");
    float fAbsZeroY = StringToFloat(FirstWord(sDesc, "|"));
    sDesc = RestWords(sDesc, "|");
    float fAbsZeroZ = StringToFloat(FirstWord(sDesc, "|"));
    sDesc = RestWords(sDesc, "|");
    float fAbsZeroFacing = StringToFloat(FirstWord(sDesc, "|"));
    sDesc = RestWords(sDesc, "|");

    vector vAbsZero = Vector(fAbsZeroX, fAbsZeroY, fAbsZeroZ);


    sDesc = FloatToString(fAbsZeroX, 0, 2) + "|" + FloatToString(fAbsZeroY, 0, 2) + "|";
    sDesc += FloatToString(fAbsZeroZ, 0, 2) + "|" + FloatToString(fAbsZeroFacing, 0, 2);


    int iLoop = 0;
    int iCounter = 0;
    object oProp;
    vector vProp;
    float fFacing;

    while (iLoop < iCount)
    { oProp = GetLocalObject(oWidget, "oSet0Prop" + IntToString(iLoop));
      if (GetIsObjectValid(oProp))
      { vProp = GetPosition(oProp);
        fFacing = GetFacing(oProp);

        if (iType != 1)
        { if (iType == 2)
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

        sDesc += "|" + GetResRef(oProp) + "|";
        if( GetName(oProp, TRUE) != GetName(oProp, FALSE))
        { sDesc += SearchAndReplace(GetName(oProp, FALSE), "|", ":"); }
        sDesc += "|";
        if( GetLocalInt(oProp, "iRetagged") == TRUE)
        { sDesc += GetTag(oProp); }
        sDesc += "|" + IntToString(GetPlotFlag(oProp) + (GetUseableFlag(oProp) * 2) + (GetLocalInt(oProp, "iRetagged") * 4)) + "|";
        sDesc += FloatToString(vProp.x, 0, 2) + "|";
        sDesc += FloatToString(vProp.y, 0, 2) + "|" + FloatToString(vProp.z, 0, 2) + "|";
        sDesc += FloatToString(fFacing, 0, 2) + "|";
        sDesc += SaveVariables(oProp, FALSE);

        iCounter++;
      }

      iLoop++;
    }


   sDesc = "V5|" + IntToString(iCounter) + "|" + sDesc;
   SetDescription(oWidget, sDesc, FALSE);
}


