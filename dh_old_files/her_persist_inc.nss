#include "tokenizer_inc"
//#include "her_chest_inc"
#include "her_debug"

int nDebug = 0;
int iDebug = GetLocalInt(GetModule(),"debugpersist");
int merDebug = GetLocalInt(GetModule(),"debugmerchants");
//this function is used in place of copy object because it copies a number of
//local variables along with the object copy, the locals should be 'index',
//'shop_infinite', 'ownercontainer'
object HerCopyObject(object oSource, location locLocation, object oOwner = OBJECT_INVALID, string sNewTag ="");

//Deletes an Item from the database using an index reference to find the item
//which is usually stored on the container using the sTag of the item
void DelIndexItem(int index, object oContainer);

// Function exists for use to initialize a persistent container and reload
//its contents in their entirety.  This can be called from the onopen event,
//it exists in this form mostly to handle the situation of chests contents being
//modified prior to them actually being opened ie: from store containers having
//stuff sold into them without having been opened.
void InitContainer(object oContainer);

// This function exists to remove an item from the database of the container
//that called the function, it reshuffles the last item in the database to the
//slot formerly occupied by the removed item, and then cleans up that database
//slot afterwards, it deletes the item using the 'index' localint stored on oItem
void DelItem(object oItem, object oContainer);

//This function exists to add items into a database for a container, if
//there is no database so far, it will be created as soon as an item is placed
//in the container, it stores an index reference to the database item on oItem
//as a local variable called 'index'
void AddItem(object oItem, object oContainer);


//used to clear the database for a container, call it on a container and it should
//wipe everything in the database, it won't actually erase the items inside the
//container ingame however you must use another function to do that
void VaporizeContainer(object oContainer);

//ok this function is used to generate the string that will be used for the database
//variable name for storing the data for a given container or object.
string PlaceableString (object oContainer);

object HerCopyObject(object oSource, location locLocation, object oOwner = OBJECT_INVALID, string sNewTag ="")
{
    object oCopy = CopyObject(oSource, locLocation, oOwner, sNewTag);
    object ownercontainer = GetLocalObject(oSource, "ownercontainer");
    string sTag = GetTag(oSource);
    int index = GetLocalInt(oSource, "index");
    if (!GetLocalInt(ownercontainer, "initialized"))
    {
    InitContainer(ownercontainer);
    }
    string chestname = GetLocalString(ownercontainer, "chestname");
    SetLocalInt(oCopy, "index", index);
    SetLocalInt(oCopy, "shop_infinite", GetLocalInt(oSource, "shop_infinite"));
    SetLocalObject(oCopy, "ownercontainer", ownercontainer);
    //if(   GetLocalInt(oCopy, "shop_infinite")
//        || GetIsTokenInString(GetSubString(sTag, 6, 26),GetLocalString(oCache, "shop_infinite")))
//    {
//        return oCopy;
//    }
//    else
//    {
        SetLocalObject(ownercontainer, chestname + IntToString(index), oCopy);
//    }
    return oCopy;
}

void VaporizeContainer(object oContainer)
{

    int i = 0;
    if (iDebug) herDebug("Vaporization Commencing");
    SendMessageToPC(GetLastDisturbed(), "Vaporizing of database commencing");
    vector chestposition = GetPosition(oContainer);
    string chest = PlaceableString(oContainer);
    string dbase = GetName(GetModule());
    object oItem;
    int size = GetCampaignInt(dbase, chest + "size");
    if (iDebug) herDebug("size: " + IntToString(size));
    while (i < size)
    {
        i++;
        DeleteCampaignVariable(dbase, chest + IntToString(i));
    }
    SetCampaignInt(dbase, chest + "size", 0);
    SetLocalInt(oContainer, chest + "size", 0);
    DeleteLocalInt(oContainer, "goldindex");
    SetLocalInt(GetLocalObject(oContainer, "shop_cache"), "spawnedyet", 0);
    ExecuteScript("shop_spawn", GetLocalObject(oContainer, "shop_cache"));
}


void InitContainer(object oContainer)
{
    int i = 0;
    if (iDebug) herDebug("Chest opening");
    if (GetIsDM(GetLastDisturbed()))
    {
        SendMessageToPC(GetLastDisturbed(), "Initializing container " + GetName(oContainer) + " now");
    }
    vector chestposition = GetPosition(oContainer);
    string chest = PlaceableString(oContainer);
    string dbase = GetName(GetModule());
    object oItem;
    SetLocalString(OBJECT_SELF, "chestname", chest);
    int size = GetCampaignInt(dbase, chest + "size");
    if (iDebug) herDebug("size: " + IntToString(size));
    oItem = GetFirstItemInInventory(oContainer);
    while (oItem != OBJECT_INVALID)
    {
        if(GetHasInventory(oItem))
        {
            object oItem2 = GetFirstItemInInventory(oItem);
            while(oItem2 != OBJECT_INVALID)
            {
                DestroyObject(oItem2);
                oItem2 = GetNextItemInInventory(oItem);
            }
        }
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oContainer);
    }
    while (i < size)
    {
        i++;
        oItem = RetrieveCampaignObject(dbase, chest + IntToString(i), GetLocation(oContainer), oContainer);
        if (iDebug) herDebug(GetName(oItem));
        if (iDebug) herDebug(IntToString(i));
        SetLocalInt(oItem, "index", i);
        SetLocalObject(oContainer, chest + IntToString(i), oItem);
        SetLocalObject(oItem, "ownercontainer", oContainer);
    }
    SetLocalInt(oContainer, chest + "size", i);
    SetLocalInt(oContainer, "initialized",1);
}


/* This function exists to remove an item from the database of the container
that called the function, it reshuffles the last item in the database to the
slot formerly occupied by the removed item, and then cleans up that database
slot afterwards*/
void DelItem(object oItem, object oContainer)
{
    if (iDebug) herDebug("I have been disturbed");
    int i = 0;
    int index = 0;
    vector chestposition = GetPosition(oContainer);
    string chest = PlaceableString(oContainer);
    object lItem;
    string dbase = GetName(GetModule());
    if(GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED)
    {
        index = GetLocalInt(oItem, "index");
        i = GetCampaignInt(dbase, chest + "size");
        if(i > 1)
        {
            lItem = GetLocalObject(oContainer, chest + IntToString(i));
            oItem = RetrieveCampaignObject(dbase, chest + IntToString(i), GetLocation(oContainer), oContainer);
            i--;
//            if (i < 1) i = 1;
            SetCampaignInt(dbase, chest + "size", i);
            SetLocalInt(oContainer, chest + "size", i);
            SetLocalObject(oContainer, chest + IntToString(index), oItem);
            StoreCampaignObject(dbase, chest + IntToString(index), oItem);
            DestroyObject(oItem);
        }
        else
        {
            DeleteCampaignVariable(dbase, chest + IntToString(i));
            i--;
            SetCampaignInt(dbase, chest + "size", i);
            SetLocalInt(oContainer, chest + "size", i);
        }
        if (iDebug) herDebug("Size Variable: " + IntToString(i));
    }
}


/*This function exists to add items into a database for a container, if
there is no database so far, it will be created as soon as an item is placed
in the container */
void AddItem(object oItem, object oContainer)
{
    if (iDebug) herDebug("I have been disturbed");
    int i = 0;
    int index = 0;
    vector chestposition = GetPosition(oContainer);
    string chest = PlaceableString(oContainer);
    string dbase = GetName(GetModule());
    if(GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED)
    {
        i = GetCampaignInt(dbase, chest + "size");
        i++;
        if (i < 1) i = 1;
        if (iDebug) herDebug(IntToString(i));
        SetCampaignInt(dbase, chest + "size", i);
        SetLocalInt(oContainer, chest + "size", i);
        SetLocalObject(oContainer, chest + IntToString(i), oItem);
        SetLocalObject(oItem, "ownercontainer", oContainer);
        i = GetCampaignInt(dbase, chest + "size");
        if (iDebug) herDebug("campaign stored size variable: " + IntToString(i));
        SetLocalInt(oItem, "index", i);
        int iCheck = StoreCampaignObject(dbase, chest + IntToString(i), oItem);
        if(iDebug && !iCheck)
        herDebug("Failed to store object");

        if (iDebug) herDebug(GetName(oItem));
    }

}

/* This function exists to remove an item from the database of the container
that called the function, it reshuffles the last item in the database to the
slot formerly occupied by the removed item, and then cleans up that database
slot afterwards*/
void DelIndexItem(int index, object oContainer)
{
    if (iDebug) herDebug("Deleting item by index reference");
    int i = 0;
    object oItem;
    object lItem;
    vector chestposition = GetPosition(oContainer);
    string chest = PlaceableString(oContainer);
    string dbase = GetName(GetModule());
    i = GetCampaignInt(dbase, chest + "size");
    if (iDebug) herDebug("Size was: " + IntToString(i));
    lItem = GetLocalObject(oContainer, chest + IntToString(i));
    oItem = RetrieveCampaignObject(dbase, chest + IntToString(i), GetLocation(oContainer), oContainer);
    i--;
    if (i < 1) i = 1;
    SetCampaignInt(dbase, chest + "size", i);
    if (iDebug) herDebug("Size is now: " + IntToString(i));
    SetLocalInt(oContainer, chest + "size", i);
    SetLocalObject(oContainer, chest + IntToString(index), oItem);
    StoreCampaignObject(dbase, chest + IntToString(index), oItem);
    DestroyObject(oItem);
}


string PlaceableString (object oContainer)
{
    vector chestposition = GetPosition(oContainer);
    string x = FloatToString(chestposition.x, 0,3);
    string y = FloatToString(chestposition.y,0,3);
    string scramblestring = GetTag(GetArea(oContainer))
            + x
            + y;
    if (iDebug) herDebug("The x position of chest is : " + x);
    if (iDebug) herDebug("The y position of chest is : " + y);
    if (iDebug) herDebug("The x portion of the string should be " + GetStringLeft(x, 6));
    if (iDebug) herDebug("The y portion of the string should be " + GetStringLeft(y, 6));
    if (iDebug) herDebug("ScrambleString for this container is: " + scramblestring + " or should be");
    return scramblestring;
}


