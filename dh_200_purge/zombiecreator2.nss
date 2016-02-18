//Securable Location Spawner. Applies a +4 Bonus to Str, Dex, and Con to zombies
//Use in Sispara Securables -Only-. The other island will always have secured locations

#include "_incl_enemies"

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

    if ((nZNum < nZExpected) && (nSafeTimer < 11))
    {
        if (nSafeTimer > 0)
        {
            oObj = GetObjectByTag(sWTag,Random(nWNum));
            location lSpot = GetLocation(oObj);
            int nWhich = Random(12);
            string sType = "zn_zombie0";
            if (nWhich < 10)
            {
                sType = sType + "0" + IntToString(nWhich);
            }
            else
            {
                sType = sType + IntToString(nWhich);
            }
            object oZomb = CreateObject(OBJECT_TYPE_CREATURE,sType,lSpot);

            //Apply Buffs
            BuffEnemy(oZomb, 4, 3, 4);

            //Spawn surprise round so zombies don't automurder
            SpawnSurprise(oZomb);

            // Force zombie to move away from his spawn location by the use of WalkGuide placeables
            RandomWalkItOut(oZomb, "WalkGuide", 5.0f);

            // Set "finishcreate" to 1 on the zombie - Possibly used in other scripts???
            DelayCommand(5.0, SetLocalInt(oZomb,"finishcreate",1));
        }
        else
        {
            nSafeTimer = 310;
            SetLocalInt(OBJECT_SELF,"safetimer",nSafeTimer);
        }
    }
}
