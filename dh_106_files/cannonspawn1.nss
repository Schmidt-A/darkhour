void main()
{
if(GetLocalInt(GetModule(), "destroycannon1") == 1)
    {
    SetLocalInt(GetModule(), "destroycannon1", 0);
    }
location lLocation = GetLocalLocation(GetModule(), "cannonspot");
CreateObject(OBJECT_TYPE_PLACEABLE, "customcannon001", lLocation, TRUE);
SetLocalInt(GetModule(), "cannon1placed", 1);
}
