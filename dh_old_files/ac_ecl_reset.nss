#include "_incl_subrace"

void main()
{
    object oDM      = GetItemActivator();
    object oPC      = GetItemActivatedTarget();
    string sPre     = GetDBVarName(oPC);

    DeleteCampaignVariable("SUBRACE", sPre + "iLA");
    DeleteCampaignVariable("SUBRACE", sPre + "iECL");
    DeleteCampaignVariable("SUBRACE", sPre + "iXPNeeded");
    DeleteCampaignVariable("SUBRACE", sPre + "iCumulativeXP");
    DeleteCampaignVariable("SUBRACE", sPre + "iRealXP");

    SendMessageToPC(oDM, "Deleted ECL Database info for " + GetName(oPC) + ".");
}
