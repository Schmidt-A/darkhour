#include "mali_string_fns"


int StartingConditional()
{
    int iResult;

    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    string sDesc = GetDescription(oWidget, FALSE, FALSE);
    string sFirst = FirstWord(sDesc, "|");
    if ((sFirst == "V2") || (sFirst == "V3") || (sFirst == "V4") || (sFirst == "V5"))
    { sDesc = RestWords(sDesc, "|");
      SetCustomToken(11021, GetStringLowerCase(sFirst));
    }
    else
    { SetCustomToken(11021, "v1"); }

    SetCustomToken(11020, FirstWord(sDesc, "|"));

    SetLocalString(OBJECT_SELF, "sConvScript", "dm_stage_dump");

    iResult = GetIsDM(OBJECT_SELF) || GetIsDMPossessed(OBJECT_SELF);
    return iResult;
}
