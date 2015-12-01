void main()
{
location lLoc = GetLocation(OBJECT_SELF);
CreateObject(OBJECT_TYPE_CREATURE, "zombielorduber", lLoc);
DestroyObject(OBJECT_SELF);
}
