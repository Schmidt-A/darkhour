#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"
#include "inc_bs_module"

void main()
{
    SetLocalObject(GetModule(), "oHasFlag_1", OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "nTeam", TEAM_GOOD);
    ApplyFlagEffect(OBJECT_SELF);
    WalkWayPoints();
}
