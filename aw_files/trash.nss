//:://////////////////////////////////////////////
//:: Created By: Paul Baines (Bainsy)            /
//:: Created On: 27 april 2003                   /
//:://////////////////////////////////////////////

//but this on the HB of an invisable object to clean treasure in that area every
//5 mins as default but u can change the clean up time below
void TrashObject(object oItem)
{
    if(GetHasInventory(oItem) == FALSE)
    {
    DestroyObject(oItem);
    }
    else
    {
    object oItem2 = GetFirstItemInInventory(oItem);

    while(GetIsObjectValid(oItem2))
    {
    TrashObject(oItem2);
    oItem2 = GetNextItemInInventory(oItem);
    }
    DestroyObject(oItem);
    }
}
void main()
{
    object oItem = GetFirstObjectInArea();
    int oGo = GetLocalInt(OBJECT_SELF,"go");
//ok just change the number here if(oGo == ?) 1 is about 7 secs so if u set it
//to 10 it would clean treasure every 70 secs it is set to 40 now so it will
//clean about every 5 mins
//need help (paulbaines@baines31.fsnet.co.uk)
    if(oGo == 40)
    {
    SetLocalInt(OBJECT_SELF,"go",0);
    while(GetIsObjectValid(oItem))
    {
    if(GetObjectType(oItem) == OBJECT_TYPE_PLACEABLE && GetTag(oItem) == "BodyBag")
    {
    TrashObject(oItem);
    }
    oItem = GetNextObjectInArea();
    }
    }
    else
    {
    ++oGo;
    SetLocalInt(OBJECT_SELF,"go",oGo);
    }
}
