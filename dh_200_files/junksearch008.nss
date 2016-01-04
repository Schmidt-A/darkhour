//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFound = Random(10000);
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

    if (nFound < 600)
    {
       sWhat = "shamrock";
    }
    else if (nFound < 1000)
    {
       sWhat = "nw_wdbmsw002"; // two bladed sword +1
    }
    else if (nFound < 1500)
    {
        sWhat = "us_bolt";
    }
    else if (nFound < 2000)
    {
       sWhat = "nw_wammar006"; // Lighting arrow
       nAmount = Random(15) + 15;
    }
    else if (nFound < 2600)
    {
        sWhat = "sirandatea";
    }
    else if (nFound < 3100)
    {
       sWhat = "NW_WAMMBO002"; //Bolt of some kind
       nAmount = Random(15) + 15;
    }
    else if (nFound < 3600)
    {
       sWhat = "blessedbolt";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 4100)
    {
       sWhat = "NW_WAMMBU007"; // Bullet of some kind
       nAmount = Random(15) + 15;
    }
    else if (nFound < 4700)
    {
       sWhat = "blessedarrow";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 5300)
    {
       sWhat = "nw_wdbmma002"; //Warmace +1
    }
    else if (nFound < 6200)
    {
       sWhat = "nw_wswmgs002"; // Greatsword +1
    }
    else if (nFound < 6210)
    {
       sWhat = "gemofcorruption";
    }
    else if (nFound < 6220)
    {
       sWhat = "gemofvalor";
    }
    else if (nFound < 6230)
    {
       sWhat = "gemofshadow";
    }
    else if (nFound < 6500)
    {
       sWhat = "lantern";
    }
    else if (nFound < 6525)
    {
        sWhat = "nw_it_spdvscr501"; // raise dead
    }
    else if (nFound < 6800)
    {
        sWhat = "nw_it_mpotion008";  // invis potion
    }
    else if (nFound < 7100)
    {
       sWhat = "nw_it_mpotion004";   // speed potion
    }
    else if (nFound < 7200)
    {
        sWhat = "sirandatea";
    }
    else if (nFound < 7500)
    {
       sWhat = "nw_it_mring001";   // ring of protection
    }
    else if (nFound < 7525)
    {
        sWhat = "artifactpiece001";   // Artifact Piece 2/4
    }
    else if (nFound < 7550)
    {
        sWhat = "artifactpiece003";   // Artifact Piece 4/4
    }
    else if (nFound < 7800)
    {
        sWhat = "nw_it_mboots001";  // boots of striding
    }
    else if (nFound < 8000)
    {
        sWhat = "shamrock";
    }
    else if (nFound < 8400)
    {
       sWhat = "nw_it_gold001";
       nAmount = Random(30) + 80;
    }
    else if (nFound < 8600)
    {
       sWhat = "it_mring007"; // ring of clear thought +1
    }
    else if (nFound < 8800)
    {
       sWhat = "baraleather";
    }
    else if (nFound < 9000)
    {
       sWhat = "farmerbow";
    }
    else if (nFound < 9250)
    {
       sWhat = "nw_it_mpotion005"; // barkskin
    }
    else if (nFound < 9500)
    {
       sWhat = "nw_it_mpotion010"; // eagle's splendor
    }
    else if (nFound < 9650)
    {
       sWhat = "ringsecondchance";
    }
    else if (nFound < 9800)
    {
       sWhat = "bootsquick";
    }
    else if (nFound < 10000)
    {
       sWhat = "leatherblending";
    }

    int DEBUG = GetLocalInt(GetModule(),"DEBUG_MODE");
    if(DEBUG)
        FloatingTextStringOnCreature("RESREF: "+sWhat,OBJECT_SELF,TRUE);
    //  Did the player find something?  If so, let them know and create it.
    //  If not, tell them they found nothing.

    object oTemp = CreateItemOnObject(sWhat,OBJECT_SELF,nAmount);
    SetIdentified(oTemp,TRUE);
    string sName = GetName(oTemp);
    if(sName == "")
    {
        FloatingTextStringOnCreature("Found Nothing",OBJECT_SELF,TRUE);
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
