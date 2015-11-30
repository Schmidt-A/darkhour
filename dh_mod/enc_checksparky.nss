int StartingConditional()
{
    object oArea = GetArea(OBJECT_SELF);
    int iHasEnc = TRUE;
    int iLoop = 0;
    string sEnc;
    string sNum;
    int iDisabled = GetLocalInt(oArea, "iSparkyDisabled");
    string sStatus = iDisabled ? "OFF" : "ON";

    while (iHasEnc)
    { if ((iLoop +1) < 10)
      { sNum = "0" + IntToString(iLoop + 1); }
      else
      { sNum = IntToString(iLoop + 1); }
      sEnc = GetLocalString(oArea, "encounter_" + sNum);
      if (sEnc == "")
      { iHasEnc = FALSE; }
      else
      { iLoop++; }
    }

    SetCustomToken(11051, IntToString(iLoop) + ", " + sStatus);

    DeleteLocalInt(OBJECT_SELF, "iConvPage");
    SetLocalInt(OBJECT_SELF, "iSparkyTotal", iLoop);

    return (iLoop > 0);
}
