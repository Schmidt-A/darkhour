#include "aps_include"

int StartingConditional()
{
    int iResult;
    object oPlayer = GetPCSpeaker();
    int sID = GetLocalInt(oPlayer, "RDD_ID");
    string sSQL = "SELECT fullrelevel FROM " + "RDD_ID" + " WHERE id='" + IntToString(sID) + "'";
    SQLExecDirect(sSQL);


    if (SQLFetch() == SQL_SUCCESS)
    {
        iResult = (1 == StringToInt(SQLDecodeSpecialChars(SQLGetData(1))));
    }
    else
    {
        iResult = FALSE;
    }

    return iResult;
}
