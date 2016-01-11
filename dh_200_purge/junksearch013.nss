//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFound = Random(575) + 1;
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
       sWhat = "mw_01";
    }
    else if (nFound < 20)
    {
       sWhat = "mw_02";
    }
    else if (nFound < 30)
    {
       sWhat = "mw_03";
    }
    else if (nFound < 40)
    {
       sWhat = "mw_04";
    }
    else if (nFound < 50)
    {
       sWhat = "mw_05";
    }
    else if (nFound < 60)
    {
       sWhat = "mw_06";
    }
    else if (nFound < 70)
    {
       sWhat = "mw_07";
    }
    else if (nFound < 80)
    {
       sWhat = "mw_08";
    }
    else if (nFound < 90)
    {
       sWhat = "mw_09";
    }
    else if (nFound < 95)
    {
       sWhat = "gemofcorruption";
    }
    else if (nFound < 105)
    {
       sWhat = "mw_11";
    }
    else if (nFound < 115)
    {
       sWhat = "mw_12";
    }
    else if (nFound < 125)
    {
       sWhat = "mw_13";
    }
    else if (nFound < 135)
    {
       sWhat = "mw_14";
    }
    else if (nFound < 145)
    {
       sWhat = "mw_15";
    }
    else if (nFound < 150)
    {
       sWhat = "gemofvalor";
    }
    else if (nFound < 155)
    {
       sWhat = "gemofcorruption";
    }
    else if (nFound < 160)
    {
       sWhat = "gemofshadow";
    }
    else if (nFound < 165)
    {
       sWhat = "sirandatea";
    }
    else if (nFound < 170)
    {
       sWhat = "desolaterecall";
    }
    else if (nFound < 175)
    {
       sWhat = "nw_it_spdvscr501";// raise dead
    }
    else if (nFound < 180)
    {
       sWhat = "nw_it_mring001"; // ring prot+1
    }
    else if (nFound < 185)
    {
       sWhat = "shamrock";
    }
    else if (nFound < 190)
    {
        sWhat = "nw_it_mpotion008"; // invis
    }
    else if (nFound < 195)
    {
        sWhat = "nw_it_mpotion004"; // speed
    }
    else if (nFound < 200)
    {
        sWhat = "nw_it_mring025"; // ring fort +2
    }
    else if (nFound < 205)
    {
        sWhat = "nw_maarcl032"; // nymph cloak +1
    }
    else if (nFound < 210)
    {
        sWhat = "artifactpiece";   // Artifact Piece 1/4
    }
    else if (nFound < 215)
    {
        sWhat = "artifactpiece002";   // Artifact Piece 3/4
    }
    else if (nFound < 220)
    {
        sWhat = "us_arrow";
    }
    else if (nFound < 225)
    {
        sWhat = "us_bolt";
    }
    else if (nFound < 235)
    {
        sWhat = "sword_of_electri";
    }
    else if (nFound < 250)
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
    else if (nFound < 552)
    {
        sWhat = "artbreaker";
    }
    else if (nFound < 553)
    {
        sWhat = "axe_famine";
    }
    else if (nFound < 555)
    {
    ExecuteScript("randomorb", OBJECT_SELF);
    return;
    }
    else if (nFound < 556)
    {
        sWhat = "bracer_nocturn";
    }
    else if (nFound < 557)
    {
        sWhat = "runic_longsword";
    }
    else if (nFound < 558)
    {
        sWhat = "belt_padleather";
    }
    else if (nFound < 559)
    {
        sWhat = "boots_quickstep";
    }
    else if (nFound < 560)
    {
        sWhat = "cloak_identity";
    }
    else if (nFound < 561)
    {
        sWhat = "dubscim_exotic";
    }
    else if (nFound < 562)
    {
        sWhat = "dagger_backstab";
    }
    else if (nFound < 563)
    {
        sWhat = "club_ironwood";
    }
    else if (nFound < 564)
    {
        sWhat = "dart_volcanic";
        nAmount = d4();
    }
    else if (nFound < 565)
    {
        sWhat = "bullet_thunderclap";
        nAmount = d4();
    }
    else if (nFound < 566)
    {
        sWhat = "staff_wizardry";
    }
    else if (nFound < 567)
    {
        sWhat = "staff_sorcerory";
    }
    else if (nFound < 568)
    {
        sWhat = "staff_bold";
    }
    else if (nFound < 569)
    {
        sWhat = "ring_duality";
    }
    else if (nFound < 570)
    {
        sWhat = "trident_seas";
    }
    else if (nFound < 571)
    {
        sWhat = "amulet_bones";
    }
    else if (nFound < 572)
    {
        sWhat = "cloak_pranks";
    }
    else if (nFound < 575)
    {
        sWhat = "trump_card";
    }
    else if (nFound == 575)
    {
    int iChance = d3();
        if(iChance == 2)
            {
            ExecuteScript("randomuberwep", OBJECT_SELF);
            return;
            }
        else
            {
            sWhat = "shamrock";
            }
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
