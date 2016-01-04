#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
int DEBUG_MODE = GetLocalInt(GetModule(),"DEBUG_MODE");
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oDM = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    if(GetIsDM(oDM))
        {
        if(oTarget != OBJECT_INVALID)
            {
            SetLocalObject(oDM,"RENAMER_OBJECT",oTarget);
            }
        else
            {
            SendMessageToPC(oDM,"You did not select anyone!");
            SetLocalObject(oDM,"RENAMER_OBJECT",OBJECT_INVALID);
            }
        }
    }
}

