#include "_cls_bard"

void main()
{
    object oPC = GetEnteringObject();
    object oPCToken = GetItemPossessedBy(oPC, "token_pc");

    // First login ever - there'll have to be lots of other setup stuff here.
    if(oPCToken == OBJECT_INVALID)
    {
        oPCToken = CreateItemOnObject("token_pc", oPC);
        // Setup for brand new bard
        if(GetClassByPosition(1, oPC) == CLASS_TYPE_BARD && GetHitDice(oPC) == 1)
            SetupNewBard(oPC);
    }
}
