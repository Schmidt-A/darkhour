#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    if(GetLocalInt(GetArea(oPC), "choppable") != 1)
        {
        SendMessageToPC(oPC, "This area does not have trees suitable for chopping.");
        return;
        }else
            {
            SendMessageToPC(oPC, "You have successfully chopped wood from the nearby trees!");
            CreateItemOnObject("rotd_wood", oPC);
            }
    }
}
