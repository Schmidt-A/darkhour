// Name     : Demo load value
// Purpose  : Load a value from the database
// Authors  : Ingmar Stieger
// Modified : January 1st, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    int iItem;
    int bContinue = TRUE;
    object oCreated;
    object oChest1 = GetObjectByTag("Chest1");
    object oChest2 = GetObjectByTag("Chest2");

    /* Method 1: GetPersistentObject
     *
     * Use this method for simplicity.

    while (bContinue)
    {
        oCreated = GetPersistentObject(oChest1, "Item_" + IntToString(iItem), oChest2);
        if (!GetIsObjectValid(oCreated))
            bContinue = FALSE;
        else
            iItem++;
    }
    */

    /* Method 2: Loop over resultset
     *
     * Use this method if you need the flexibility of SQL resultsets
    */

    string sSQL = "SELECT val FROM pwobjdata WHERE player='~'" +
        "AND tag='" + GetTag(oChest1) + "'";
    SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);

    // The first call to RCO executes the SQL query and returns the first row.
    oCreated = RetrieveCampaignObject ("NWNX", "-", GetLocation(oChest2), oChest2);
    while (GetIsObjectValid(oCreated))
    {
        // "FETCHMODE" tells RCO to not execute the SQL statement again, but to
        // just advance to the next row in the resultset
        oCreated = RetrieveCampaignObject("NWNX", "FETCHMODE", GetLocation(oChest2), oChest2);
        iItem++;
    }


    SendMessageToPC(GetFirstPC(), "Retrieved " + IntToString(iItem) + " objects from database.");
}
