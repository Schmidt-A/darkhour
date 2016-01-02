// TODO: Long-term we need an _incl_badge function so that this is generic.

#include "_incl_xp"
void main()
{
    object oPC = GetLastAttacker(OBJECT_SELF);

    // Nothing more to do if the player already has this badge.
    if(GetItemPossessedBy(oPC, "badge_dummy") != OBJECT_INVALID)
        return;

    int iDummyHits = GetLocalInt(oPC, "iDummyHits");

    if(iDummyHits == 100)
    {
        DeleteLocalInt(oPC, "iDummyHits");
        CreateItemOnObject("badge_dummy", oPC);
        FloatingTextStringOnCreature("You receieved a new badge!", oPC, FALSE);
        GiveXPToCreatureDH(oPC, 50, "XP_BADGE");
    }
    else
        SetLocalInt(oPC, "iDummyHits", iDummyHits+1);
}
