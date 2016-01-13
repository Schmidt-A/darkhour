#include "nwnx_odbc"

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

object EatBestFoodCandidate(object oPC)
{
    // Loop through food chest, see if we have that food item
    // maintain a "best candidate"
    // Return that at the end of this.
    // Alternatively, if we're a survivalist or picky eater, we have to
    // iterate over the PC inventory and check food fresness.
    return OBJECT_INVALID;
}

float TryEating(object oPC, float fSatisfaction)
{
    string sName = GetName(oPC);
    object oFood = GetBestFoodCandidate(oPC);

    if(oFood != OBJECT_INVALID)
    {
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

    float fNewSatisfaction = fSatisfaction - fLossRate;
    string sNewLevel = DBHungerCategory(FloatToString(fNewSatisfaction));

    // We might need to eat here.
    if(sHungerLevel != sNewLevel)
    {
        if(fNewSatisfaction <= 60.0)
        {
            // Todo:
            float fEatenSatisfaction = TryEating(oPC);

            // if we ate something, this needs to change
            if(fEatenSatisfaction > fNewSatisfaction)
            {
                fNewSatisfaction = fEatenSatisfaction;
                sNewLevel = DBHungerCategory(FloatToString(fNewSatisfaction));
            }
        }
        SendMessageToPC(oPC, GetName(oPC) + " is now " + sNewLevel + ".");
        
        // We also might have starvation penalties to apply
        // HandleStarvation()
        // Set level local vars to mark that we've applied penalties
        // for a given category
        SetLocalFloat(oPCToken, "fLossRate", fLossRate);
        SetLocalFloat(oPCToken, "sHungerLevel", sNewLevel);
    }
    SetLocalFloat(oPCToken, "fSatisfaction", fNewSatisfaction);
}
