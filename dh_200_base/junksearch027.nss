//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFound = Random(60);
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

    if (nFound < 8)
    {
       sWhat = "it_mglove008";
    }
    else if (nFound < 16)
    {
       sWhat = "ringofshadow";
    }
    else if (nFound < 17)
    {
       sWhat = "it_mpotion005";
    }
    else if (nFound < 18)
    {
       sWhat = "it_trap007";
    }
    else if (nFound < 19)
    {
       sWhat = "it_trap031";
    }
    else if (nFound < 20)
    {
       sWhat = "it_trap003";
    }
    else if (nFound < 21)
    {
       sWhat = "raggedcloak";
    }
    else if (nFound < 22)
    {
       sWhat = "it_spdvscr202";
    }
    else if (nFound < 23)
    {
       sWhat = "it_sparscr221";
    }
    else if (nFound < 24)
    {
       sWhat = "it_spdvscr408";
    }
    else if (nFound < 25)
    {
       sWhat = "it_sparscr206";
    }
    else if (nFound < 26)
    {
       sWhat = "it_spdvscr203";
    }
    else if (nFound < 27)
    {
       sWhat = "it_sparscr207";
    }
    else if (nFound < 28)
    {
       sWhat = "mcloth019";
    }
    else if (nFound < 29)
    {
       sWhat = "wswbs002";
    }
    else if (nFound < 30)
    {
       sWhat = "it_gem007";
    }
    else if (nFound < 31)
    {
       sWhat = "darkhelmet";
    }
    else if (nFound < 32)
    {
       sWhat = "buckler0";
    }
    else if (nFound < 33)
    {
       sWhat = "roundshield";
    }
    else if (nFound < 34)
    {
       sWhat = "aarcl015";
    }
    else if (nFound < 34)
    {
       sWhat = "aarcl015";
    }
    else if (nFound < 35)
    {
       sWhat = "wammbo009";
    }
    else if (nFound < 36)
    {
       sWhat = "wdbmsw004";
    }
    else if (nFound < 37)
    {
       sWhat = "it_mglove017";
    }
    else if (nFound < 38)
    {
       sWhat = "islayshortblade";
    }
    else if (nFound < 39)
    {
       sWhat = "it_mglove008";
    }
    else if (nFound < 43)
    {
       sWhat = "baroquestaff";
    }
    else if (nFound < 44)
    {
       sWhat = "piratescutlass";
    }
    else if (nFound < 48)
    {
       sWhat = "islaydiandagger";
    }
    else if (nFound < 48)
    {
       sWhat = "skipperssinglet";
    }
    else
    {
        sWhat = "sailorsboots";
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
