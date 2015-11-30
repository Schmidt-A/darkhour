#include "aps_include"

void DBLogin(object oPC);
void DBLogout(object oPC);
object GetPCObjectByName(string sName);

void DBLogin(object oPC)
{
    string sSafeName = SQLEncodeSpecialChars(GetName(oPC));
    string sQuery = "SELECT 1 FROM player WHERE name='" + sSafeName + "';";

    // See if this is the player's first login. First case = first login.
    SQLExecDirect(sQuery);
    if(SQLFetch() == SQL_ERROR)
    {
        sQuery = "INSERT INTO player (name, satisfaction, login_status, is_ic) " +
                 "VALUES ('" + sSafeName + "', 100.0, 1, 1);";
    }
    else
    {
        sQuery = "UPDATE player " +
                 "SET login_status = 1 " +
                 "WHERE name = '" + sSafeName + "';";
    }
    SQLExecDirect(sQuery);
}

void DBLogout(object oPC)
{
    string sSafeName = SQLEncodeSpecialChars(GetName(oPC));
    SQLExecDirect("UPDATE player " +
                  "SET login_status = 0 " +
                  "WHERE name = '" + sSafeName + "';"
    );
}

object GetPCObjectByName(string sName)
{
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        if(GetName(oPC) == sName)
            return oPC;
        oPC = GetNextPC();
    }
    return OBJECT_INVALID;
}
