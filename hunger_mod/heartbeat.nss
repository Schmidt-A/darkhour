#include "_incl_hunger"

// There's 40 heartbeat calls in an in-game hour.
int iHourCounter = 0;

void main()
{
    iHourCounter++;
    object oPC = GetFirstPC();
    object oPCToken = GetItemPossessedBy(oPC, "token_pc");

    while(oPC != OBJECT_INVALID)
    {
        // Check if we need to do an hourly hunger pulse
        if(iHourCounter == 1 && GetLocalInt(oPCToken, "iPalate") < 10)
        {
            UpdateHunger(oPC);
        }
        oPC = GetNextPC();
        oPCToken = GetItemPossessedBy(oPC, "token_pc");
    }
    iHourCounter = 0;
}
