#include "_incl_hunger"

// There's 40 heartbeat calls in an in-game hour.
int iHourCounter = 0;

void main()
{
    // Check if we need to do an hourly hunger pulse
    iHourCounter++;
    if(iHourCounter == 1)
    {
        iHourCounter = 0;
        DBUpdateHunger();
    }
}
