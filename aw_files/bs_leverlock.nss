#include "inc_bs_module"


void main()
{
    int nIsLocked = GetLocalInt(OBJECT_SELF, "nIsLocked");

    if (nIsLocked == TRUE)
    {
        UnlockCastleDoors();
        nIsLocked = FALSE;
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);

    }
    else
    {
        LockCastleDoors();
        nIsLocked = TRUE;
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

    }

    SetLocalInt(OBJECT_SELF, "nIsLocked", nIsLocked);
}
