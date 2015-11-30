#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oDM = GetItemActivator();
    object oItem = GetItemActivated();
    if(GetIsDM(oDM))
        {
        AssignCommand(oDM, ActionStartConversation(oDM,"dm_server_reset",TRUE,FALSE));
        }
    }
}
