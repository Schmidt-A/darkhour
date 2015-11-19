void main()
{
if(GetLocalInt(GetModule(), "destroycannon3") == 1)
    {
    SetLocalInt(GetModule(), "destroycannon3", 0);
    }
location lLocation = GetLocalLocation(GetModule(), "cannonspot");
CreateObject(OBJECT_TYPE_PLACEABLE, "customcannon003", lLocation, TRUE);
SetLocalInt(GetModule(), "cannon3placed", 1);
}
