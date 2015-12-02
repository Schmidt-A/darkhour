#include "x2_inc_itemprop"

void main()
{
    object oPC = GetItemActivator();
    object oMaker = GetItemPossessedBy(oPC,"ArrowMaker");

    int elemental_bonus = GetLocalInt(oMaker,"elemental_bonus");
    int physical_bonus = GetLocalInt(oMaker,"physical_bonus");
    int elemental_damage = GetLocalInt(oMaker,"elemental_damage");
    int physical_damage = GetLocalInt(oMaker,"physical_damage");

   // FloatingTextStringOnCreature("elemental: " + IntToString(elemental_bonus) + " " + IntToString(elemental_damage),oPC,FALSE);
   // FloatingTextStringOnCreature("physical: " + IntToString(physical_bonus) + " " + IntToString(physical_damage),oPC,FALSE);
    object oArrows = CreateItemOnObject("nw_wamar001",oPC,99);
    SetPlotFlag(oArrows,TRUE);
    SetItemCursedFlag (oArrows,TRUE);

    if (physical_damage > 0)
    {

       IPSafeAddItemProperty(oArrows,ItemPropertyDamageBonus(physical_bonus,physical_damage));
    }
    if (elemental_damage > 0)
    {

       IPSafeAddItemProperty(oArrows,ItemPropertyDamageBonus(elemental_bonus,elemental_damage));
    }

   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_bonus")) + " " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_damage")),oPC);
   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(oMaker,"elemental_bonus")) + " " + IntToString(GetLocalInt(oMaker,"elemental_damage")),oPC);
}
