//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFound = Random(55);
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

    if (nFound < 10)
    {
        sWhat = "NW_WBWXL001";

    }
    else if (nFound < 15)
    {
        sWhat = "NW_WBWSH001";
    }
    else if (nFound < 25)
    {
        sWhat = "MarketCrossbow";

    }
    else if (nFound < 35)
    {
        sWhat = "NW_WAMBO001";
    }
    else if (nFound < 40)
    {
        sWhat = "NW_WAMBO001";

    }
    else if (nFound < 41)
    {    //Club
        sWhat = "NW_WBWLN001";
    }
    else if (nFound < 42)
    {
        sWhat = "NW_WAMBO001";
    }
    else
    {
        int nBookNum = Random(10) + 1;
        if (nBookNum > 9)
        {
            sWhat = "NW_WAMBO001" + IntToString(nBookNum);
        }
        else
        {
            sWhat = "NW_WAMAR001" + IntToString(nBookNum);
        }
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
        int DEBUG = GetLocalInt(GetModule(),"DEBUG_MODE");
    if(DEBUG)
        FloatingTextStringOnCreature("RESREF: "+sWhat,OBJECT_SELF,TRUE);
}
