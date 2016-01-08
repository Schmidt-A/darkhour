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
            object oFirstPortal = GetLocalObject(oItem,"PORTAL");
            if(oFirstPortal!=OBJECT_INVALID)
                {
                object oSecondPortal = CreateObject(OBJECT_TYPE_PLACEABLE,"dmx_dmportal",GetItemActivatedTargetLocation(),FALSE);
                SetLocalLocation(oFirstPortal,"PORTAL",GetItemActivatedTargetLocation());
                SetLocalLocation(oSecondPortal,"PORTAL",GetLocation(oFirstPortal));
                SetLocalObject(oItem,"PORTAL",OBJECT_INVALID);
                }
             else
           {
           oFirstPortal = CreateObject(OBJECT_TYPE_PLACEABLE,"dmx_dmportal",GetItemActivatedTargetLocation(),FALSE);
           SetLocalObject(oItem,"PORTAL",oFirstPortal);
           }
        }
    }
}
