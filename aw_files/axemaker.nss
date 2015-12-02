#include "x2_inc_itemprop"

void main()
{
    object oPC = GetItemActivator();
    object oMaker = GetItemPossessedBy(oPC,"AxeMaker");

    int elemental_bonus = GetLocalInt(oMaker,"elemental_bonus");

    int elemental_damage = GetLocalInt(oMaker,"elemental_damage");
    int eb = GetLocalInt(oMaker,"eb");


   // FloatingTextStringOnCreature("elemental: " + IntToString(elemental_bonus) + " " + IntToString(elemental_damage),oPC,FALSE);
   // FloatingTextStringOnCreature("physical: " + IntToString(physical_bonus) + " " + IntToString(physical_damage),oPC,FALSE);
    object oAxe = CreateItemOnObject("nw_wthax001",oPC,50);
    SetPlotFlag(oAxe,TRUE);
    SetItemCursedFlag(oAxe,TRUE);

    if (eb > 0)
    {

       IPSetWeaponEnhancementBonus(oAxe,eb);
    }
    if (elemental_damage > 0)
    {

       IPSafeAddItemProperty(oAxe,ItemPropertyDamageBonus(elemental_bonus,elemental_damage));
    }

   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_bonus")) + " " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_damage")),oPC);
   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(oMaker,"elemental_bonus")) + " " + IntToString(GetLocalInt(oMaker,"elemental_damage")),oPC);
}
