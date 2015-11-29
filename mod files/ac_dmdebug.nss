#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
int DEBUG_MODE = GetLocalInt(GetModule(),"DEBUG_MODE");
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oDM = GetItemActivator();
    object oItem = GetItemActivated();
    if(GetIsDM(oDM))
        {
        if(DEBUG_MODE)
            {
            SetLocalInt(GetModule(),"DEBUG_MODE",FALSE);
            SendMessageToAllDMs("<DEBUG MODE OFF>");
            }
        else
            {
            SetLocalInt(GetModule(),"DEBUG_MODE",TRUE);
            SendMessageToAllDMs("<DEBUG MODE ON>");
            }
        }
    }
}
