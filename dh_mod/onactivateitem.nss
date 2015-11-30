//////////////////////////////////////////////////////////////////////////////////////////////
//////  This script either replaces, or goes into your Module's OnActivateItem script.  //////
//////  It will make the "Weathered Map" work for players trying to use it.             //////
//////////////////////////////////////////////////////////////////////////////////////////////


void main()
{
/////////////////  Begin essential "Weathered Map" code here  /////////////////
    if (GetTag(GetItemActivated()) == "WeatheredMap")
    {
        object oPC = GetItemActivator();
        if (oPC != OBJECT_INVALID)
        {
            object oArea        = GetArea(oPC);
            string sCurAreaTag  = GetTag(oArea);
            string sCurAreaX    = GetSubString(sCurAreaTag,0,3);
            string sCurAreaY    = GetSubString(sCurAreaTag,3,3);
            int nCurAreaX, nCurAreaY;
            string sPCMessage   = "From what you can tell on the map, the area you are in is at roughly ";
            if (GetStringLeft(sCurAreaX,1) == "p")
            {
                nCurAreaX = (StringToInt(GetStringRight(sCurAreaX,2)));
                sPCMessage = sPCMessage + IntToString(nCurAreaX) + " East, by ";
            }
            else
                if (GetStringLeft(sCurAreaX,1) == "n")
                {
                    nCurAreaX = (StringToInt(GetStringRight(sCurAreaX,2)));
                    sPCMessage = sPCMessage + IntToString(nCurAreaX) + " West, by ";
                }
            if (GetStringLeft(sCurAreaY,1) == "p")
            {
                nCurAreaY = (StringToInt(GetStringRight(sCurAreaY,2)));
                sPCMessage = sPCMessage + IntToString(nCurAreaY) + " South.";
            }
            else
                if (GetStringLeft(sCurAreaY,1) == "n")
                {
                    nCurAreaY = (StringToInt(GetStringRight(sCurAreaY,2)));
                    sPCMessage = sPCMessage + IntToString(nCurAreaY) + " North.";
                }
            SendMessageToPC(oPC,sPCMessage);
        }
    }
}
//////////////////  End essential "Weathered Map" code here  //////////////////

