#include "nwnx_odbc"

string FOOD_CHEST_ALL       = "fc_all";
string FOOD_CHEST_ORGANIC   = "fc_0";
string FOOD_CHEST_SWEET     = "fc_1";
string FOOD_CHEST_MEAT      = "fc_2";
string FOOD_CHEST_GENERAL   = "fc_3";
string FOOD_CHEST_RAW       = "fc_raw";
string FOOD_CHEST_SPOILED   = "fc_spoiled";

int FOOD_ORGANIC = 0;
int FOOD_SWEET   = 1;
int FOOD_MEAT    = 2;
int FOOD_GENERAL = 3;
int FOOD_RAW     = 4;

float RAVENOUS = 30.0;
float DEATHS_DOOR = 10.0;

float DISLIKE_MODIFIER = 0.75;
float LIKE_MODIFIER   = 1.5;

/*-------------- Helper Functions ---------------*/
object  ChestLoop(object oChest, object oPC);
float   EatRaw(object oPC, object oFood);
int     FreshnessPercentage(object oFood);

/*-------------- Palate Functions ---------------*/
object GeneralFood(object oPC);
object SurvivalistFood(object oPC);
object PickyFood(object oPC);
object SpecificFood(object oPC, int iPalate, int iDisliked);

/*-------------- Food Functions -----------------*/
void DBInitFood();

/*-------------- System Functions ---------------*/
void DBInitChest(object oChest);
void DBInitFood();
string DBHungerCategory(string sSatisfaction);
float  DBGetLossRate(string sLevel);
int    DBGetLevel(string sLevel);
float EatBestFoodCandidate(object oPC, float fSatisfaction,
                            int iPalate, int iDisliked);
void HandleStarvation(object oPC, object oPCToken, string sLevel);

/*-------------- Driver Function ----------------*/
void UpdateHunger(object oPC, int bAcquire=FALSE);


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

float EatRaw(object oPC, object oFood)
{
    float fFoodSatisfaction = 3.33;
    SendMessageToPC(oPC, "Eating your " + GetName(oFood) + " has allowed you" +
                         " to hang on just a little longer.");
    DestroyObject(oFood);
    return fFoodSatisfaction;
}

int FreshnessPercentage(object oFood)
{
    int iFreshness = GetLocalInt(oFood, "iFreshness");
    int iMaxFreshness = GetLocalInt(oFood, "iMaxFreshness");

    return (iFreshness / iMaxFreshness) * 100;
}

object GeneralFood(object oPC)
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
    return ChestLoop(GetObjectByTag(FOOD_CHEST_RAW), oPC);
}

object SpecificFood(object oPC, int iPalate, int iDisliked)
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

        oChest = GetObjectByTag("fc_" + IntToString(i));
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
    return ChestLoop(GetObjectByTag(FOOD_CHEST_RAW), oPC);
}

object SurvivalistFood(object oPC)
{
    object oItem = GetFirstItemInInventory();
    object oFood = OBJECT_INVALID;
    object oSpoiled = OBJECT_INVALID;
    int iLowestFreshness = 100;
    int iFreshness = 0;

    // Survivalists get rid of the most stale food first
    while(oItem != OBJECT_INVALID)
    {
        iFreshness = GetLocalInt(oItem, "iFreshness");
        // Not a food, don't care
        if(iFreshness == 0)
            continue;

        if(iFreshness < iLowestFreshness)
        {
           oFood = oItem;
           iLowestFreshness = iFreshness;
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

object PickyFood(object oPC)
{
    object oItem = GetFirstItemInInventory();
    object oFood = OBJECT_INVALID;
    int iHighestFreshness = 0;
    int iFreshness = 0;

    // Picky eaters eat the freshest food first
    while(oItem != OBJECT_INVALID)
    {
        iFreshness = GetLocalInt(oItem, "iFreshness");
        // Not a food, don't care
        if(iFreshness == 0)
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
    return ChestLoop(GetObjectByTag(FOOD_CHEST_RAW), oPC);
}

void DBInitChest(object oChest)
{
    while(SQLFetch() == SQL_SUCCESS)
    {
        string sRef = SQLGetData(1);
        object oFood = CreateItemOnObject(sRef, oChest, 1, SQLGetData(5));
        SetLocalInt(oFood, "iType", StringToInt(SQLGetData(2)));
        SetLocalFloat(oFood, "fSatisfaction", StringToFloat(SQLGetData(3)));
        SetLocalInt(oFood, "iMaxFreshness", StringToInt(SQLGetData(4)));
        // Todo: OnAcquire, set food freshness
    }
}

void DBInitFood()
{
    // All chest
    object oChest = GetObjectByTag(FOOD_CHEST_ALL);
    SQLExecDirect("SELECT resref, type, satisfaction, max_freshness, tag FROM food;");
    DBInitChest(oChest);

    // Organic chest
    oChest = GetObjectByTag(FOOD_CHEST_ORGANIC);
    SQLExecDirect("SELECT resref, type, satisfaction, max_freshness, tag FROM food " +
                  "WHERE type = " + IntToString(FOOD_ORGANIC) + ";");
    DBInitChest(oChest);
}

string DBHungerCategory(string sSatisfaction)
{
    string sDBCategory = "";
    SQLExecDirect("SELECT level FROM hunger_const " +
                  "WHERE " + sSatisfaction + " <= max order by max asc limit 1;");
    if(SQLFetch() == SQL_SUCCESS)
        sDBCategory = SQLGetData(1);
    else
    {
        WriteTimestampedLogEntry("ERROR: Failed to SELECT from table " +
                                 "hunger_const (level)");
        WriteTimestampedLogEntry("SELECT level FROM hunger_const " +
                  "WHERE " + sSatisfaction + " BETWEEN min AND max;");
    }
    return sDBCategory;
}

float DBGetLossRate(string sLevel)
{
    float fLossRate = 0.0;
    SQLExecDirect("SELECT loss_rate FROM hunger_const " +
                  "WHERE level = '" + sLevel + "';");
    if(SQLFetch() == SQL_SUCCESS)
        fLossRate = StringToFloat(SQLGetData(1));
    else
    {
        WriteTimestampedLogEntry("ERROR: Failed to SELECT from table " +
                                 "hunger_const (loss_rate)");
    }
    return fLossRate;
}

int DBGetLevelID(string sLevel)
{
    int iID = 0;
    SQLExecDirect("SELECT id FROM hunger_const " +
                  "WHERE level = '" + sLevel + "';");
    if(SQLFetch() == SQL_SUCCESS)
        iID = StringToInt(SQLGetData(1));
    else
    {
        WriteTimestampedLogEntry("ERROR: Failed to SELECT from table " +
                                 "hunger_const (id)");
    }
    return iID;
}

float EatBestFoodCandidate(object oPC, float fSatisfaction,
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
            SendMessageToPC(oPC, "Generalist case");
            SendMessageToPC(oPC, "food = " + GetTag(oFood));
            if(oFood != OBJECT_INVALID)
            {
                // Only willing to eat this if we're at death's door
                if(GetLocalInt(oFood, "iType") == FOOD_RAW &&
                    fSatisfaction < DEATHS_DOOR)
                    fFoodSatisfaction = EatRaw(oPC, oFood);
                else
                {
                    fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction");
                    DestroyObject(oFood);
                    SendMessageToPC(oPC, sName + " eats their " +
                        GetName(oFood) + ".");
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
                        GetName(oFood) + ". Mmmm food.");
                }
            }
            break;

        case 5: // Survivalist
            oFood = SurvivalistFood(oPC);
            if(oFood != OBJECT_INVALID)
            {
                fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction");
                DestroyObject(oFood);
                SendMessageToPC(oPC, sName + " eats their " + GetName(oFood) + ".");
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
                            " down their spoiling " + GetName(oFood) + " and feels" +
                            " nausiated for it.");
                        // TODO: penalty here
                    }
                    else if (FreshnessPercentage(oFood) < 50)
                    {
                        SendMessageToPC(oPC, sName + " is hungry but can't " +
                            "bring themselves to eat any of their spoiling food.");
                    }
                    else
                    {
                        fFoodSatisfaction = GetLocalFloat(oFood, "fSatisfaction") * LIKE_MODIFIER;
                        DestroyObject(oFood);
                        SendMessageToPC(oPC, sName + " eats their " +
                            GetName(oFood) + ". Delicious!");
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
                                "them feeling sickened.");
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

void HandleStarvation(object oPC, object oPCToken, string sLevel)
{
   int iID = DBGetLevelID(sLevel);

   switch(iID)
   {
        case 7: // Ravenous
            if(GetLocalInt(oPCToken, "bRavenous") == FALSE)
            {
                SetLocalInt(oPCToken, "bRavenous", TRUE);
                // TODO: Apply penalties
                SetLocalInt(oPCToken, "bCanRecoverHunger", FALSE);
            }
            break;
        case 8: // Starving
            if(GetLocalInt(oPCToken, "bStarving") == FALSE)
            {
                SetLocalInt(oPCToken, "bStarving", TRUE);
                // TODO: Apply penalties
                SetLocalInt(oPCToken, "bCanRecoverHunger", FALSE);
            }
        case 9: // Death's Door
            if(GetLocalInt(oPCToken, "bDeathsDoor") == FALSE)
            {
                SetLocalInt(oPCToken, "bDeathsDoor", TRUE);
                // TODO: Apply penalties
                SetLocalInt(oPCToken, "bCanRecoverHunger", FALSE);
                SetLocalInt(oPCToken, "bCanHeal", FALSE);
            }
   }
}

void UpdateHunger(object oPC, int bAcquire=FALSE)
{
    object oPCToken = GetItemPossessedBy(oPC, "token_pc");

    float fSatisfaction = GetLocalFloat(oPCToken, "fSatisfaction");
    float fLossRate = GetLocalFloat(oPCToken, "fLossRate");
    string sHungerLevel = GetLocalString(oPCToken, "sHungerLevel");
    string sNewLevel = sHungerLevel;

    if(!bAcquire)
    {
        fSatisfaction = fSatisfaction - fLossRate;
        sNewLevel = DBHungerCategory(FloatToString(fSatisfaction));
    }

    SendMessageToPC(oPC, "Satisfaction: " + FloatToString(fSatisfaction));
    // We might need to eat here.
    if((sHungerLevel != sNewLevel) || bAcquire)
    {
        int iPalate = GetLocalInt(oPCToken, "iPalate");
        SendMessageToPC(oPC, "Palate = " + IntToString(iPalate));

        float fEatAt = 60.0;
        // Gluttons eat at 80 instead of 60
        if(iPalate == 4)
            fEatAt = 80.0;

        if(fSatisfaction <= fEatAt)
        {
            int iDisliked = GetLocalInt(oPCToken, "iDisliked");
            float fEatenSatisfaction = EatBestFoodCandidate(oPC, fSatisfaction,
                                       iPalate, iDisliked);
            // if we ate something, this needs to change
            if(fEatenSatisfaction > fSatisfaction)
            {
                fSatisfaction = fEatenSatisfaction;
                // Can't go over 100.0
                if(fSatisfaction > 100.0)
                    fSatisfaction = 100.0;
                sNewLevel = DBHungerCategory(FloatToString(fSatisfaction));
            }
        }
        SendMessageToPC(oPC, GetName(oPC) + " is now " + sNewLevel + ".");

        if(!bAcquire)
        {
            // We also might have starvation penalties to apply
            if(fSatisfaction <= RAVENOUS)
                HandleStarvation(oPC, oPCToken, sNewLevel);

            SetLocalString(oPCToken, "sHungerLevel", sNewLevel);
            SetLocalFloat(oPCToken, "fLossRate", DBGetLossRate(sNewLevel));
        }
        // If we were starving but are now satisfied, we can start healing.
        if(!GetLocalInt(oPCToken, "bCanRecoverHunger") && fSatisfaction >= 71.0)
            SetLocalInt(oPCToken, "bCanRecoverHunger", TRUE);
    }
    SetLocalFloat(oPCToken, "fSatisfaction", fSatisfaction);

    // TODO: Death case, fSatisfaction <= 0
}
