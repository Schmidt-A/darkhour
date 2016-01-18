#include "_cls_bard"

void main()
{
    object oPC = GetPCLevellingUp();
    int iBardLevels = GetLevelByClass(CLASS_TYPE_BARD, oPC);

    object oPCToken = GetItemPossessedBy(oPC, "bard_boosts");
    int iLastBardLevels = GetLocalInt(oPCToken, "iBardLevel");

    if(iBardLevels > 0 && iBardLevels > iLastBardLevels)
        BardLevel(oPC, oPCToken, iBardLevels);
}
