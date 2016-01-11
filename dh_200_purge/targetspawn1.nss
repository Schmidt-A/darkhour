void main()
{
if(GetLocalInt(GetModule(), "destroytarget1") == 1)
    {
    SetLocalInt(GetModule(), "destroytarget1", 0);
    }
location lLocation = GetLocalLocation(GetModule(), "cannonspot");
CreateObject(OBJECT_TYPE_PLACEABLE, "customcannont001", lLocation, TRUE);
SetLocalInt(GetModule(), "target1placed", 1);
}
