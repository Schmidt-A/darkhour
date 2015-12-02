#include "inc_bs_module"

void main()
{
    object oPC = GetLastUsedBy();

    //Don't want people effected by the peaceful badger to take flags
    if (GetLocalInt(oPC, "BadgerGift") == TRUE)
    {
    FloatingTextStringOnCreature("You are too peaceful to even consider taking a flag and upsetting the enemy team.", oPC, FALSE);
    }
    else
    {
    int nTeam = GetPlayerTeam(oPC);
    int nFlagTeam = GetLocalInt(OBJECT_SELF, "nTeam");

    if ((nTeam == nFlagTeam) || (nTeam !=1 && nTeam !=2))
    {
        return;
    }

    if (GetLocalObject(GetModule(), "oHasFlag_" + IntToString(nFlagTeam)) == OBJECT_SELF)
    {
        PickupFlag(oPC, OBJECT_SELF);
    }
    else
    {
        DestroyObject(OBJECT_SELF);
    }
    }
}
