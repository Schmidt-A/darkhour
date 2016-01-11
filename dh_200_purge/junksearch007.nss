//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFound = Random(83);
    string sWhat = "";
    int nAmount = 1;
    if(GetLocalInt(GetObjectByTag("debuglever"), "debug") == 1)
        {
        SendMessageToPC(OBJECT_SELF, "Debug mode is active, you have rolled a " + IntToString(nFound));
        }
    //  The numbers checked against nFound below are the percent chances that
    //  something useful is found (minus the previous check.  In the example,
    //  there is a 25% chance that a dagger is found, a 10% chance (35 - 25)
    //  that sling bullets are found, a 10% chance (45 - 35) that arrows are
    //  found, and a 5% chance (50 - 45) that bolts are found.  There is a rare
    //  1% chance (51 - 50) that a longsword is found.  The leftover amount
    //  from 100 gives a 49% chance (100 - 51) that nothing at all is
    //  found during the search.
    //
    //  To modify, set sWhat to the object to find, and if it has a stack
    //  size (such as the arrows), set nAmount to how much they find.  Make
    //  sure to set nFoundSomething to TRUE; this makes sure that the player
    //  is informed that they found something, and also to create the item
    //  they found on them.

    if (nFound < 4)
    {
       sWhat = "NW_WAMMBU009";
       nAmount = Random(20) + 10;
    }
    else if (nFound < 8)
    {
       sWhat = "NW_WAMMAR010";
       nAmount = Random(20) + 10;
    }
    else if (nFound < 12)
    {
       sWhat = "NW_WAMMBO009";
       nAmount = Random(20) + 10;
    }
    else if (nFound < 16)
    {
       sWhat = "nw_wbwxh001";
    }
    else if (nFound < 20)
    {
       sWhat = "nw_wbwln001";
    }
    else if (nFound < 24)
    {
       sWhat = "nw_wplhb001";
    }
    else if (nFound < 28)
    {
       sWhat = "nw_wswbs001";
    }
    else if (nFound < 34)
    {
       sWhat = "nw_wplss001";
    }
    else if (nFound < 38)
    {
       sWhat = "nw_ashsw001";
    }
    else if (nFound < 42)
    {
       sWhat = "nw_ashlw001";
    }
    else if (nFound < 46)
    {
       sWhat = "nw_ashto001";
    }
    else if (nFound < 50)
    {
       sWhat = "nw_arhe001";
    }
    else if (nFound < 54)
    {
       sWhat = "nw_arhe004";
    }
    else if (nFound < 60)
    {
       sWhat = "craftingpoints";
    }
    else if (nFound < 62)
    {
       sWhat = "nw_aarcl006";
    }
    else if (nFound < 65)
    {
       sWhat = "NW_WAMMAR010";
       nAmount = Random(15) + 3;
    }
    else if (nFound < 67)
    {
       sWhat = "NW_WAMMBO009";
       nAmount = Random(15) + 3;
    }
    else if (nFound < 69)
    {
       sWhat = "NW_WAMMBU009";
       nAmount = Random(15) + 3;
    }
    else if (nFound < 71)
    {
       sWhat = "nw_wdbax001";
    }
    else if (nFound < 74)
    {
       sWhat = "nw_wswka001";
    }
    else if (nFound < 79)
    {
       sWhat = "vaultkey";
    }
    else if (nFound < 80)
    {
       sWhat = "sirandaherb";
    }
    else
    {
       sWhat = "ringoftelepathic";
    }

    //  Did the player find something?  If so, let them know and create it.
    //  If not, tell them they found nothing.

    object oTemp = CreateItemOnObject(sWhat,OBJECT_SELF,nAmount);
    SetIdentified(oTemp,TRUE);
    string sName = GetName(oTemp);
    if (sWhat == "nw_it_gold001")
    {
        FloatingTextStringOnCreature("Found Gold",OBJECT_SELF,TRUE);
    }
    else
    {
        FloatingTextStringOnCreature("Found " + sName,OBJECT_SELF,TRUE);
    }
}
