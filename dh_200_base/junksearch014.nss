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


    if (nFound < 200)
    {
       sWhat = "blessedbullets";
       nAmount = Random(5) + 5;
    }
    else if (nFound < 400)
    {
       sWhat = "blessedarrow";
       nAmount = Random(5) + 5;
    }
    else if (nFound < 600)
    {
       sWhat = "blessedbolt";
       nAmount = Random(5) + 5;
    }
    else if (nFound < 800)
    {
       sWhat = "nw_wdbmsw002"; // two-bladed sword +1
    }
    else if (nFound < 1000)
    {
       sWhat = "NW_WAMMAR002"; // fire arrow
       nAmount = Random(5) + 5;
    }
    else if (nFound < 1200)
    {
       sWhat = "NW_WAMMBO005"; // bold of fire?
       nAmount = Random(5) + 5;
    }
    else if (nFound < 1400)
    {
       sWhat = "NW_WAMMBU005"; // bullet of fire?
       nAmount = Random(5) + 5;
    }
    else if (nFound < 1600)
    {
       sWhat = "nw_wdbmma002"; //warmace +1
    }
    else if (nFound < 1900)
    {
       sWhat = "mw_01"; // masterwork shortbow
    }
    else if (nFound < 2200)
    {
       sWhat = "mw_02"; // masterwork longbow
    }
    else if (nFound < 2500)
    {
       sWhat = "mw_03"; // masterwork kama
    }
    else if (nFound < 2800)
    {
       sWhat = "mw_04"; // masterwork nunchaku
    }
    else if (nFound < 3100)
    {
       sWhat = "mw_05"; // masterwork dagger
    }
    else if (nFound < 3400)
    {
       sWhat = "mw_06"; // masterwork longsword
    }
    else if (nFound < 3700)
    {
       sWhat = "mw_07"; //masterwork shortsword
    }
    else if (nFound < 4000)
    {
       sWhat = "mw_08"; //masterwork mace
    }
    else if (nFound < 4300)
    {
       sWhat = "mw_09"; //masterwork battleaxe
    }
    else if (nFound < 4600)
    {
       sWhat = "mw_10"; //masterwork something
    }
    else if (nFound < 4900)
    {
       sWhat = "mw_11"; //masterwork handaxe
    }
    else if (nFound < 5200)
    {
       sWhat = "mw_12"; //masterwork spear
    }
    else if (nFound < 5500)
    {
       sWhat = "mw_13"; //masterwork halberd
    }
    else if (nFound < 5800)
    {
       sWhat = "mw_14"; //masterwork club
    }
    else if (nFound < 6100)
    {
       sWhat = "mw_15"; //masterwork bastard sword
    }
    else if (nFound < 6110)
    {
       sWhat = "gemofvalor";
    }
    else if (nFound < 6120)
    {
       sWhat = "gemofcorruption";
    }
    else if (nFound < 6130)
    {
       sWhat = "gemofshadow";
    }
    else if (nFound < 6330)
    {
       sWhat = "nw_wblmms002"; //morningstar +1
    }
    else if (nFound < 6480)
    {
       sWhat = "nw_it_mring025"; // ring fort +2
    }
    else if (nFound < 6505)
    {
       sWhat = "nw_it_spdvscr501"; // raise dead
    }
    else if (nFound < 6600)
    {
       sWhat = "us_arrow"; // undead slaying arrow
    }
    else if (nFound < 6700)
    {
       sWhat = "us_bolt"; // undead slaying bolt
    }
    else if (nFound < 6900)
    {
       sWhat = "sirandatea";
    }
    else if (nFound < 7050)
    {
       sWhat = "shamrock";
    }
    else if (nFound < 7200)
    {
       sWhat = "nw_it_mpotion002"; // potion cure serious wounds
    }
    else if (nFound < 7225)
    {
        sWhat = "artifactpiece";  // Artifact Piece 1/4
    }
    else if (nFound < 7250)
    {
        sWhat = "artifactpiece003";  // Artifact Piece 4/4
    }
    else if (nFound < 7350)
    {
        sWhat = "DextrousBelt"; // +1 Dex Belt
    }
    else if (nFound < 7500)
    {
        sWhat = "nw_it_mneck001"; // amulet of protection +1
    }
    else if (nFound < 7650)
    {
        sWhat = "kailenrobe";
    }
    else if (nFound < 7750)
    {
        sWhat = "ringofmight";
    }
    else if (nFound < 8050)
    {
       sWhat = "nw_it_gold001";
       nAmount = Random(30) + 80;
    }
   else if (nFound < 8200)
    {
       sWhat = "sptome1";
    }
   else if (nFound < 8300)
    {
       sWhat = "leathsilence";
    }
    else if (nFound < 8450)
    {
       sWhat = "nw_it_mbracer002";
    }
    else if (nFound < 8550)
    {
       sWhat = "legionwall";
    }
    else if (nFound < 8700)
    {
       sWhat = "ironstudcloak";
    }
    else if (nFound < 9000)
    {
       sWhat = "NW_WBWMSL001";
    }
    else if (nFound < 9050)
    {
      sWhat = "wfirewheel1";
    }
    else if (nFound < 9200)
    {
      sWhat = "ladyspearl";
    }
    else if (nFound < 9500)
    {
      sWhat = "sirandaherb";
    }
    else if (nFound < 9600)
    {
      sWhat = "lstone";
    }
    else if (nFound < 9700)
    {
      sWhat = "pebelt";
    }
    else if (nFound < 9750)
    {
      sWhat = "eyesbrillance";
    }
    else if (nFound < 9850)
    {
      sWhat = "nw_it_mpotion009";  // Potion of bless
    }
    else if (nFound < 10000)
    {
      sWhat = "nw_it_mpotion015";   // Bull's strength
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
