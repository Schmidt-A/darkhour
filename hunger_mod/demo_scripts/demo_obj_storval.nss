// Name     : Demo store object
// Purpose  : Store objects in the database
// Authors  : Ingmar Stieger
// Modified : January 1st, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    int iItem;
    object oChest = GetObjectByTag("Chest1");
    object oItem = GetFirstItemInInventory(oChest);

    while (GetIsObjectValid(oItem))
    {
        SetPersistentObject(oChest, "Item_" + IntToString(iItem), oItem);
        oItem = GetNextItemInInventory(oChest);
        iItem++;
    }

    SendMessageToPC(GetFirstPC(), "Stored " + IntToString(iItem) + " objects in database.");
}

