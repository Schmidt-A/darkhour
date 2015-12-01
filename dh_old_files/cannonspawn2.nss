void main()
{
if(GetLocalInt(GetModule(), "destroycannon2") == 1)
    {
    SetLocalInt(GetModule(), "destroycannon2", 0);
    }
location lLocation = GetLocalLocation(GetModule(), "cannonspot");
CreateObject(OBJECT_TYPE_PLACEABLE, "customcannon002", lLocation, TRUE);
SetLocalInt(GetModule(), "cannon2placed", 1);
}
