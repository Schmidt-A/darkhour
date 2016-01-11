#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sRes = GetStringLeft(GetResRef(oTarget), 3);
    if(sRes == "st_")
        {
        SendMessageToPC(oPC, "You have used this tool, and destroyed your " + GetName(oTarget));
        DestroyObject(oTarget);
        }else
            {
            SendMessageToPC(oPC, "This tool can only be used on a standard artifact.");
            CreateItemOnObject("artbreaker", oPC);
            }
    }

}
