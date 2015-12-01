#include "_incl_xp"
void DelayedCreateItemOnObject(string sResref, object oTarget, int nStacksize)
{
    CreateItemOnObject(sResref, oTarget, nStacksize);
}
void main()
{
    //Variables
    object oPC = OBJECT_SELF;
    object oItem = GetFirstItemInInventory(oPC);

    //Add tokens, tally tokens, verify stack counts
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "SurvivalTime")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                DestroyObject(oItem);
                GiveXPToCreatureDH(oPC, 15);
                DelayCommand(1.0, DelayedCreateItemOnObject("survivaltimex10", oPC, 1));
            }
        }
        if (GetTag(oItem) == "ST10")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                DestroyObject(oItem);
                DelayCommand(1.0, DelayedCreateItemOnObject("survivaltime100", oPC, 1));
            }
        }
        if (GetTag(oItem) == "ST100")
        {
            if (GetItemStackSize(oItem) == 10)
            {
                DestroyObject(oItem);
                DelayCommand(1.0, DelayedCreateItemOnObject("survivaltime1000", oPC, 1));
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
}
