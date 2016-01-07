#include "nw_i0_generic"
void main()
{
    if(GetIsInCombat(OBJECT_SELF) == FALSE)
    {
        WalkWayPoints();
    }
}
