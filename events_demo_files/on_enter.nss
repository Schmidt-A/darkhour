#include "_incl_bard"

void main()
{
    object oPC = GetEnteringObject();

    GiveXPToCreature(oPC, 15000);

    // Setup for brand new bard
    if(GetClassByPosition(1, oPC) == CLASS_TYPE_BARD && GetHitDice(oPC) == 1 &&
       GetItemPossessedBy(oPC, "bard_boosts") == OBJECT_INVALID)
    {
        SetupNewBard(oPC);
    }
}
