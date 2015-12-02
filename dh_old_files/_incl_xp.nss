#include "_incl_subrace"

//void GiveXPToCreatureDH(object oPC, int iAmount, string sSource);


//maybe this wil lbe useful?
int GetXPDH(object oPC)
{
    if (GetItemPossessedBy(oPC, "ecl_token") == OBJECT_INVALID)
    {
        return GetLocalInt(oPC, "PC_XP");
    }
    else
    {
        return GetCampaignInt("SUBRACE", GetDBVarName(oPC)+"iCumulativeXP");
    }
}


//maybe this wil lbe useful?
void SetXPVars(object oPC)
{
    if (GetItemPossessedBy(oPC, "ecl_token") == OBJECT_INVALID)
    {
        SetLocalInt(oPC, "PC_XP", GetXP(oPC));
    }
    else
    {
        SetLocalInt(oPC, "PC_XP", GetCampaignInt("SUBRACE", GetDBVarName(oPC)+"iCumulativeXP");
    }
}


void GiveXPToCreatureDH(object oPC, int iAmount, string sSource)
{
    // Normal case - not an ECL character.
    if (GetItemPossessedBy(oPC, "ecl_token") == OBJECT_INVALID)
    {
        GiveXPToCreature(oPC, iAmount);

        //logigng exp gains
        WriteTimestampedEntry("XP Gained: " + sSource + " | " + GetName(oPC) + " | " + GetPCPlayerName(oPC) + " | " + iAmount + " | " + getXP(oPC));

        return;
    }
    string sPre = GetDBVarName(oPC);

    int iXPNeeded = GetCampaignInt("SUBRACE", sPre+"iXPNeeded");
    int iCumulativeXP = GetCampaignInt("SUBRACE", sPre+"iCumulativeXP");

    iCumulativeXP += iAmount;
    SetCampaignInt("SUBRACE", sPre+"iCumulativeXP", iCumulativeXP);
    SendMessageToPC(oPC, "You gained " + IntToString(iAmount) + " XP.");

    //logging exp gains
    WriteTimestampedEntry("XP Gained: " + sSource + " | " + GetName(oPC) + " | " + GetPCPlayerName(oPC) + " | " + iAmount + " | " + iCumulativeXP);

    // Woo they have enough to level
    if (iCumulativeXP >= iXPNeeded)
    {
        SendMessageToPC(oPC, "Congratulations! You have earned the ECL XP necessary to level up!");
        int iRealXP = GetCampaignInt("SUBRACE", sPre+"iRealXP");
        iRealXP += (iCumulativeXP - iXPNeeded);
        SetXP(oPC, iRealXP);
        SetupNextECLLevel(oPC);
    }
}
