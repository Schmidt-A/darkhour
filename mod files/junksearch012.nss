//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFoundSomething = FALSE;
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

    if (nFound < 400)
    {
       sWhat = "blessedbullets";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 800)
    {
       sWhat = "blessedarrow";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 1200)
    {
       sWhat = "blessedbolt";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 1300)
    {
       sWhat = "holybook";
    }
    else if (nFound < 1310)
    {
       sWhat = "gemofvalor";
    }
    else if (nFound < 1320)
    {
       sWhat = "gemofcorruption";
    }
    else if (nFound < 1330)
    {
       sWhat = "gemofshadow";
    }
    else if (nFound < 1500)
    {
       sWhat = "nw_it_mglove003";
    }
    else if (nFound < 1800)
    {
       sWhat = "tempstaff";
    }
    else if (nFound < 1825)
    {
        sWhat = "nw_it_spdvscr501";   // this is a raise dead
    }
    else if (nFound < 2250)
    {
        sWhat = "us_arrow";
    }
    else if (nFound < 2450)
    {
        sWhat = "us_bolt";
    }
    else if (nFound < 2650)
    {
        sWhat = "shamrock";
    }
    else if (nFound < 2900)
    {
        sWhat = "nw_it_mpotion002";     // potion of cure serious wounds
    }
    else if (nFound < 2925)
    {
        sWhat = "artifactpiece";   // Artifact Piece 1/4
    }
    else if (nFound < 2950)
    {
        sWhat = "artifactpiece001";   // Artifact Piece 2/4
    }
    else if (nFound < 2975)
    {
        sWhat = "artifactpiece002";   // Artifact Piece 3/4
    }
    else if (nFound < 3200)
    {
        sWhat = "sirandatea";
    }
    else if (nFound < 3700)
    {
        sWhat = "mw_05"; // masterwork dagger
    }
    else if (nFound < 4000)
    {
       sWhat = "nw_it_gold001";
       nAmount = Random(30) + 80;
    }
    else if (nFound < 4500)
    {
       sWhat = "mw_01"; // masterwork shortbow
    }
    else if (nFound < 5000)
    {
       sWhat = "mw_02"; // masterwork longbow
    }
    else if (nFound < 5500)
    {
       sWhat = "mw_09"; // masterwork battleaxe
    }
    else if (nFound < 6000)
    {
       sWhat = "mw_14"; // masterwork club
    }
    else if (nFound < 6500)
    {
       sWhat = "mw_03";
    }
    else if (nFound < 7500)
    {
       sWhat = "mw_04";
    }
    else if (nFound < 8000)
    {
       sWhat = "mw_10";
    }
    else if (nFound < 8200)
    {
       sWhat = "fortiplate";
    }
    else if (nFound < 8400)
    {
       sWhat = "wintershield1";
    }
    else if (nFound < 8700)
    {
       sWhat = "waybread";
    }
    else if (nFound < 9000)
    {
       sWhat = "bootsquick";
    }
    else if (nFound < 9200)
    {
       sWhat = "eyesrevealing";
    }
    else if (nFound < 9400)
    {
       sWhat = "thhcloak";
    }
    else if (nFound < 9700)
    {
       sWhat = "odakerplate";
    }
    else if (nFound < 9800)
    {
       sWhat = "Potions";
    }
    else if (nFound < 10000)
    {
       sWhat = "po_gelix";
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
