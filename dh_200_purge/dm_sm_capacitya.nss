int StartingConditional()
{   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    int iCharsUsed = GetStringLength(GetDescription(oWidget, FALSE, FALSE));
    int iRemaining = (8192 - iCharsUsed) / 50;

    string sCapacity = IntToString(iCharsUsed) + " of 8192 characters used.";
    sCapacity += "Approximately " + IntToString(iRemaining) + " more props may be stored.\n"
              +  "If a prop has been renamed, retagged, or has variables preserved, the remaining capacity will be less than reported.";

    SetCustomToken(11035, sCapacity);
    SetLocalString(OBJECT_SELF, "sConvScript", "dm_sm_append");

    return TRUE;
}
