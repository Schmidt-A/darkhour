/*  This is the function that does most of the storage work.  Basically there's
and array of slots for each chest and they are flagged as occupied (an item is
stored there, or unoccupied and they don't hold an item, so there's a parallel
database variable int set up to coincide with the actual stored campaign object.
I had to do this because there was no way to keep track of the objects in the
database without actually recreating them oddly enough.  This works though,
when a new object is placed in a container it searches for an unflagged spot to
store the item in the database and if it finds one it only does a single database
write which is alot more computer friendly than doing a dump of the entire invo
at once. */

#include "her_persist_inc"


void main()
{
    object oItem = GetInventoryDisturbItem();
    object oPC = GetLastDisturbed();
    //SpeakString(GetName(oPC));
    if(GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED && oPC != OBJECT_INVALID)
    {
        AddItem(oItem, OBJECT_SELF);
        //SpeakString("Adding Item");
    }
    if(GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED && oPC != OBJECT_INVALID)
    {
        DelItem(oItem, OBJECT_SELF);
        //SpeakString("Deleting Item");
    }
}
