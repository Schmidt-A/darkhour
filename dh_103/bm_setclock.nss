void main()
{
 int iHour = GetTimeHour();
 int iMilli = GetTimeMillisecond();
 int iMinute = GetTimeMinute();
 int iSecond = GetTimeSecond();
 SetTime(iHour, iMinute, iSecond, iMilli);
 AssignCommand(OBJECT_SELF, DelayCommand(120.0, ExecuteScript("bm_setclock", OBJECT_SELF)));
}
