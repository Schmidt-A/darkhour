//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFound = Random(549) + 1;
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
       sWhat = "shamrock";
    }
    else if (nFound < 20)
    {
       sWhat = "nw_wdbmsw002";
    }
    else if (nFound < 25)
    {
        sWhat = "us_bolt";
    }
    else if (nFound < 35)
    {
       sWhat = "nw_wammar006";
       nAmount = Random(15) + 15;
    }
    else if (nFound < 50)
    {
       sWhat = "NW_WAMMBO002";
       nAmount = Random(15) + 15;
    }
    else if (nFound < 70)
    {
       sWhat = "blessedbolt";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 80)
    {
       sWhat = "NW_WAMMBU007";
       nAmount = Random(15) + 15;
    }
    else if (nFound < 100)
    {
       sWhat = "blessedarrow";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 110)
    {
       sWhat = "nw_wdbmma002";
    }
    else if (nFound < 120)
    {
        sWhat = "sword_of_ice";
    }
    else if (nFound < 130)
    {
       sWhat = "nw_wswmgs002";
    }
    else if (nFound < 150)
    {
       sWhat = "lantern";
    }
    else if (nFound < 165)
    {
        sWhat = "nw_it_mpotion008";  // invis potion
    }
    else if (nFound < 170)
    {
       sWhat = "nw_it_mpotion004";   // speed potion
    }
    else if (nFound < 180)
    {
       sWhat = "nw_it_mring001";   // ring of protection
    }
    else if (nFound < 181)
    {
        sWhat = "artifactpiece001";   // Artifact Piece 2/4
    }
    else if (nFound < 182)
    {
        sWhat = "artifactpiece003";   // Artifact Piece 4/4
    }
    else if (nFound < 186)
    {
        sWhat = "nw_it_mboots001";  // boots of striding
    }
    else if (nFound < 195)
    {
        sWhat = "sword_of_acid";
    }
    else if (nFound < 225)
    {
       sWhat = "nw_it_gold001";
       nAmount = Random(30) + 80;
    }
    else if (nFound < 450)
    {
    ExecuteScript("randomweapon", OBJECT_SELF);
    return;
    }
    else if (nFound < 550)
    {
    ExecuteScript("randomnewarmor", OBJECT_SELF);
    return;
    }
        //  Did the player find something?  If so, let them know and create it.
    //  If not, tell them they found nothing.

    object oTemp = CreateItemOnObject(sWhat,OBJECT_SELF,nAmount);
    SetIdentified(oTemp,TRUE);
    string sName = GetName(oTemp);
    if(sName == "")
    {
    CreateItemOnObject("shamrock", OBJECT_SELF);
    return;
    }
    if (sWhat == "nw_it_gold001")
    {
        FloatingTextStringOnCreature("Found Gold",OBJECT_SELF,TRUE);
    }
    else
    {
        FloatingTextStringOnCreature("Found " + sName,OBJECT_SELF,TRUE);
    }
}
