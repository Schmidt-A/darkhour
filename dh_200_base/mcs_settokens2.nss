int StartingConditional()
{
    object oItem;
    string sName;
    int iBaseToken = 11051;
    int iPageLen = 10;

    int iPage = GetLocalInt(OBJECT_SELF, "iConvPage");
    int iTotalItems = GetLocalInt(OBJECT_SELF, "iConvTotal");

    int iLoop = 0;
    int iOffset = (iPage * iPageLen);

    while ((iLoop < iPageLen) && ((iLoop + iOffset) < iTotalItems))
    {  oItem = GetLocalObject(OBJECT_SELF, "oConvItem_" + IntToString(iLoop + iOffset));
       sName = GetName(oItem);
       SetCustomToken(iBaseToken + iLoop, sName);
       iLoop++;
    }

    SetLocalString(OBJECT_SELF, "sConvScript", "mcs_setdevice");

    return TRUE;
}
