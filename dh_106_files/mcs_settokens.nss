int StartingConditional()
{
    object oMCS;
    int iLoop = 1;

    while (iLoop < 15)
    { oMCS = GetObjectByTag("ENC_MCS_" + IntToString(iLoop));
      SetCustomToken(11050 + iLoop, GetName(oMCS));
      iLoop++;
    }

    SetLocalString(OBJECT_SELF, "sConvScript", "mcs_setstorage");
    DeleteLocalInt(OBJECT_SELF, "iConvPage");

    return TRUE;
}
