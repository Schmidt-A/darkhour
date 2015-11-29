//Securable Location Spawner. Applies a +4 Bonus to Str, Dex, and Con to zombies (Not true, dis Naia, edited main zscripts, yo)
//Use in Sispara Securables -Only-. The other island will always have secured locations
void main()
{
    //PrintString("zombiecreator2: " + GetName(OBJECT_SELF) + " In: " + GetName(GetArea(OBJECT_SELF))); // Debug - find out wtf this script is called from
    int nZNum = 0;
    int nWNum = 0;
    string sWTag = GetLocalString(OBJECT_SELF,"wpt");
    int nZExpected = GetLocalInt(OBJECT_SELF,"noz");
    int nSafeTimer = GetLocalInt(OBJECT_SELF,"safetimer");
    if (nSafeTimer > 0)
    {
        nSafeTimer -= 1;
    }
    SetLocalInt(OBJECT_SELF,"safetimer",nSafeTimer);

    object oObj = GetFirstObjectInArea();
    while (oObj != OBJECT_INVALID)
    {
        if (GetStringLeft(GetTag(oObj),5) == "UndeadLizardfolk")
        {
            nZNum += 1;
        }
        else if (GetTag(oObj) == sWTag)
        {
            nWNum += 1;
        }
        oObj = GetNextObjectInArea();
    }

    if ((nZNum < nZExpected) && (nSafeTimer < 11))
    {
        if (nSafeTimer > 0)
        {
            oObj = GetObjectByTag(sWTag,Random(nWNum));
            location lSpot = GetLocation(oObj);
            int nWhich = Random(12);
            string sType = "UndeadLizardfolk";
            if (nWhich < 10)
            {
                sType = sType + "0" + IntToString(nWhich);
            }
            else
            {
                sType = sType + IntToString(nWhich);
            }
            object oZomb = CreateObject(OBJECT_TYPE_CREATURE,"UndeadLizardfolk",lSpot);

            //Apply Buffs
            object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oZomb);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,d2(3)),oSkin);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,d2(3)),oSkin);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,d2(3)),oSkin);

            location lGetOut = GetLocation(GetNearestObjectByTag("WalkGuide",oZomb));
            AssignCommand( oZomb, ActionMoveToLocation(lGetOut) );
            DelayCommand(5.0, AssignCommand( oZomb, ActionRandomWalk()));
        }
        else
        {
            nSafeTimer = 310;
            SetLocalInt(OBJECT_SELF,"safetimer",nSafeTimer);
        }
    }
}
