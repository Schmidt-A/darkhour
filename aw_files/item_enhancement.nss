//#include "x2_i0_spells"
#include "x2_inc_itemprop"
#include "stx_inc_craft"

//remove a damage bonus from a weapon
void RemoveDamageBonus(object oWep,string damage_type,int damage,object oPC);

//remove properties which aren't allowed for monk gloves
void RemoveGloveProperties(object oWep,object oPC);

//initialise the crafting procedure
void StartCrafting(object oPC,object oItem,int removeMeleeProperties=FALSE);

//flag whether to remove disallowed monk glove properties
int removeNonMatchingGloveProperties = TRUE;

//get value of ammo maker
int GetAmmoMakerValue(object oMaker);


//this is duplicated in stx_inc_craft
//int GetIsAmmoMaker(object oItem);


//cost of each improvement to ammo
int AMMO_UPGRADE_COST = 5300;

int AMMO_MIGHTY_COST = 3600;

//const string STX_CR_BACKUP_PLACEABLE  = "stx_cr_backup";

int Is_1d12(int base_type)
{



    switch (base_type)
    {
        case BASE_ITEM_DIREMACE: return TRUE;
        case BASE_ITEM_LIGHTHAMMER:return TRUE;
        case BASE_ITEM_LIGHTFLAIL: return TRUE;
        case BASE_ITEM_SICKLE:return TRUE;
        case BASE_ITEM_CLUB:return TRUE;
        case BASE_ITEM_TRIDENT:return TRUE;
        case BASE_ITEM_WHIP:return TRUE;
        case BASE_ITEM_LIGHTMACE:return TRUE;
        case BASE_ITEM_QUARTERSTAFF:return TRUE;
        default: return FALSE;
    }
    return FALSE;
}

int Is_1d10(int base_type)
{



    switch (base_type)
    {
        case BASE_ITEM_SHORTSPEAR:return TRUE;
        case BASE_ITEM_DOUBLEAXE:return TRUE;
        case BASE_ITEM_TWOBLADEDSWORD:return TRUE;
        case BASE_ITEM_BASTARDSWORD:return TRUE;
        case BASE_ITEM_DAGGER:return TRUE;
        case BASE_ITEM_KATANA:return TRUE;
        case BASE_ITEM_DWARVENWARAXE:return TRUE;
        case BASE_ITEM_WARHAMMER:return TRUE;
        case BASE_ITEM_HALBERD:return TRUE;
        case BASE_ITEM_MORNINGSTAR:return TRUE;
        case BASE_ITEM_HEAVYFLAIL:return TRUE;
        default: return FALSE;
    }
    return FALSE;
}

int Is_1d8(int base_type)
{

    switch (base_type)
    {

        case BASE_ITEM_GREATAXE: return TRUE;
        case BASE_ITEM_GREATSWORD: return TRUE;
        case BASE_ITEM_BATTLEAXE:return TRUE;
        case BASE_ITEM_LONGSWORD:return TRUE;
        case BASE_ITEM_SHORTSWORD: return TRUE;
        case BASE_ITEM_HANDAXE:return TRUE;
        default: return FALSE;
    }
    return FALSE;
}

int Is_1d6(int base_type)
{

    switch (base_type)
    {

        case BASE_ITEM_SCYTHE: return TRUE;
        case BASE_ITEM_KAMA:return TRUE;
        case BASE_ITEM_RAPIER:return TRUE;
        case BASE_ITEM_SCIMITAR:return TRUE;
        case BASE_ITEM_KUKRI:return TRUE;
        default: return FALSE;
    }
    return FALSE;
}

void StartCrafting(object oPC,object oItem,int removeMeleeProperties=FALSE)
{
    object oCopy = CopyItem(oItem, GetObjectByTag(STX_CR_BACKUP_PLACEABLE), TRUE);
    OpenInventory(oPC,oPC);

    if (GetLocalInt(oItem,"isCopy") == 1)
    {
        //check if it is a copy they are trying to enhance
        DestroyObject(oItem);
        FloatingTextStringOnCreature("Please don't try crafting copied items!!",oPC,FALSE);
        return;
    }
    else if (IPGetIsMeleeWeapon(oCopy) && removeMeleeProperties)
    {
         //store the weapon type so they don't change it during the enhancement process

        SetLocalInt(oPC,"eb",IPGetWeaponEnhancementBonus(oItem));
        IPRemoveAllItemProperties(oCopy,DURATION_TYPE_PERMANENT);

        //add disarm back to wep if it is a whip
        if (GetBaseItemType(oCopy) == BASE_ITEM_WHIP)
        {
           IPSafeAddItemProperty(oCopy,ItemPropertyBonusFeat(IP_CONST_FEAT_DISARM_WHIP));

        }
    }

    SetLocalInt(oPC,"wep_type",GetBaseItemType(oItem));
    //store copy of the weapon and mark it as a copy
    SetLocalInt(oCopy,"isCopy",1);
    SetLocalObject(oPC,"copy",oCopy);
    SetLocalObject(oPC,"original",oItem);


}

void AddDamageToItem(object oPC,string type)
{


    if (type == "weapon")
    {
         object oWep = GetLocalObject(oPC,"original");
        object newWep = GetLocalObject(oPC,"copy");

        int startingValue = GetGoldPieceValue(oWep);

        //check to make sure they haven't changed weapons
       /* if (GetBaseItemType(oWep) != GetLocalInt(oPC,"wep_type"))
        {
            FloatingTextStringOnCreature("Please don't try cheating!!",oPC,FALSE);
            DestroyObject(newWep);
            return;
        }    */

        int eb = GetLocalInt(oPC,"eb");


        //remove all bonuses

        //IPRemoveAllItemProperties(newWep,DURATION_TYPE_PERMANENT);
        // Remove any previous Damage Bonus on the item
        IPRemoveMatchingItemProperties(newWep,ITEM_PROPERTY_DAMAGE_BONUS,DURATION_TYPE_PERMANENT);
        // RemoveDamageBonus(newWep,
        //add damage bonus
        IPSafeAddItemProperty(newWep,ItemPropertyDamageBonus(GetLocalInt(oPC,"damage_type"),GetLocalInt(oPC,"damage")));
        //add enhancement bonus
        IPSetWeaponEnhancementBonus(newWep,eb,FALSE);

        //FloatingTextStringOnCreature("was it successful? " + IntToString(GetLocalInt(oPC,"damage_type")) + " " + IntToString(eb) + " " + IntToString(GetLocalInt(oPC,"damage")) ,oPC,FALSE);




    }
    else if (type == "weapon_ranged")
    {

        object oWep = GetLocalObject(oPC,"original");
        object newWep = GetLocalObject(oPC,"copy");


        int mighty = GetLocalInt(oPC,"mighty");

        IPSafeAddItemProperty(newWep,ItemPropertyMaxRangeStrengthMod(mighty));


    }
    else if (type == "enchantment")
    {
         object oWep = GetLocalObject(oPC,"original");
        object newWep = GetLocalObject(oPC,"copy");

        IPSetWeaponEnhancementBonus(newWep,GetLocalInt(oPC,"eb"),FALSE);

    }
    else if (type == "attack_bonus")
    {
        object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        object newWep = GetLocalObject(oPC,"copy");
        int ab = GetLocalInt(oPC,"ab");

        //if not ranged wep, then must be monk gloves
        if (oWep == OBJECT_INVALID)
        {
            oWep =  GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
        }




        IPSafeAddItemProperty(newWep, ItemPropertyAttackBonus(ab));
    }
    else if (type == "attack_bonus_monk")
    {
        object oWep = GetLocalObject(oPC,"original");
        object newWep = GetLocalObject(oPC,"copy");
        int ab = GetLocalInt(oPC,"ab");
        //FloatingTextStringOnCreature("AB is " + IntToString(ab),oPC,FALSE);

        IPSafeAddItemProperty(newWep, ItemPropertyAttackBonus(ab));
    }
    else if (type == "damage_gloves")
    {
        object oWep = GetLocalObject(oPC,"original");
        object newWep = GetLocalObject(oPC,"copy");
        int damage_type =  GetLocalInt(oPC,"damage_type");
        int damage = GetLocalInt(oPC,"damage");

        if (removeNonMatchingGloveProperties)
        {
            RemoveGloveProperties(newWep,oPC);
        }

        switch (damage_type)
        {
            case IP_CONST_DAMAGETYPE_FIRE:  RemoveDamageBonus(newWep,"elemental",GetLocalInt(newWep,"elemental_bonus"),oPC);

                                            break;
            case IP_CONST_DAMAGETYPE_COLD:  RemoveDamageBonus(newWep,"elemental",GetLocalInt(newWep,"elemental_bonus"),oPC);

                                            break;
            case IP_CONST_DAMAGETYPE_SONIC: RemoveDamageBonus(newWep,"elemental",GetLocalInt(newWep,"elemental_bonus"),oPC);

                                            break;
            case IP_CONST_DAMAGETYPE_ACID:  RemoveDamageBonus(newWep,"elemental",GetLocalInt(newWep,"elemental_bonus"),oPC);

                                            break;
            case IP_CONST_DAMAGETYPE_ELECTRICAL:  RemoveDamageBonus(newWep,"elemental",GetLocalInt(newWep,"elemental_bonus"),oPC);

                                            break;
            case IP_CONST_DAMAGETYPE_BLUDGEONING:  RemoveDamageBonus(newWep,"physical",GetLocalInt(newWep,"physical_bonus"),oPC);

                                            break;
            case IP_CONST_DAMAGETYPE_SLASHING:  RemoveDamageBonus(newWep,"physical",GetLocalInt(newWep,"physical_bonus"),oPC);

                                            break;
            case IP_CONST_DAMAGETYPE_PIERCING:  RemoveDamageBonus(newWep,"physical",GetLocalInt(newWep,"physical_bonus"),oPC);

                                            break;
         }


         IPSafeAddItemProperty(newWep,ItemPropertyDamageBonus(damage_type,damage));




    }
    else if (type == "damage_arrow")
    {
        object oWep = GetLocalObject(oPC,"original");
        object newWep = GetLocalObject(oPC,"copy");
        int damage_type =  GetLocalInt(oPC,"damage_type");
        int damage = GetLocalInt(oPC,"damage");

        switch (damage_type)
        {
            case IP_CONST_DAMAGETYPE_FIRE:  SetLocalInt(newWep,"elemental_bonus",damage_type);
                                            SetLocalInt(newWep,"elemental_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_COLD:  SetLocalInt(newWep,"elemental_bonus",damage_type);
                                            SetLocalInt(newWep,"elemental_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_SONIC: SetLocalInt(newWep,"elemental_bonus",damage_type);
                                            SetLocalInt(newWep,"elemental_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_ACID:  SetLocalInt(newWep,"elemental_bonus",damage_type);
                                            SetLocalInt(newWep,"elemental_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_DIVINE:  SetLocalInt(newWep,"elemental_bonus",damage_type);
                                            SetLocalInt(newWep,"elemental_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_POSITIVE:  SetLocalInt(newWep,"elemental_bonus",damage_type);
                                            SetLocalInt(newWep,"elemental_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_NEGATIVE:  SetLocalInt(newWep,"elemental_bonus",damage_type);
                                            SetLocalInt(newWep,"elemental_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_ELECTRICAL:  SetLocalInt(newWep,"elemental_bonus",damage_type);
                                                  SetLocalInt(newWep,"elemental_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_BLUDGEONING:  SetLocalInt(newWep,"physical_bonus",damage_type);
                                                   SetLocalInt(newWep,"physical_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_SLASHING:  SetLocalInt(newWep,"physical_bonus",damage_type);
                                                SetLocalInt(newWep,"physical_damage",damage);
                                            break;
            case IP_CONST_DAMAGETYPE_PIERCING:  SetLocalInt(newWep,"physical_bonus",damage_type);
                                                SetLocalInt(newWep,"physical_damage",damage);
                                            break;
         }








    }
    else if (type == "ammo_enhancement")
    {
        object oWep = GetLocalObject(oPC,"original");
        object newWep = GetLocalObject(oPC,"copy");
        SetLocalInt(newWep,"eb",GetLocalInt(oPC,"eb"));
    }
    else if (type == "ammo_mighty")
    {
        object oWep = GetLocalObject(oPC,"original");
        object newWep = GetLocalObject(oPC,"copy");
        SetLocalInt(newWep,"mighty",GetLocalInt(oPC,"mighty"));
    }



}

void RemoveGloveProperties(object oWep,object oPC)
{
    itemproperty ip = GetFirstItemProperty(oWep);
    //FloatingTextStringOnCreature("Remove properties started....",oPC,FALSE);
    while (GetIsItemPropertyValid(ip))
    {

         // FloatingTextStringOnCreature("subtype: "  + IntToString(GetItemPropertySubType(ip)) + " item property:" + IntToString(GetItemPropertyType(ip)) + " attack bonus:" + IntToString(ITEM_PROPERTY_ATTACK_BONUS),oPC,FALSE);
           if (GetItemPropertyType(ip) == ITEM_PROPERTY_DAMAGE_BONUS)
           {
                switch(GetItemPropertySubType(ip))
                {
                    case 0:
                             break;
                    case 1:
                             break;
                    case 2:
                             break;
                    case   6: break;
                    case   7: break;
                    case   9: break;
                    case   10: break;
                    case   13: break;
                    default://FloatingTextStringOnCreature("subtype: "  + IntToString(GetItemPropertySubType(ip)) + " item property:" + IntToString(GetItemPropertyType(ip)) + " attack bonus:" + IntToString(ITEM_PROPERTY_ATTACK_BONUS),oPC,FALSE);
                             RemoveItemProperty(oWep,ip);
                            break;
                }
            }
            else if  (GetItemPropertyType(ip) != ITEM_PROPERTY_ATTACK_BONUS) RemoveItemProperty(oWep,ip);


        ip = GetNextItemProperty(oWep);
    }

}

void RemoveDamageBonus(object oWep,string damage_type,int damage,object oPC)
{
    itemproperty ip = GetFirstItemProperty(oWep);

    while (GetIsItemPropertyValid(ip))
    {

        if (GetItemPropertyType(ip) == ITEM_PROPERTY_DAMAGE_BONUS)
        {

            if(damage_type == "elemental")
            {
                switch(GetItemPropertySubType(ip))
                {
                    case   6:
                    case   7:
                    case   9:
                    case   10:
                    case   13: RemoveItemProperty(oWep,ip);
                               break;
                }

            }
            else if (damage_type == "physical")
            {
                switch (GetItemPropertySubType(ip))
                {
                    case 0:  RemoveItemProperty(oWep,ip);
                             break;
                    case 1:  RemoveItemProperty(oWep,ip);
                             break;
                    case 2:  RemoveItemProperty(oWep,ip);
                             break;
                }
             }

        }
        ip = GetNextItemProperty(oWep);
    }

}
void EnhanceItemFinish(object oPC);
void EnhanceItemFinish(object oPC)
{
    object oWep = GetLocalObject(oPC,"original");
    object newWep = GetLocalObject(oPC,"copy");

    int startingValue = GetGoldPieceValue(oWep);
    int finishingValue =  GetGoldPieceValue(newWep);

    int price =  finishingValue - startingValue;
        FloatingTextStringOnCreature("Starting Value: " + IntToString(startingValue) + " gold",oPC,FALSE);
        FloatingTextStringOnCreature("Finishing Value: " + IntToString(finishingValue) + " gold",oPC,FALSE);

        //check to see pc can afford modifications
        int pcGold = GetGold(oPC);

        if (price >= pcGold)
        {
            FloatingTextStringOnCreature("You don't have enough gold!",oPC,FALSE);
            DelayCommand(1.0,DestroyObject(newWep));
            return;
        }
        else
        {
            DestroyObject(oWep);
            SetLocalInt(newWep,"isCopy",0);
            object pcWep = CopyItem(newWep,oPC,TRUE);

            if (GetBaseItemType(pcWep) == BASE_ITEM_GLOVES)
            {
                AssignCommand(oPC,ActionEquipItem(pcWep,INVENTORY_SLOT_ARMS));
            }
            else
            {
                AssignCommand(oPC,ActionEquipItem(pcWep,INVENTORY_SLOT_RIGHTHAND));
            }
            DelayCommand(1.0,DestroyObject(newWep));
        }

        //take give gold to pc depending on difference in value before and after modifications
        if (price > 0)
        {
            TakeGoldFromCreature(price,oPC,TRUE);
            FloatingTextStringOnCreature("You have spent " + IntToString(price) + " gold",oPC,FALSE);
        }
        else if (price < 0)
        {
            GiveGoldToCreature(oPC,-price);
            FloatingTextStringOnCreature("Through your shrewdness you have gained " +  IntToString(-price) + " gold",oPC,FALSE);
        }

         //Clean Up
        SetLocalObject(oPC,"copy",OBJECT_INVALID);
        SetLocalObject(oPC,"original",OBJECT_INVALID);
        SetLocalInt(oPC,"damage_type",0);
        SetLocalInt(oPC,"damage",0);
        SetLocalInt(oPC,"eb",0);
        SetLocalInt(oPC,"mighty",0);
}
////

int GetAmmoMakerValue(object oMaker)
{
    int elemental_bonus = GetLocalInt(oMaker,"elemental_bonus");
    int physical_bonus = GetLocalInt(oMaker,"physical_bonus");
    int elemental_damage = GetLocalInt(oMaker,"elemental_damage");
    int physical_damage = GetLocalInt(oMaker,"physical_damage");
    int mighty = GetLocalInt(oMaker,"mighty");
    int eb = GetLocalInt(oMaker,"eb");

    if (elemental_bonus > 0) elemental_bonus = 1;

    return (elemental_bonus*AMMO_UPGRADE_COST) + (physical_damage*AMMO_UPGRADE_COST) + (eb*AMMO_UPGRADE_COST) + (mighty*AMMO_MIGHTY_COST);
}


void EnhanceAmmoFinish(object oPC);
void EnhanceAmmoFinish(object oPC)
{
    object oMaker = GetLocalObject(oPC,"original");
    object newMaker = GetLocalObject(oPC,"copy");
    //FloatingTextStringOnCreature("enhance: " + IntToString(GetLocalInt(newWep,"elemental_bonus")) + " " + IntToString(GetLocalInt(newWep,"elemental_damage")),oPC);





   // FloatingTextStringOnCreature("elemental: " + IntToString(elemental_bonus) + " " + IntToString(elemental_damage),oPC,FALSE);
   // FloatingTextStringOnCreature("physical: " + IntToString(physical_bonus) + " " + IntToString(physical_damage),oPC,FALSE);


    int startingValue = GetAmmoMakerValue(oMaker);

    int finishingValue =  GetAmmoMakerValue(newMaker);

    int price =  finishingValue - startingValue;
    FloatingTextStringOnCreature("Starting Value: " + IntToString(startingValue) + " gold",oPC,FALSE);
    FloatingTextStringOnCreature("Finishing Value: " + IntToString(finishingValue) + " gold",oPC,FALSE);

        //check to see pc can afford modifications
    int pcGold = GetGold(oPC);

    if (price >= pcGold)
    {
         FloatingTextStringOnCreature("You don't have enough gold!",oPC,FALSE);
         DelayCommand(1.0,DestroyObject(newMaker));
         DeleteLocalObject(oPC,"copy");
         DeleteLocalObject(oPC,"original");
         DeleteLocalInt(oPC,"damage_type");
         DeleteLocalInt(oPC,"damage");
         DeleteLocalInt(oPC,"eb");
         DeleteLocalInt(oPC,"mighty");
         return;
    }
    else
    {
         DestroyObject(oMaker);
         SetLocalInt(newMaker,"isCopy",0);
         object pcMaker = CopyItem(newMaker,oPC,TRUE);
         DelayCommand(1.0,DestroyObject(newMaker));

    }
        //take give gold to pc depending on difference in value before and after modifications
    if (price > 0)
    {
        TakeGoldFromCreature(price,oPC,TRUE);
        FloatingTextStringOnCreature("You have spent " + IntToString(price) + " gold",oPC,FALSE);
    }
        /*else if (price < 0)
        {
            GiveGoldToCreature(oPC,-price);
            FloatingTextStringOnCreature("Through your shrewdness you have gained " +  IntToString(-price) + " gold",oPC,FALSE);
        }    */

         //Clean Up
        DeleteLocalObject(oPC,"copy");
        DeleteLocalObject(oPC,"original");
        DeleteLocalInt(oPC,"damage_type");
        DeleteLocalInt(oPC,"damage");
        DeleteLocalInt(oPC,"eb");
        DeleteLocalInt(oPC,"mighty");
}
//I'm creating a new function, EnhanceAmmoCancel, because when someone selected 'Cancel' while upgrading an
 //ammunition maker, it would perform the upgrade and take the gold rather than cancelling. /Moff
void EnhanceAmmoCancel(object oPC);
void EnhanceAmmoCancel(object oPC)
{
    object oMaker = GetLocalObject(oPC,"original");
    object newMaker = GetLocalObject(oPC,"copy");

         FloatingTextStringOnCreature("You have cancelled your ammunition upgrades",oPC,FALSE);
         DelayCommand(1.0,DestroyObject(newMaker));
         DeleteLocalObject(oPC,"copy");
         DeleteLocalObject(oPC,"original");
         DeleteLocalInt(oPC,"damage_type");
         DeleteLocalInt(oPC,"damage");
         DeleteLocalInt(oPC,"eb");
         DeleteLocalInt(oPC,"mighty");
         return;
    }

    /*
int GetIsAmmoMaker(object oItem)
 {
 string sTag = GetStringLowerCase(GetTag(oItem));
if (sTag == "arrowmaker") return TRUE;
if (sTag == "axemaker")  return TRUE;
if (sTag == "boltmaker") return TRUE;
if (sTag == "bulletmaker") return TRUE;
if (sTag == "dartmaker") return TRUE;
if (sTag == "shurikenmaker") return TRUE;
else return FALSE;
  }     */
