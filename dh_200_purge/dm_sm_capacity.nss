int StartingConditional()
{
    int iResult;

    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    int iCharsUsed = GetLocalInt(oWidget, "iCharsUsed");
    int iRemaining = (8157 - iCharsUsed) / 50;

    string sCapacity = "Approximately " + IntToString(iCharsUsed) + " of 8192 characters used.\n";
    sCapacity += "Approximately " + IntToString(iRemaining) + " more props may be stored.\n"
              +  "If a prop has been renamed, retagged, or has variables preserved, the remaining capacity will be less than reported.";

    SetCustomToken(11035, sCapacity);

    iResult = TRUE;
    return iResult;
}
