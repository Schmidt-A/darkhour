#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oNPC = GetItemActivatedTarget();
    SetLocalObject(oPC,"BanWandTarget",oNPC);
    AssignCommand(oPC,ActionStartConversation(oPC,"dmban",TRUE,FALSE));
    }
}
