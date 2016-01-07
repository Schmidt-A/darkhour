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
    ExecuteScript("nw_c2_default1", OBJECT_SELF);
    if(GetDistanceToObject(GetWaypointByTag("wyvspawnhere")) > 40.0)
        {
        object oTarget = GetWaypointByTag("wyvspawnhere");
        location lLocation = GetLocation(oTarget);
        ClearAllActions(TRUE);
        DelayCommand(0.3, AssignCommand(OBJECT_SELF, ActionJumpToLocation(lLocation)));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(OBJECT_SELF));
        }
}
