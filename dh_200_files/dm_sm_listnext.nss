void main()
{
    object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
    int iOffset = GetLocalInt(OBJECT_SELF, "DM_SM_iOffset");
    int iPropIndex = GetLocalInt(oWidget, "iPropIndex");
    int iLoop = 0;
    object oProp = OBJECT_INVALID;

    while( iLoop < 10)
    {   DeleteLocalObject(OBJECT_SELF, "DM_SM_oPlaceable" + IntToString(iLoop));
        iLoop++;
    }

    iLoop = 0;
    while( (iLoop < 10) & (iOffset < iPropIndex))
    {  oProp = GetLocalObject(oWidget, "oProp" + IntToString(iOffset+1));
       if( GetIsObjectValid(oProp))
       {   SetLocalObject(OBJECT_SELF, "DM_SM_oPlaceable" + IntToString(iLoop), oProp);
           SetCustomToken(11020 + iLoop, GetName(oProp));
           iLoop++;
       }
       iOffset++;
    }

    SetLocalInt(OBJECT_SELF, "DM_SM_iOffset", iOffset);

    if( iOffset < iPropIndex)
    {   oProp = OBJECT_SELF; }
    else
    {   oProp = OBJECT_INVALID; }

    SetLocalObject(OBJECT_SELF, "DM_SM_oMore", oProp);
}
