void main()
{
int iRand = d6();
object oItem;
string sFound;
if(iRand == 1)
    {
    oItem = CreateItemOnObject("orbofalacrity", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 2)
    {
    oItem = CreateItemOnObject("orbofstead", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 3)
    {
    oItem = CreateItemOnObject("orbofmight", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 4)
    {
    oItem = CreateItemOnObject("orbofintel", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 5)
    {
    oItem = CreateItemOnObject("orbofphilo", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 6)
    {
    oItem = CreateItemOnObject("orbofallur", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
FloatingTextStringOnCreature("Found " + GetName(oItem), OBJECT_SELF, TRUE);
if(sFound == "Found ")
    {
    ExecuteScript("randomorb", OBJECT_SELF);
    return;
    }
}
