//*************************************
//    Filename:  horse_closebags
/*
    Created by Barry_1066
    12/12/2006
*/
//*************************************

void main()
{
    object oPC = GetPCSpeaker();
    object oBag = GetLocalObject(oPC,"PC_Bag");

    object oItem = GetFirstItemInInventory(oBag);
    while( oItem != OBJECT_INVALID )
    {
        DestroyObject(oItem);

        oItem = GetNextItemInInventory(oBag);
    }

    DestroyObject(oBag);

    DeleteLocalInt(oPC,"PC_Saddle");
}
