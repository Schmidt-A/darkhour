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

    if (nFound < 400)
    {
       sWhat = "mw_01"; // Mw shortbow
    }
    else if (nFound < 800)
    {
       sWhat = "mw_02"; // Mw longbow
    }
    else if (nFound < 1200)
    {
       sWhat = "mw_03"; // Mw kama
    }
    else if (nFound < 1600)
    {
       sWhat = "mw_04"; // Mw nunchaku
    }
    else if (nFound < 2000)
    {
       sWhat = "mw_05"; // Mw dagger
    }
    else if (nFound < 2400)
    {
       sWhat = "mw_06"; // Mw longsword
    }
    else if (nFound < 2800)
    {
       sWhat = "mw_07"; // Mw shortsword
    }
    else if (nFound < 3200)
    {
       sWhat = "mw_08"; // Mw mace
    }
    else if (nFound < 3600)
    {
       sWhat = "mw_09"; // Mw battleaxe
    }
    else if (nFound < 4000)
    {
       sWhat = "mw_11"; // Mw handaxe
    }
    else if (nFound < 4400)
    {
       sWhat = "mw_12"; // Mw spear
    }
    else if (nFound < 4800)
    {
       sWhat = "mw_13"; // Mw halberd
    }
    else if (nFound < 5200)
    {
       sWhat = "mw_14"; // Mw club
    }
    else if (nFound < 5600)
    {
       sWhat = "mw_15"; // Mw bastard sword
    }
    else if (nFound < 5650)
    {
       sWhat = "gemofvalor";
    }
    else if (nFound < 5675)
    {
       sWhat = "gemofcorruption";
    }
    else if (nFound < 5700)
    {
       sWhat = "gemofshadow";
    }
    else if (nFound < 5900)
    {
       sWhat = "sirandatea";
    }
    else if (nFound < 5925)
    {
       sWhat = "nw_it_spdvscr501";// raise dead
    }
    else if (nFound < 6060)
    {
       sWhat = "nw_it_mring001"; // ring prot+1
    }
    else if (nFound < 6260)
    {
       sWhat = "shamrock";
    }
    else if (nFound < 6460)
    {
        sWhat = "nw_it_mpotion008"; // invis
    }
    else if (nFound < 6660)
    {
        sWhat = "nw_it_mpotion004"; // speed
    }
    else if (nFound < 6950)
    {
        sWhat = "nw_it_mring025"; // ring fort +2
    }
    else if (nFound < 7150)
    {
        sWhat = "nw_maarcl031"; // nymph cloak +1
    }
    else if (nFound < 7170)
    {
        sWhat = "artifactpiece";   // Artifact Piece 1/4
    }
    else if (nFound < 7190)
    {
        sWhat = "artifactpiece002";   // Artifact Piece 3/4
    }
    else if (nFound < 7390)
    {
        sWhat = "us_arrow";
    }
    else if (nFound < 7590)
    {
        sWhat = "us_bolt";
    }
    else if (nFound < 8000)
    {
       sWhat = "nw_it_gold001";
       nAmount = Random(30) + 80;
    }
    else if (nFound < 8100)
    {
       sWhat = "kalaramplate";
    }
    else if (nFound < 8200)
    {
       sWhat = "regcloak";
    }
    else if (nFound < 8500)
    {
       sWhat = "nw_it_medkit002"; // Healer's kit +3
    }
    else if (nFound < 8900)
    {
       sWhat = "nw_it_mglove016"; // Gloves of hin fist +1
    }
    else if (nFound < 9300)
    {
       sWhat = "nw_wblmfl002"; // Light flail +1
    }
    else if (nFound < 9500)
    {
       sWhat = "NW_MCLOTH018"; // Robe shining hand +1
    }
    else if (nFound < 9600)
    {
       sWhat = "NW_ASHMSW002"; // Small shield +1
    }
    else if (nFound < 9650)
    {
       sWhat = "akadianring";
    }
    else if (nFound < 9750)
    {
       sWhat = "robeethereal";
    }
    else if (nFound < 9900)
    {
       sWhat = "potions002";
    }
    else if (nFound < 10000)
    {
       sWhat = "po_fungus";
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
