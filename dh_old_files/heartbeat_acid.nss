//::///////////////////////////////////////////////
//:: Name hx_gen_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This will cause damage to the player for
     being in the cold. This is preventable by
     being near a campfire.
*/
//:://////////////////////////////////////////////
//:: Created By: Brad Prince
//:: Created On: July 25, 2003
//:://////////////////////////////////////////////
void AgeFood(object oPC)
{
    int nCharges;
    int nNumberSpoiled = 0;
    object oFood = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oFood))
    {
        if (GetTag(oFood) == "Food")
        {
            nCharges = GetItemCharges(oFood);
            if (nCharges <= 1)
            {
                if (GetName(oFood) != "Purified Food")
                {
                    nNumberSpoiled += 1;
                }
                DestroyObject(oFood);
                SendMessageToPC(oPC,"Some food has spoiled.");
            }
            else
            {
                SetItemCharges(oFood,(nCharges - 1));
            }
        }
        else if (GetTag(oFood) == "SpoiledFood")
        {
            nCharges = GetItemCharges(oFood);
            if (nCharges <= 1)
            {
                DestroyObject(oFood);
            }
            else
            {
                SetItemCharges(oFood,(nCharges - 1));
            }
        }
        oFood = GetNextItemInInventory(oPC);
    }
    FloatingTextStringOnCreature("The dank vault air is spoiling your food.",oPC,FALSE);
    while (nNumberSpoiled > 0)
    {
        CreateItemOnObject("spoiledfood",oPC);
        nNumberSpoiled -= 1;
    }
}
#include "acidfood"
void main()
{

//acid damage
object oPC = GetFirstPC();
    int iDamage = Random(9) + 1;

    HXDoColdDamage(iDamage);

    if(GetIsObjectValid(oPC))
    {
        oPC = GetNextPC();
    }
    //foodclearing
    int nSpoilTimer = GetLocalInt(OBJECT_SELF,"spoiltimer");
    nSpoilTimer += 1;

    object oItem = GetFirstObjectInArea();
    object oInside;
    int nDecay;
    while (oItem != OBJECT_INVALID)
    {
//      if ((GetTag(oItem) == "Food") || (GetTag(oItem) == "Spoiled"))
        if (GetObjectType(oItem) == OBJECT_TYPE_ITEM)
        {
            DestroyObject(oItem);
        }
        if ((GetObjectType(oItem) == OBJECT_TYPE_PLACEABLE) && ((GetName(oItem) == "Remains") || (GetName(oItem) == "Player Corpse") || (GetName(oItem) == "Player Gear")))
        {
            nDecay = GetLocalInt(oItem,"decay") + 1;
            if (nDecay >= 480)
            {
                oInside = GetFirstItemInInventory(oItem);
                while (oInside != OBJECT_INVALID)
                {
                    DestroyObject(oInside);
                    oInside = GetNextItemInInventory(oItem);
                }
                DestroyObject(oItem);
            }
            else
            {
                SetLocalInt(oItem,"decay",nDecay);
            }
        }
        if ((GetIsPC(oItem) == TRUE) && (nSpoilTimer >= 10))
        {
            AgeFood(oItem);
        }
        oItem = GetNextObjectInArea();
    }

    if (nSpoilTimer >= 10)
    {
        SetLocalInt(OBJECT_SELF,"spoiltimer",0);
    }
    else
    {
        SetLocalInt(OBJECT_SELF,"spoiltimer",nSpoilTimer);
    }
}
