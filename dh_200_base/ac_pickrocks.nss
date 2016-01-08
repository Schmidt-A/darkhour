#include "x2_inc_switches"
void makeRocks(object oPC)
{
int nRocks = d10(1)+d4(2);
object oRocks = GetItemPossessedBy(oPC,"dmxrocks");
if(oRocks != OBJECT_INVALID)
    SetItemStackSize(oRocks,GetItemStackSize(oRocks)+nRocks);
else
    CreateItemOnObject("dmxrocks",oPC,nRocks);
}

void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oArea = GetArea(oPC);
    if(GetIsAreaNatural(oArea) || GetIsAreaAboveGround(oArea))
        {
            if(!GetIsAreaInterior(oArea) && !GetLocalInt(oArea,"OOC_AREA"))
            {
            AssignCommand(oPC,ClearAllActions());
            AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,3.0f));
            FloatingTextStringOnCreature("You bend over and pick up some rocks...",oPC,FALSE);
            float fDelay = IntToFloat(Random(3)+3);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oPC,fDelay);
            DelayCommand(fDelay,makeRocks(oPC));
            }
            else
                FloatingTextStringOnCreature("You cannot find any rocks around here...",oPC,FALSE);
        }
    }
}
