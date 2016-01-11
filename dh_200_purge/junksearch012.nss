//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFoundSomething = FALSE;
    int nFound = Random(475) + 1;
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
       sWhat = "blessedbullets";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 20)
    {
       sWhat = "blessedarrow";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 30)
    {
       sWhat = "blessedbolt";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 33)
    {
       sWhat = "holybook";
    }
    else if (nFound < 37)
    {
       sWhat = "gemofvalor";
    }
    else if (nFound < 42)
    {
       sWhat = "gemofcorruption";
    }
    else if (nFound < 45)
    {
       sWhat = "gemofshadow";
    }
    else if (nFound < 50)
    {
       sWhat = "waybread";
    }
    else if (nFound < 55)
    {
       sWhat = "desolaterecall";    // Buggy script
    }
    else if (nFound < 60)
    {
        sWhat = "nw_it_spdvscr501";   // this is a raise dead
    }
    else if (nFound < 65)
    {
        sWhat = "us_arrow";
    }
    else if (nFound < 70)
    {
        sWhat = "us_bolt";
    }
    else if (nFound < 75)
    {
        sWhat = "shamrock";
    }
    else if (nFound < 80)
    {
        sWhat = "nw_it_mpotion002";     // potion of cure serious wounds
    }
    else if (nFound < 82)
    {
        sWhat = "artifactpiece";   // Artifact Piece 1/4
    }
    else if (nFound < 84)
    {
        sWhat = "artifactpiece001";   // Artifact Piece 2/4
    }
    else if (nFound < 86)
    {
        sWhat = "artifactpiece002";   // Artifact Piece 3/4
    }
    else if (nFound < 88)
    {
        sWhat = "sirandatea";
    }
    else if (nFound < 100)
    {
        sWhat = "sword_of_ice";
    }
    else if (nFound < 130)
    {
       sWhat = "nw_it_gold001";
       nAmount = Random(30) + 80;
    }
    else if (nFound < 250)
    {
    ExecuteScript("randomweapon", OBJECT_SELF);
    return;
    }
    else if (nFound < 450)
    {
    ExecuteScript("randomnewarmor", OBJECT_SELF);
    return;
    }
    else if (nFound < 452)
    {
        sWhat = "artbreaker";
    }
    else if (nFound < 453)
    {
        sWhat = "axe_famine";
    }
    else if (nFound < 455)
    {
    ExecuteScript("randomorb", OBJECT_SELF);
    return;
    }
    else if (nFound < 456)
    {
        sWhat = "bracer_nocturn";
    }
    else if (nFound < 457)
    {
        sWhat = "runic_longsword";
    }
    else if (nFound < 458)
    {
        sWhat = "belt_padleather";
    }
    else if (nFound < 459)
    {
        sWhat = "boots_quickstep";
    }
    else if (nFound < 460)
    {
        sWhat = "cloak_identity";
    }
    else if (nFound < 461)
    {
        sWhat = "dubscim_exotic";
    }
    else if (nFound < 462)
    {
        sWhat = "dagger_backstab";
    }
    else if (nFound < 463)
    {
        sWhat = "club_ironwood";
    }
    else if (nFound < 464)
    {
        sWhat = "dart_volcanic";
        nAmount = d4();
    }
    else if (nFound < 465)
    {
        sWhat = "bullet_thunderclap";
        nAmount = d4();
    }
    else if (nFound < 466)
    {
        sWhat = "staff_wizardry";
    }
    else if (nFound < 467)
    {
        sWhat = "staff_sorcerory";
    }
    else if (nFound < 468)
    {
        sWhat = "staff_bold";
    }
    else if (nFound < 469)
    {
        sWhat = "ring_duality";
    }
    else if (nFound < 470)
    {
        sWhat = "trident_seas";
    }
    else if (nFound < 471)
    {
        sWhat = "amulet_bones";
    }
    else if (nFound < 472)
    {
        sWhat = "cloak_pranks";
    }
    else if (nFound < 475)
    {
        sWhat = "trump_card";
    }
    else if (nFound == 475)
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
