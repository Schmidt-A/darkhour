void main()
{

object oPC = GetLastUsedBy();
object oExit;

if ((GetLocalInt(oPC, "Hunter") == TRUE) || (GetLocalInt(oPC, "LegendHunter") == TRUE))
    {
        if (GetLocalInt(OBJECT_SELF, "evilspawn") == 1)
        {
            oExit = GetWaypointByTag("EvilExit");
        }
        else if (GetLocalInt(OBJECT_SELF, "evilspawn") == 2)
        {
            oExit = GetWaypointByTag("EvilExit2");
        }
        else if (GetLocalInt(OBJECT_SELF, "evilspawn") == 3)
        {
            oExit = GetWaypointByTag("EvilExit3");
        }
        else if (GetLocalInt(OBJECT_SELF, "goodspawn") == 1)
        {
            oExit = GetWaypointByTag("GoodExit");
        }
        else if (GetLocalInt(OBJECT_SELF, "goodspawn") == 2)
        {
            oExit = GetWaypointByTag("GoodExit2");
        }
        else if (GetLocalInt(OBJECT_SELF, "goodspawn") == 3)
        {
            oExit = GetWaypointByTag("GoodExit3");
        }
        AssignCommand(oPC, JumpToObject(oExit));
    }

}
