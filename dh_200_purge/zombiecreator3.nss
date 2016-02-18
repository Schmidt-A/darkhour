//Royal Spawner. Applies a +8 Bonus to Str, Dex and Con. Use in Boss Locations. Siranda.
//Spawns Siranda Royalty Zombies

#include "_incl_enemies"

void main()
{
    //PrintString("zombiecreator3: " + GetName(OBJECT_SELF) + " In: " + GetName(GetArea(OBJECT_SELF))); // Debug - find out wtf this script is called from
    int nZNum = 0;
    int nWNum = 0;
    string sWTag = GetLocalString(OBJECT_SELF,"wpt");
    int nZExpected = GetLocalInt(OBJECT_SELF,"noz");

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

    if (nZNum < nZExpected)
    {
        oObj = GetObjectByTag(sWTag,Random(nWNum));
        location lSpot = GetLocation(oObj);
        int nWhich = Random(4) + 13;
        string sType = "zn_zombie0" + IntToString(nWhich);
        
        object oZomb = CreateObject(OBJECT_TYPE_CREATURE,sType,lSpot);

        //Apply Buffs
        BuffEnemy(oZomb, 5, 4, 6);

        //Spawn surprise round so zombies don't automurder
        SpawnSurprise(oZomb);

        // Force zombie to move away from his spawn location by the use of WalkGuide placeables
        RandomWalkItOut(oZomb, "WalkGuide", 5.0f);

        // Set "finishcreate" to 1 on the zombie - Possibly used in other scripts???
        DelayCommand(5.0, SetLocalInt(oZomb,"finishcreate",1));
    }
}
