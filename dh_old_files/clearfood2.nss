// This script will destroy all items on the ground. Additionally it automatically
// cleans up placeable remains and player corpses after 2.4 hours.

// Code commented out by Zunath on July 22, 2007
// Reason: Performance hits due to code.
// coolty3001@yahoo.com if you have questions, I'm happy to help.

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

void main()
{
    int nSpoilTimer = GetLocalInt(OBJECT_SELF,"spoiltimer");
    nSpoilTimer += 1;
    object oPC;
    object oItem = GetFirstObjectInArea();
    object oInside;
    int nDecay;
    int iSkill;
    while (oItem != OBJECT_INVALID)
    {
        // This section ages the food of the player as long as they are
        // in the area.
        if(GetIsPC(oItem))
            {
            if(nSpoilTimer >= 10)
                {
                oPC = oItem;
                AgeFood(oItem);
                }
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
