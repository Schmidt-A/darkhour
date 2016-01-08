int StartingConditional()
{
    object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
    SetCustomToken(11005, FloatToString(GetFacing(oTarget), 3, 0));
    SetLocalString(OBJECT_SELF, "sConvScript", "dm_paa_setfacing");

    return TRUE;
}
