#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oWood = GetItemPossessedBy(oPC,"rotd_wood");
    if(oWood != OBJECT_INVALID)
        {
        FloatingTextStringOnCreature("You start a campfire.",oPC,FALSE);
        DestroyObject(oItem);
        DestroyObject(oWood);
        object oCampfire = CreateObject(OBJECT_TYPE_PLACEABLE,"campfire",GetLocation(oPC));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_15),oCampfire,120.0);
        DestroyObject(oCampfire,120.0);
        }
    else
        {
        FloatingTextStringOnCreature("You don't have any Wood to burn!",oPC,FALSE);
        }
    }
}
