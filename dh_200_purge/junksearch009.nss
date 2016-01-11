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

    if (nFound < 5)
    {
       sWhat = "ration";
    }
    else if (nFound < 20)
    {
       sWhat = "NW_WTHMDT008";
       nAmount = Random(20) + 10;
    }
    else if (nFound < 30)
    {
       sWhat = "craftingpoints";
    }
    else if (nFound < 40)
    {
       sWhat = "nw_it_medkit002";
    }
    else if (nFound < 50)
    {
       sWhat = "NW_WTHMDT008";
       nAmount = Random(20) + 10;
    }
    else if (nFound < 58)
    {
       sWhat = "NW_IT_MPOTION001";
    }
    else if (nFound < 62)
    {
       sWhat = "NW_WTHMAX008";
       nAmount = Random(20) + 10;
    }
    else if (nFound < 66)
    {
       sWhat = "nw_wammar010";
       nAmount = Random(15) + 6;
    }
    else if (nFound < 70)
    {
       sWhat = "nw_wammbo009";
       nAmount = Random(15) + 6;
    }
    else if (nFound < 74)
    {
       sWhat = "nw_wammbu009";
       nAmount = Random(15) + 6;
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
