void main()
{
    int iDeviceNum = GetLocalInt(OBJECT_SELF, "iConvChoice");
    string sMCSTag = "ENC_MCS_" + IntToString(iDeviceNum);
    object oMCS = GetObjectByTag(sMCSTag);
    DeleteLocalInt(OBJECT_SELF, "iConvChoice");
    DeleteLocalString(OBJECT_SELF, "sConvScript");

    object oItem = GetFirstItemInInventory(oMCS);
    int iLoop = 0;

    while (GetIsObjectValid(oItem))
    {   if (GetTag(oItem) == "mali_mcs")
        { SetLocalObject(OBJECT_SELF, "oTempItem_" + IntToString(iLoop), oItem);
          iLoop++;
        }
        oItem = GetNextItemInInventory(oMCS);
    }

    SetLocalInt(OBJECT_SELF, "iConvTotal", iLoop);

    iLoop--;
    int iRef = iLoop;

    while (iLoop >= 0)
    {   oItem = GetLocalObject(OBJECT_SELF, "oTempItem_" + IntToString(iLoop));
        SetLocalObject(OBJECT_SELF, "oConvItem_" + IntToString(iRef - iLoop), oItem);
        iLoop--;
    }
}
