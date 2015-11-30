#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oNPC = GetItemActivatedTarget();
    location oLoc = GetItemActivatedTargetLocation();
    SetLocalLocation(oPC,"NPC_Location",oLoc);
    SetLocalObject(oPC,"NPC_Selected",oNPC);
    AssignCommand(oPC,ActionStartConversation(oPC,"npc_storage",TRUE,FALSE));
    }
}
