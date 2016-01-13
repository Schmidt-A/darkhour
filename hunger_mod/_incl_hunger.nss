#include "nwnx_odbc"

string FOOD_CHEST_ALL       = "fc_all";
string FOOD_CHEST_ORGANIC   = "fc_0";
string FOOD_CHEST_SWEET     = "fc_1";
string FOOD_CHEST_MEAT      = "fc_2";
string FOOD_CHEST_GENERAL   = "fc_3";
string FOOD_CHEST_RAW       = "fc_raw";
string FOOD_CHEST_SPOILED   = "fc_spoiled";

int FOOD_RAW = 4;

float RAVENOUS = 30.0;
float DEATHS_DOOR = 10.0;

float DISLIKE_MODIFIER = 0.75;
float LIKE_MODIDIFER   = 1.5;

string DBHungerCategory(string sSatisfaction)
{
    string sDBCategory = "";
    SQLExecDirect("SELECT level FROM hunger_const " +
                  "WHERE " + sSatisfaction + " BETWEEN min AND max;");
    if(SQLFetch == SQL_SUCCESS)
        sDBCategory = SQLGetData(1);
    else
    {
        WriteTimestampedLogEntry("ERROR: Failed to SELECT from table " +
                                 "hunger_const"); 
    }
    return sDBCategory;
}

object ChestLoop(object oChest, object oPC)
{
    object oFood = OBJECT_INVALID;
    object oFoodBP = GetFirstItemInInventory(oChest);
    while(GetIsObjectValid(oFoodBP))
    {
        oFood = GetItemPossessedBy(oPC, GetTag(oFoodBP));
        if(oFood != OBJECT_INVALID)
            break;
        oFoodBP = GetNextItemInInventory(oChest);
    }
    return oFood;
}

object GeneralFood(object oPC, bGlutton=FALSE)
{
    object oFood = OBJECT_INVALID;
    object oChest = GetObjectByTag(FOOD_CHEST_ALL);
    object oFoodBP = GetFirstItemInInventory(oChest);

    // Todo: add raw food
    while(GetIsObjectValid(oFoodBP))
    {
        oFood = GetItemPossessedBy(oPC, GetTag(oFoodBP));
        // Generalists don't care, just get the first food and eat.
        if(oFood != OBJECT_INVALID && GetLocalInt(oFood, "iType") != FOOD_RAW)
            break;
        oFoodBP = GetNextItemInInventory(oChest);
    }

    if(oFood != OBJECT_INVALID)
        return oFood;

    // Most desperate - if we're on death's door we can try to eat raw food
    oChest = GetObjectByTag(FOOD_CHEST_RAW)
    return ChestLoop(oChest, oPC);
}

object SpecificFood(oPC, iPalate, iDisliked)
{
    object oChest = GetObjectByTag("fc_" + IntToString(iPalate));
    int i;

    // Try the favorite chest first
    object oFood = ChestLoop(oChest, oPC);

    // Found a favorite - eat it
    if(oFood != OBJECT_INVALID)
        return oFood;

    // Otherwise we're gunna try the others we don't hate
    for(i=0; i<3; i++)
    {
        // Skip this chest if it's our favorite - we would've already looked
        if(i == iPalate || i == iDisliked)
            continue;

        oChest = GetObjectByTag("fc_" + IntToString(i))
        oFood = ChestLoop(oChest, oPC);
    }
    // Found something to eat - eat it
    if(oFood != OBJECT_INVALID)
        return oFood;

    // Getting desperate here - try the food that we hate
    oChest = GetObjectByTag("fc_" + IntToString(iDisliked));
    oFood = ChestLoop(oChest, oPC);

    if(oFood != OBJECT_INVALID)
        return oFood;

    // Most desperate - if we're on death's door we can try to eat raw food
    oChest = GetObjectByTag(FOOD_CHEST_RAW)
    return ChestLoop(oChest, oPC);
}

object SurvivalistFood(object oPC)
{
    object oItem = GetFirstItemInInventory();
    object oFood = OBJECT_INVALID;
    object oSpoiled = OBJECT_INVALID;
    int iLowestFreshness = 100;

    // Survivalists get rid of the most stale food first
    while(oItem != OBJECT_INVALID)
    {
        iFreshness = GetLocalInt(oItem, "iFreshness");
        // Not a food, don't care
        if(iFressness == 0)
            continue;

        if(iFreshness < iLowestFreshness)
        {
           oFood = oItem;
           iLowestFreshness = iFressness;
        }
        // Save this in case this is our second best option
        if(oSpoiled == OBJECT_INVALID && GetTag(oItem) == "food_spoiled")
            oSpoiled = oItem;

        oItem = GetNextItemInInventory(oPC);
    }

    if(oFood == OBJECT_INVALID)
        oFood = oSpoiled;

    return oFood;
}

int FreshnessPercentage(object oFood)
{
    int iFreshness = GetLocalInt(oFood, "iFreshness");
    int iMaxFresness = GetLocalInt(oFood, "iMaxFreshness");

    return (iFreshness / iMaxFreshness) * 100;
}

object PickyFood(object oPC)
{
    object oItem = GetFirstItemInInventory();
    object oFood = OBJECT_INVALID;
    int iHighestFreshness = 0;

    // Picky eaters eat the freshest food first
    while(oItem != OBJECT_INVALID)
    {
        iFreshness = GetLocalInt(oItem, "iFreshness");
        // Not a food, don't care
        if(iFressness == 0)
            continue;

        if(iFreshness > iHighestFreshness)
        {
            oFood = oItem;
            iHighestFreshness = iFreshness;
        }
        oItem = GetNextItemInInventory(oPC);
    }

    if(oFood != OBJECT_INVALID)
        return oFood;

    // Most desperate - if we're on death's door we can try to eat raw food
    oChest = GetObjectByTag(FOOD_CHEST_RAW)
    return ChestLoop(oChest, oPC);
}

float EatRaw(object oPC, object oFood)
{
    float fFoodSatisfaction = 3.33;
    SendMessageToPC(oPC, "Eating your " + GetName(oFood) + " has allowed you" +
                         " to hang on just a little longer."
    DestroyObject(oFood);
    return fFoodSatisfaction
}

object EatBestFoodCandidate(object oPC, float fSatisfaction, 
                            int iPalate, int iDisliked)
{
    string sName = GetName(oPC);
    object oFood = OBJECT_INVALID;
    float fNewSatisfaction = fSatisfaction;
    float fFoodSatisfaction = 0.00;

    switch(iPalate)
    {
        case 3: // Generalist
            oFood = GeneralFood(oPC);
            if(oFood != OBJECT_INVALID)
            {
                // Only willing to eat this if we're at death's door
                if(GetLocalInt(oFood, "iType") == FOOD_RAW &&
                    fSatisfaction < DEATHS_DOOR)
                    fFoodSatisfaction = EatRaw(oPC, oFood);
                else
                {
                    fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction")
                    DestroyObject(oFood);
                    SendMessageToPC(oPC, sName + " eats their " +
                        GetName(oFood) + ".";
                }
            }
            break;

        case 4: // Glutton - basically behaves the same way as a generalist
            oFood = GeneralFood(oPC);
            if(oFood != OBJECT_INVALID)
            {
                if(GetLocalInt(oFood, "iType") == FOOD_RAW &&
                    fSatisfaction < DEATHS_DOOR)
                    fFoodSatisfaction = EatRaw(oPC, oFood);
                else
                {
                    // Gluttons love eeeeverything
                    fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction") * LIKE_MODIFIER;
                    DestroyObject(oFood);
                    SendMessageToPC(oPC, sName + " eats their " +
                        GetName(oFood) + ". Mmmm food.";
                }
            }
            break;

        case 5: // Survivalist
            oFood = SurvivalistFood(oPC);
            if(oFood != OBJECT_INVALID)
            {
                fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction");
                DestroyObject(oFood);
                SendMessageToPC(oPC, sName + " eats their " + GetName(oFood) + ".";
                // TODO: Apply -1 to fort save
            }
            break;

        case 6: // Picky Eater
            oFood = PickyFood(oPC);
            if(oFood != OBJECT_INVALID)
            {
                if(GetLocalInt(oFood, "iType") == FOOD_RAW &&
                    fSatisfaction < DEATHS_DOOR)
                    fFoodSatisfaction = EatRaw(oPC, oFood);
                else
                {
                    // Will only eat stale food if they're REALLY hungry.
                    if(FreshnessPercentage(oFood) < 50 &&
                        fSatisfaction <= RAVENOUS)
                    {
                        fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction") * DISLIKE_MODIFIER;
                        DestroyObject(oFood);
                        SendMessageToPC(oPC, sName + " grudgingly chokes" + 
                            " down their spoiling " + GetName(oFood) " and feels" +
                            " nausiated for it.");
                        // TODO: penalty here
                    }
                    else if (FreshnessPercentage(oFood) < 50)
                    {
                        SendMessageToPC(oPC, sName + " is hungry but can't " +
                            "bring themselves to eat any of their spoiling food.";
                    }
                    else
                    {
                        fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction") * LIKE_MODIFIER;
                        DestroyObject(oFood);
                        SendMessageToPC(oPC, sName + " eats their " +
                            GetName(oFood) + ". Delicious!";
                        // TODO: buff
                    }
                }
            }
            break;

        default: // Vegetarians/Carnvores/Sweet Tooths
            oFood = SpecificFood(oPC, iPalate, iDisliked);
            if(oFood != OBJECT_INVALID)
            {
                if(GetLocalInt(oFood, "iType") == FOOD_RAW &&
                    fSatisfaction < DEATHS_DOOR)
                    fFoodSatisfaction = EatRaw(oPC, oFood);
                else
                {
                    if(GetLocalInt(oFood, "iType") == iDisliked)
                    {
                        if(fSatisfaction < DEATHS_DOOR)
                        {
                            fFoodSatisfaction = GetLocalFloat(oFood,
                                "fSatisfaction") * DISLIKE_MODIFIER;
                            SendMessageToPC(oPC, sName + " cannot stand their " +
                                GetName(oFood) + " but forces it down, leaving " +
                                "them feeling sickened.";
                            DestroyObject(oFood);
                            // TODO: penalties
                        }
                        else
                        {
                            SendMessageToPC(oPC, sName + " is hungry but does" +
                                " not want to eat any of their food.");
                        }
                    }
                    else if(GetLocalInt(oFood, "iType") == iPalate)
                    {
                        fFoodSatisfaction = GetLocalFloat(oFood,
                            "fSatisfaction") * LIKE_MODIFIER;
                        SendMessageToPC(oPC, sName + " eats their " +
                            GetName(oFood) + ", thoroughly enjoying it.");
                            DestroyObject(oFood);
                        // TODO: buffs
                    }
                    else
                    {
                        fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction");
                        SendMessageToPC(oPC, sName + " eats their " +
                            GetName(oFood) + ".");
                        DestroyObject(oFood);
                    }
                }
            }
            break;
    }

    fNewSatisfaction += fFoodSatisfaction;
    return fNewSatisfaction;
}

float TryEating(object oPC, float fSatisfaction, int iPalate, int iDisliked)
{
    string sName = GetName(oPC);

    if(oFood != OBJECT_INVALID)
    {
        // need raw check here
        float fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction");
        SendMessageToPC(sName + " ate their [eaten item].");
        fSatisfaction += fFoodSatisfaction;
    }
    return fSatisfaction;
}

void DBUpdateHunger(object oPC)
{
    object oPCToken = GetItemPossessedBy(oPC, "token_pc");

    float fSatisfaction = GetLocalFloat(oPCToken, "fSatisfaction");
    float fLossRate = GetLocalFloat(oPCToken, "fLossRate");
    string sHungerLevel = GetLocalString(oPCToken, "sHungerLevel");

    float fSatisfaction = fSatisfaction - fLossRate;
    string sNewLevel = DBHungerCategory(FloatToString(fSatisfaction));

    // We might need to eat here.
    if(sHungerLevel != sNewLevel)
    {
        int iPalate = GetLocalInt(oPCToken, "iPalate");

        float fEatAt = 60.0;
        // Gluttons eat at 80 instead of 60
        if(iPalate == 4)
            fEatAt = 80.0;

        if(fNewSatisfaction <= fEatAt)
        {
            int iDisliked = GetLocalInt(oPCToken, "iDisliked");
            float fEatenSatisfaction = EatBestFoodCandidate(oPC, fSatisfaction,
                                       iPalate, iDisliked);
            // if we ate something, this needs to change
            if(fEatenSatisfaction > fSatisfaction)
            {
                fSatisfaction = fEatenSatisfaction;
                sNewLevel = DBHungerCategory(FloatToString(fSatisfaction));
            }
        }
        SendMessageToPC(oPC, GetName(oPC) + " is now " + sNewLevel + ".");
        
        // We also might have starvation penalties to apply
        // TODO: HandleStarvation()
        // TODO: Set level local vars to mark that we've applied penalties
        // for a given category
        SetLocalFloat(oPCToken, "fLossRate", fLossRate);
        SetLocalFloat(oPCToken, "sHungerLevel", sNewLevel);
    }
    SetLocalFloat(oPCToken, "fSatisfaction", fNewSatisfaction);
}
