/*
 *  Now with scaling available.
 *  fScale = 1.0 assumes NWN default of 2 min real time = 1 hour game time
 *           2.0 assumes 4 min real time = 1 hour game time.
 *           0.01 is good for quick testing.
 */

float fScale = 2.0;  // Default scale is 1.
int iDaysPassed = 0;


float GetModTime();


float GetModTime()
{
    return IntToFloat(
	    GetTimeSecond() + 
	    60 * GetTimeMinute() + 
	    3600 * GetTimeHour() +
	    86400 * iDaysPassed);
}