#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    location oLoc = GetItemActivatedTargetLocation();
    if(GetIsDM(oPC) == TRUE)
        {
        SetLocalLocation(GetModule(), "cannonspot", oLoc);
        AssignCommand(oPC, ActionStartConversation(oPC, "dmcannonwand", TRUE, FALSE));
        }else
            {
            DestroyObject(oItem);
            SendMessageToPC(oPC, "This wand is for DM use only and has been removed.");
            }
    }

}
