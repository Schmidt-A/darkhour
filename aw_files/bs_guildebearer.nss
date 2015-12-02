#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"
#include "inc_bs_module"

void main()
{
    SetLocalObject(GetModule(), "oHasFlag_2", OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "nTeam", TEAM_EVIL);
    ApplyFlagEffect(OBJECT_SELF);
    WalkWayPoints();
}
