#include "nwnx_odbc"
#include "nwnx_hashset"
#include "_incl_session"
#include "_incl_globvars"

void DBUpdateHunger();
void DoEating();
void DoPenalties();

object GetBestFood(object oPC)
{
    return GetItemPossessedBy(oPC, "food");
}

void DBEatFood(object oPC, object oFood)
{
    string sFood = GetName(oFood);
    string sName = GetName(oPC);
    PrintString("In DBEatFood");

    //TODO: actual values
    SQLExecDirect("UPDATE player " +
                  "SET satisfaction = satisfaction + 15.0 " +
                  "WHERE name = '" + SQLEncodeSpecialChars(sName) +"';"
                  );
    SQLExecDirect("SELECT level from player, hunger_const " +
                  "WHERE satisfaction BETWEEN min AND max;"
                  );
    SQLFetch();
    SendMessageToPC(oPC, (sName + " ate their " + sFood +
                   " and now has a hunger level of " + SQLGetData(1) + ".")
                   );

}

void DoEating()
{
    string sKey = HashSetGetFirstKey(GetModule(), "EATING_HASHSET");
    object oPC;
    PrintString("In DoEating");
    do
    {
        oPC = GetPCObjectByName(sKey);
        PrintString("In hash thing");
        DBEatFood(oPC, GetBestFood(oPC));
        // todo - delete key here
        sKey = HashSetGetNextKey(GetModule(), "EATING_HASHSET");
    } while(HashSetHasNext(GetModule(), "EATING_HASHSET"));
}

void DBUpdateHunger()
{
    float   fHungryAt;
    float   fSatisfaction;
    int     bHasFood;
    object  oPC;
    string  sName;
    string  sLevel;

    // Sanity check - make sure we're not doing this if we have no player records.
    SQLExecDirect("SELECT 1 FROM player;");
    if(SQLFetch() == SQL_ERROR)
        return;

    // First, figure out who's switching to a new hunger tier.
    // We have to handle eating + penalties after we're doing because we can't
    // have nested SQL commands.
    SQLExecDirect("SELECT name, new_satisfaction, level FROM pc_willchange_hunger");
    while(SQLFetch() == SQL_SUCCESS)
    {
        sName = SQLDecodeSpecialChars(SQLGetData(1));
        fSatisfaction = StringToFloat(SQLGetData(2));
        sLevel = SQLGetData(3);
        oPC = GetPCObjectByName(sName);
        if(fSatisfaction <= 60.0)
        {
            if(GetItemPossessedBy(oPC, "food") != OBJECT_INVALID)
                HashSetSetLocalString(GetModule(), "EATING_HASHSET", sName, "");
            else if(fSatisfaction < RAVENOUS_AT)
                HashSetSetLocalString(GetModule(), "EATING_HASHSET", sName, sLevel);
        }
        else
            SendMessageToPC(oPC, sName + "'s hunger level is now " + sLevel + ".");
    }

    SQLExecDirect("UPDATE player, hunger_const " +
                  "SET satisfaction = satisfaction-hunger_const.loss_rate " +
                  "WHERE " +
                         "player.login_status = 1 " +
                         "AND player.satisfaction BETWEEN hunger_const.min AND hunger_const.max;"
    );

    if(HashSetGetSize(GetModule(), "EATING_HASHSET") > 0)
        DoEating();
    //DoPenalties();

    SQLExecDirect("COMMIT;");
    SQLExecDirect("START TRANSACTION;");
}
