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
#include "coldfood"
void main()
{
    object oPC = GetFirstPC();
    int iDamage = Random(9) + 1;

    HXDoColdDamage(iDamage);

    if(GetIsObjectValid(oPC))
    {
        oPC = GetNextPC();
    }
    //FoodClearing
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
            if (nDecay >= 1440)
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
        oItem = GetNextObjectInArea();
    }
}
