int StartingConditional()
{
    float fMyFacing = GetFacing(OBJECT_SELF);
    SetCustomToken(11034, FloatToString(fMyFacing, 3, 2));
    SetLocalString(OBJECT_SELF, "sConvScript", "dm_sm_setfacing");

    return TRUE;
}
