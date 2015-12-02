#include "x2_inc_itemprop"

void main()
{
    object oPC = GetItemActivator();
    object oMaker = GetItemPossessedBy(oPC,"BoltMaker");

    int elemental_bonus = GetLocalInt(oMaker,"elemental_bonus");
    int physical_bonus = GetLocalInt(oMaker,"physical_bonus");
    int elemental_damage = GetLocalInt(oMaker,"elemental_damage");
    int physical_damage = GetLocalInt(oMaker,"physical_damage");

   // FloatingTextStringOnCreature("elemental: " + IntToString(elemental_bonus) + " " + IntToString(elemental_damage),oPC,FALSE);
   // FloatingTextStringOnCreature("physical: " + IntToString(physical_bonus) + " " + IntToString(physical_damage),oPC,FALSE);
    object oBolts = CreateItemOnObject("nw_wambo001",oPC,99);
    SetPlotFlag(oBolts,TRUE);
    SetItemCursedFlag(oBolts,TRUE);

    if (physical_damage > 0)
    {

       IPSafeAddItemProperty(oBolts,ItemPropertyDamageBonus(physical_bonus,physical_damage));
    }
    if (elemental_damage > 0)
    {

       IPSafeAddItemProperty(oBolts,ItemPropertyDamageBonus(elemental_bonus,elemental_damage));
    }

   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_bonus")) + " " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_damage")),oPC);
   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(oMaker,"elemental_bonus")) + " " + IntToString(GetLocalInt(oMaker,"elemental_damage")),oPC);
}
