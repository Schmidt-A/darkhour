void main()
{
if(GetLocalInt(GetModule(), "destroytarget2") == 1)
    {
    SetLocalInt(GetModule(), "destroytarget2", 0);
    }
location lLocation = GetLocalLocation(GetModule(), "cannonspot");
CreateObject(OBJECT_TYPE_PLACEABLE, "customcannont002", lLocation, TRUE);
SetLocalInt(GetModule(), "target2placed", 1);
}
