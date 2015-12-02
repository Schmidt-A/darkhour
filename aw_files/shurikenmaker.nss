#include "x2_inc_itemprop"

void main()
{
    object oPC = GetItemActivator();
    object oMaker = GetItemPossessedBy(oPC,"ShurikenMaker");

    int elemental_bonus = GetLocalInt(oMaker,"elemental_bonus");

    int elemental_damage = GetLocalInt(oMaker,"elemental_damage");
    int eb = GetLocalInt(oMaker,"eb");
    int mighty = GetLocalInt(oMaker,"mighty");


   // FloatingTextStringOnCreature("elemental: " + IntToString(elemental_bonus) + " " + IntToString(elemental_damage),oPC,FALSE);
   // FloatingTextStringOnCreature("physical: " + IntToString(physical_bonus) + " " + IntToString(physical_damage),oPC,FALSE);
    object oShuriken = CreateItemOnObject("nw_wthsh001",oPC,50);
    SetPlotFlag(oShuriken,TRUE);
    //Sets the ammo not to be dropped or unacquired
    SetItemCursedFlag(oShuriken,TRUE);

    if (eb > 0)
    {

       IPSetWeaponEnhancementBonus(oShuriken,eb);
    }
    if (elemental_damage > 0)
    {

       IPSafeAddItemProperty(oShuriken,ItemPropertyDamageBonus(elemental_bonus,elemental_damage));
    }
    if (mighty > 0)
    {
        IPSafeAddItemProperty(oShuriken,ItemPropertyMaxRangeStrengthMod(mighty));
    }

   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_bonus")) + " " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_damage")),oPC);
   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(oMaker,"elemental_bonus")) + " " + IntToString(GetLocalInt(oMaker,"elemental_damage")),oPC);
}