void main()
{
int iRand = Random(5) + 1;
object oItem;
string sFound;
if(iRand <= 1)
    {
    oItem = CreateItemOnObject("uberblade", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    return;
    }
else if(iRand == 2)
    {
    oItem = CreateItemOnObject("uberbow", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 3)
    {
    oItem = CreateItemOnObject("uberdwaxe", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 4)
    {
    oItem = CreateItemOnObject("ls_grimjaws", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 5)
    {
    oItem = CreateItemOnObject("st_searing", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
if(sFound == "Found ")
    {
    ExecuteScript("randomuberwep", OBJECT_SELF);
    return;
    }
FloatingTextStringOnCreature(sFound, OBJECT_SELF, TRUE);
}
