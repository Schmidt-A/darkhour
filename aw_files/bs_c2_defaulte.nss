//::///////////////////////////////////////////////
//:: Default On Heartbeat
//:: BS_C2_DEFAULTE
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This will cause blocked creatures to open
    or smash down doors depending on int and
    str.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Modified By: Erich Delcamp
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////

void main()
{
    object oDoor = GetBlockingDoor();

    if(GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 5)
    {
        if((GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN) && GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 7 )
          || (GetTag(oDoor) == "FlorinGate" || GetTag(oDoor) == "GuilderGate"))
        {
            DoDoorAction(oDoor, DOOR_ACTION_OPEN);
        }
        else if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_BASH))
        {
            DoDoorAction(oDoor, DOOR_ACTION_BASH);
        }
    }
}
