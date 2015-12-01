void main()
{
    int nCounter = GetLocalInt(OBJECT_SELF,"counter");
    nCounter += 1;
    if (nCounter >= 60)
    {
        location lLoc = GetLocation(OBJECT_SELF);
        CreateObject(OBJECT_TYPE_CREATURE,"zn_zombie018",lLoc);
        DestroyObject(OBJECT_SELF);
    }
    else
    {
        SetLocalInt(OBJECT_SELF,"counter",nCounter);
    }
}
