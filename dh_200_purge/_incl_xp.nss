#include "_incl_subrace"

void GiveXPToCreatureDH(object oPC, int iAmount);

void GiveXPToCreatureDH(object oPC, int iAmount)
{
    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        if(GetTag(oItem) == "ecl_token")
            break;
        oItem = GetNextItemInInventory(oPC);
    }

    // Normal case - not an ECL character.
    if(GetTag(oItem) != "ecl_token")
    {
        GiveXPToCreature(oPC, iAmount);
        return;
    }

    int iXPNeeded = GetLocalInt(oItem, "iXPNeeded");
    int iCumulativeXP = GetLocalInt(oItem, "iCumulativeXP");

    iCumulativeXP += iAmount;
    SetLocalInt(oItem, "iCumulativeXP", iCumulativeXP);
    SendMessageToPC(oPC, "You gained " + IntToString(iAmount) + " XP.");

    // Woo they have enough to level
    if(iCumulativeXP >= iXPNeeded)
    {
        SendMessageToPC(oPC, "Congratulations! You have earned the ECL XP necessary to level up!");
        int iRealXP = GetLocalInt(oItem, "iRealXP");
        iRealXP += (iCumulativeXP - iXPNeeded);
        SetXP(oPC, iRealXP);
        SetupNextECLLevel(oPC, oItem);
    }
}
