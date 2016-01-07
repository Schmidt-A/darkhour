void main()
{
if(GetLocalInt(GetModule(), "destroytarget3") == 1)
    {
    SetLocalInt(GetModule(), "destroytarget3", 0);
    }
location lLocation = GetLocalLocation(GetModule(), "cannonspot");
CreateObject(OBJECT_TYPE_PLACEABLE, "customcannont003", lLocation, TRUE);
SetLocalInt(GetModule(), "target3placed", 1);
}
