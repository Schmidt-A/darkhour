#include "x2_inc_itemprop"

void main()
{
    object oPC = GetItemActivator();
    object oMaker = GetItemPossessedBy(oPC,"DartMaker");

    int elemental_bonus = GetLocalInt(oMaker,"elemental_bonus");

    int elemental_damage = GetLocalInt(oMaker,"elemental_damage");
    int eb = GetLocalInt(oMaker,"eb");


   // FloatingTextStringOnCreature("elemental: " + IntToString(elemental_bonus) + " " + IntToString(elemental_damage),oPC,FALSE);
   // FloatingTextStringOnCreature("physical: " + IntToString(physical_bonus) + " " + IntToString(physical_damage),oPC,FALSE);
    object oDarts = CreateItemOnObject("nw_wthdt001",oPC,50);
    SetPlotFlag(oDarts,TRUE);
    //Sets the ammo not to be dropped or unacquired
    SetItemCursedFlag(oDarts,TRUE);

    //FloatingTextStringOnCreature("why no darts",oPC);
    if (oDarts == OBJECT_INVALID)
    {
        FloatingTextStringOnCreature("Darts suck :(",oPC);
    }

    if (eb > 0)
    {

       IPSetWeaponEnhancementBonus(oDarts,eb);
    }
    if (elemental_damage > 0)
    {

       IPSafeAddItemProperty(oDarts,ItemPropertyDamageBonus(elemental_bonus,elemental_damage));
    }

   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_bonus")) + " " + IntToString(GetLocalInt(OBJECT_SELF,"elemental_damage")),oPC);
   // FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(oMaker,"elemental_bonus")) + " " + IntToString(GetLocalInt(oMaker,"elemental_damage")),oPC);
}
