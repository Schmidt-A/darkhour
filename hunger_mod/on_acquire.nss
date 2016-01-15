#include "_incl_hunger"
void main()
{
    object oPC = GetModuleItemAcquiredBy();
    object oPCToken = GetItemPossessedBy(oPC, "token_pc");
    object oItem = GetModuleItemAcquired();

    if(GetStringLeft(GetTag(oItem), 4) == "food")
    {
        if(GetLocalFloat(oPCToken, "fSatisfaction") <= 60.0)
            UpdateHunger(oPC, TRUE);
    }

}
