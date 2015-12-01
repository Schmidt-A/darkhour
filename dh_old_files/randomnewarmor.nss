void main()
{
int iRand = Random(26) + 1;
object oItem;
string sFound;
if(iRand <= 1)
    {
    oItem = CreateItemOnObject("new_armor1", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 2)
    {
    oItem = CreateItemOnObject("new_armor2", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 3)
    {
    oItem = CreateItemOnObject("new_armor3", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 4)
    {
    oItem = CreateItemOnObject("new_armor4", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 5)
    {
    oItem = CreateItemOnObject("new_armor5", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 6)
    {
    oItem = CreateItemOnObject("new_armor6", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 7)
    {
    oItem = CreateItemOnObject("new_armor7", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 8)
    {
    oItem = CreateItemOnObject("new_armor8", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 9)
    {
    oItem = CreateItemOnObject("new_armor9", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 10)
    {
    oItem = CreateItemOnObject("new_armor10", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand ==11)
    {
    oItem = CreateItemOnObject("new_armor11", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 12)
    {
    oItem = CreateItemOnObject("new_armor12", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 13)
    {
    oItem = CreateItemOnObject("new_armor13", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 14)
    {
    oItem = CreateItemOnObject("new_armor14", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 15)
    {
    oItem = CreateItemOnObject("new_armor15", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 16)
    {
    oItem = CreateItemOnObject("new_armor16", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 17)
    {
    oItem = CreateItemOnObject("new_armor17", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 18)
    {
    oItem = CreateItemOnObject("bracer_sorc", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 19)
    {
    oItem = CreateItemOnObject("bracer_wiz", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 20)
    {
    oItem = CreateItemOnObject("bracer_div", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 21)
    {
    oItem = CreateItemOnObject("belt_supconc", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 22)
    {
    oItem = CreateItemOnObject("helm_illusions", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 23)
    {
    oItem = CreateItemOnObject("lshield_searing", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 24)
    {
    oItem = CreateItemOnObject("sshield_spellbreaker", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 25)
    {
    oItem = CreateItemOnObject("tshield_impenetrable", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
else if(iRand == 26)
    {
    oItem = CreateItemOnObject("sshield_soulless", OBJECT_SELF);
    SetIdentified(oItem, TRUE);
    sFound = "Found " + GetName(oItem);
    }
FloatingTextStringOnCreature("Found " + GetName(oItem), OBJECT_SELF, TRUE);
if(sFound == "Found ")
    {
    ExecuteScript("randomnewarmor", OBJECT_SELF);
    }
}
