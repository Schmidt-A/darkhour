#include "_cls_bard"

void main()
{
    object oPC = GetPCLevellingUp();
    int iBardLevels = GetLevelByClass(CLASS_TYPE_BARD, oPC);

    object oBardToken = GetItemPossessedBy(oPC, "bard_boosts");
    int iLastBardLevels = GetLocalInt(oBardToken, "iBardLevel");

    if(iBardLevels > 0 && iBardLevels > iLastBardLevels)
        BardLevel(oPC, oBardToken, iBardLevels);
}
