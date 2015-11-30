void main()
{
    int iPageLen = 10;
    int iPage = GetLocalInt(OBJECT_SELF, "iConvPage");
    int iChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");

    int iOffset = iPage * iPageLen;

    int iDeviceNum = (iChoice - 1) + iOffset;

    object oMCS = GetLocalObject(OBJECT_SELF, "oConvItem_" + IntToString(iDeviceNum));
    SetLocalObject(OBJECT_SELF, "oMCS_Device", oMCS);
    DeleteLocalInt(OBJECT_SELF, "iConvChoice");
    DeleteLocalString(OBJECT_SELF, "sConvScript");

    ExecuteScript("mcs_release", OBJECT_SELF);
}

