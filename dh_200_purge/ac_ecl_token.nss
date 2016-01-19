#include "_incl_subrace"
void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    string sPre = GetDBVarName(oPC);

    int iECL = GetCampaignInt("SUBRACE", sPre+"iECL");
    int iXPNeeded = GetCampaignInt("SUBRACE", sPre+"iXPNeeded");
    int iCumulative = GetCampaignInt("SUBRACE", sPre+"iCumulativeXP");

    string sECL = IntToString(iECL);
    string sXPNeeded = IntToString(iXPNeeded);
    string sCumulative = IntToString(iCumulative);

    SendMessageToPC(oPC, "You currently have " + sCumulative + " XP. Because your ECL is " + sECL + ", you need to reach " + sXPNeeded + " XP to level up.");
}
