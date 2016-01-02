void main()
{
if(GetFirstItemInInventory(OBJECT_SELF) == OBJECT_INVALID)
    {
    location lLoc = GetLocation(OBJECT_SELF);
    DestroyObject(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_PLACEABLE, "fertilesoil", lLoc);
    }
}
