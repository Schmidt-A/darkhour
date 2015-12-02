#include "aps_include"

void main()
{
    object oPlayer = GetPCSpeaker();
    int sID = GetLocalInt(oPlayer, "RDD_ID");
    string sSQL = "SELECT rddlevel FROM " + "RDD" + " WHERE rdd_id='" + IntToString(sID) + "'";
    SQLExecDirect(sSQL);


    if (SQLFetch() == SQL_SUCCESS)
    {
        SendMessageToPC(oPlayer, "You have RDD Level " + SQLDecodeSpecialChars(SQLGetData(1)) + " stored.");
    }

}
