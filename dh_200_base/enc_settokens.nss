int StartingConditional()
{
    int iToken = 11050;
    int iLoop = 1;
    string sEncounterArea = GetLocalString(OBJECT_SELF, "sEncounterArea");
    string sSignTag = "";
    object oSign;

    while (iLoop < 13)
    { sSignTag = "SIGN_ENC_" + IntToString(iLoop) + sEncounterArea;
      oSign = GetObjectByTag(sSignTag);
      SetCustomToken(iToken + iLoop, GetName(oSign));
      iLoop++;
    }

    return TRUE;
}
