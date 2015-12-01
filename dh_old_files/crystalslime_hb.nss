//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    int nTime = GetTimeHour();
    if(nTime > 6 && nTime < 23)
    {
        DestroyObject(OBJECT_SELF);
    }
    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
