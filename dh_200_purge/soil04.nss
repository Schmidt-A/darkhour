void main()
{
    object oItem = GetFirstItemInInventory();

    if (oItem == OBJECT_INVALID)
    {
        int nSSN = GetLocalInt(OBJECT_SELF,"ssn");
        int nInstance = 1;
        location lPlant;
        object oSoil = GetNearestObjectByTag("ssloc",OBJECT_SELF,nInstance);
        while (GetLocalInt(oSoil,"ssn") != nSSN)
        {
            nInstance += 1;
            object oSoil = GetNearestObjectByTag("ssloc",OBJECT_SELF,nInstance);
        }
        lPlant = GetLocation(oSoil);
        object oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"softsoil",lPlant);
        SetLocalInt(oNew,"ssn",nSSN);
        DestroyObject(OBJECT_SELF);
    }
}
