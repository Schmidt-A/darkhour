//Spire
void main()
{
    //PrintString("zombiecreator4: " + GetName(OBJECT_SELF) + " In: " + GetName(GetArea(OBJECT_SELF))); // Debug - find out wtf this script is called from
    int nZNum = 0;
    int nWNum = 0;
    string sWTag = GetLocalString(OBJECT_SELF,"wpt");
    string sDTag = GetLocalString(OBJECT_SELF,"door1");
    object oDoor1 = GetObjectByTag(sDTag);
    sDTag = GetLocalString(OBJECT_SELF,"door2");
    object oDoor2 = GetObjectByTag(sDTag);
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
        if (GetStringLeft(GetTag(oObj),9) == "ZN_ZOMBIE")
        {
            nZNum += 1;
        }
        else if (GetTag(oObj) == sWTag)
        {
            nWNum += 1;
        }
        oObj = GetNextObjectInArea();
    }

    if ((nZNum < nZExpected) && (nSafeTimer < 26))
    {
        if (nSafeTimer > 0)
        {
            SetLocked(oDoor1,TRUE);
            SetLocked(oDoor2,TRUE);
            oObj = GetObjectByTag(sWTag,Random(nWNum));
            location lSpot = GetLocation(oObj);
            int nWhich = Random(4) + 13;
            string sType = "zn_zombie0" + IntToString(nWhich);
            object oZomb = CreateObject(OBJECT_TYPE_CREATURE,sType,lSpot);
            //Apply Buffs
            object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oZomb);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,d2(6)),oSkin);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,d2(3)),oSkin);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,d2(6)),oSkin);
            location lGetOut = GetLocation(GetNearestObjectByTag("WalkGuide",oZomb));
            AssignCommand( oZomb, ActionMoveToLocation(lGetOut) );
            DelayCommand(5.0, AssignCommand( oZomb, ActionRandomWalk()));
        }
        else if (nZNum == 0)
        {
            nSafeTimer = 125;
            SetLocked(oDoor1,FALSE);
            SetLocked(oDoor2,FALSE);
            SetLocalInt(OBJECT_SELF,"safetimer",nSafeTimer);
        }
    }
}
