//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFound = Random(90);
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

    if (nFound < 3)
    {
        int nChoice = Random(28) + 1;
        string sClothing;
        if (nChoice < 10)
        {
            sWhat = "nw_cloth00" + IntToString(nChoice);
        }
        else
        {
            sWhat = "nw_cloth0" + IntToString(nChoice);
        }
    }
    else if (nFound < 20)
    {
       sWhat = "nw_it_gold001";
       nAmount = Random(20) + 10;
    }
    else if (nFound < 21)
    {
       sWhat = "x2_it_dyec23";
    }
    else if (nFound < 22)
    {
       sWhat = "x2_it_dyec00";
    }
    else if (nFound < 23)
    {
       sWhat = "x2_it_dyec02";
    }
    else if (nFound < 24)
    {
       sWhat = "x2_it_dyec25";
    }
    else if (nFound < 25)
    {
       sWhat = "x2_it_dyec48";
    }
    else if (nFound < 26)
    {
       sWhat = "x2_it_dyec44";
    }
    else if (nFound < 27)
    {
       sWhat = "x2_it_dyec35";
    }
    else if (nFound < 28)
    {
       sWhat = "x2_it_dyec37";
    }
    else if (nFound < 29)
    {
       sWhat = "x2_it_dyec29";
    }
    else if (nFound < 30)
    {
       sWhat = "x2_it_dyec33";
    }
    else if (nFound < 31)
    {
       sWhat = "x2_it_dyec26";
    }
    else if (nFound < 32)
    {
       sWhat = "x2_it_dyec31";
    }
    else if (nFound < 33)
    {
       sWhat = "x2_it_dyec20";
    }
    else if (nFound < 34)
    {
       sWhat = "x2_it_dyec34";
    }
    else if (nFound < 35)
    {
       sWhat = "x2_it_dyec36";
    }
    else if (nFound < 36)
    {
       sWhat = "x2_it_dyec28";
    }
    else if (nFound < 37)
    {
       sWhat = "x2_it_dyec39";
    }
    else if (nFound < 38)
    {
       sWhat = "x2_it_dyec41";
    }
    else if (nFound < 39)
    {
       sWhat = "x2_it_dyec32";
    }
    else if (nFound < 40)
    {
       sWhat = "x2_it_dyel23";
    }
    else if (nFound < 41)
    {
       sWhat = "x2_it_dyel00";
    }
    else if (nFound < 42)
    {
       sWhat = "x2_it_dyel25";
    }
    else if (nFound < 43)
    {
       sWhat = "x2_it_dyel02";
    }
    else if (nFound < 44)
    {
       sWhat = "x2_it_dyel48";
    }
    else if (nFound < 45)
    {
       sWhat = "x2_it_dyel44";
    }
    else if (nFound < 46)
    {
       sWhat = "x2_it_dyel35";
    }
    else if (nFound < 47)
    {
       sWhat = "x2_it_dyel37";
    }
    else if (nFound < 48)
    {
       sWhat = "x2_it_dyel29";
    }
    else if (nFound < 49)
    {
       sWhat = "x2_it_dyel33";
    }
    else if (nFound < 50)
    {
       sWhat = "x2_it_dyel26";
    }
    else if (nFound < 51)
    {
       sWhat = "x2_it_dyel31";
    }
    else if (nFound < 52)
    {
       sWhat = "x2_it_dyel20";
    }
    else if (nFound < 53)
    {
       sWhat = "x2_it_dyel34";
    }
    else if (nFound < 54)
    {
       sWhat = "x2_it_dyel36";
    }
    else if (nFound < 55)
    {
       sWhat = "x2_it_dyel28";
    }
    else if (nFound < 56)
    {
       sWhat = "x2_it_dyel39";
    }
    else if (nFound < 57)
    {
       sWhat = "x2_it_dyel41";
    }
    else if (nFound < 58)
    {
       sWhat = "x2_it_dyel32";
    }
    else if (nFound < 59)
    {
       sWhat = "x2_it_dyem03";
    }
    else if (nFound < 60)
    {
       sWhat = "x2_it_dyem00";
    }
    else if (nFound < 61)
    {
       sWhat = "x2_it_dyem31";
    }
    else if (nFound < 62)
    {
       sWhat = "x2_it_dyem16";
    }
    else if (nFound < 63)
    {
       sWhat = "x2_it_dyem40";
    }
    else if (nFound < 64)
    {
       sWhat = "x2_it_dyem28";
    }
    else if (nFound < 65)
    {
       sWhat = "x2_it_dyem24";
    }
    else if (nFound < 66)
    {
       sWhat = "x2_it_dyem32";
    }
    else if (nFound < 67)
    {
       sWhat = "x2_it_dyem18";
    }
    else if (nFound < 68)
    {
       sWhat = "x2_it_dyem10";
    }
    else if (nFound < 69)
    {
       sWhat = "x2_it_dyem42";
    }
    else if (nFound < 70)
    {
       sWhat = "x2_it_dyem02";
    }
    else if (nFound < 71)
    {
       sWhat = "x2_it_dyem25";
    }
    else if (nFound < 72)
    {
       sWhat = "x2_it_dyem37";
    }
    else if (nFound < 73)
    {
       sWhat = "x2_it_dyem08";
    }
    else if (nFound < 74)
    {
       sWhat = "x2_it_dyem36";
    }
    else if (nFound < 75)
    {
       sWhat = "x2_it_dyem48";
    }
    else if (nFound < 85)
    {
       sWhat = "craftingpoints";
    }
    else
    {
       sWhat = "craftingpoints";
    }
    int DEBUG = GetLocalInt(GetModule(),"DEBUG_MODE");
    if(DEBUG)
        FloatingTextStringOnCreature("RESREF: "+sWhat,OBJECT_SELF,TRUE);
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
