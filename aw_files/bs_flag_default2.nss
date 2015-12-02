//::///////////////////////////////////////////////
//:: Default On Percieve
//:: BS_C2_DEFAULT2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks to see if the perceived target is an
    enemy and if so fires the Determine Combat
    Round function
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Modified By: Erich Delcamp
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "inc_bs_module"

void main()
{
    // If they're on the enemy team, they are an enemy.
    // If they're on the friendly team, don't attack them.
    if (GetIsEnemyTeam(GetLastPerceived(), OBJECT_SELF))
    {
        SetIsTemporaryEnemy(GetLastPerceived());
    }
    else if (!GetIsEnemyTeam(GetLastPerceived(), OBJECT_SELF))
    {
        SetIsTemporaryFriend(GetLastPerceived());
    }
    WalkWayPoints(TRUE, 0.0);
}
