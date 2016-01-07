#include "x2_inc_switches"

void main()
{
    object oPC      = GetItemActivator();
    string sDMName  = GetPCPlayerName(oPC);
    int iAuthorized = FALSE;
    int i;

    if(sDMName == "Caffeinated_Tweek")
        iAuthorized = TRUE;

    if(iAuthorized == FALSE)
    {
        SendMessageToPC(oPC, "You are not authorized to use this tool. Contact an admin for help.");
        return;
    }

    string sPlayerName     = GetPCChatMessage();
    string sKeyVarName = "KEY_" + sPlayerName;
    string sKey        = GetCampaignString("AUTH", sKeyVarName);

    if(sKey == "")
        SendMessageToPC(oPC, "We don't have a record for the account '" + sPlayerName + "'. Reactivate the item and try again.");
    else
    {
        DeleteCampaignVariable("AUTH", sKeyVarName);
        SendMessageToPC(oPC, "Deleted key record for '" + sPlayerName + "'.");
    }
}
