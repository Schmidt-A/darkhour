//
//  junksearch001 -- Copy this script once for each different assortment of
//  junk you wish to put around in your module, and modify as necessary.
//

void main()
{
    int nFound = Random(100);
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

    if (nFound < 6)
    {  //Bullet +1
       sWhat = "nw_wammbu008";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 12)
    {  //Arrow +1
       sWhat = "nw_wammar009";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 18)
    {  //Bolt +1
       sWhat = "nw_wammbo008";
       nAmount = Random(15) + 5;
    }
    else if (nFound < 23)
    {  //Handaxe +1
       sWhat = "nw_waxmhn002";
    }
    else if (nFound < 28)
    {  //Short Sword +1
       sWhat = "nw_wswmss002";
    }
    else if (nFound < 33)
    {  //Club +1
       sWhat = "nw_wblmcl002";
    }
    else if (nFound < 38)
    {  //Quarterstaff +1
       sWhat = "nw_wdbmqs002";
    }
    else if (nFound < 40)
    {   //Shortbow+1
       sWhat = "nw_wbwmsh002";
    }
    else if (nFound < 42)
    {   //Light Crossbow +1
       sWhat = "nw_wbwmxl002";
    }
    else if (nFound < 44)
    {   //Spear +1
       sWhat = "nw_wplmss002";
    }
    else if (nFound < 47)
    {
       sWhat = "nw_wswmls002";
    }
    else if (nFound < 49)
    {
       sWhat = "nw_waxmbt002";
    }
    else if (nFound < 52)
    {
       sWhat = "nw_wblmml002";
    }
    else if (nFound < 54)
    {
       sWhat = "nw_wbwmxh002";
    }
    else if (nFound < 56)
    {
       sWhat = "nw_wbwmln002";
    }
    else if (nFound < 58)
    {
       sWhat = "nw_wplmhb002";
    }
    else if (nFound < 60)
    {
       sWhat = "nw_wbwmsl001";
    }
    else if (nFound < 62)
    {
       sWhat = "nw_wplmsc002";
    }
    else if (nFound < 65)
    {
       sWhat = "nw_wbwmsh002";
    }
    else if (nFound < 68)
    {
       sWhat = "nw_maarcl044";
    }
    else if (nFound < 71)
    {
       sWhat = "nw_ashmsw002";
    }
    else if (nFound < 74)
    {
       sWhat = "nw_maarcl035";
    }
    else if (nFound < 77)
    {
       sWhat = "nw_ashmlw002";
    }
    else if (nFound < 79)
    {
       sWhat = "nw_maarcl052";
    }
    else if (nFound < 81)
    {
       sWhat = "nw_ashmto002";
    }
    else if (nFound < 83)
    {
       sWhat = "zn_magicrobes";
    }
    else if (nFound < 88)
    {
       sWhat = "vaultkey";
    }
    else if (nFound < 90)
    {
       sWhat = "craftingpoints";
    }
    else
    {
       sWhat = "nw_it_gold001";
       nAmount = Random(101) + 100;
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
