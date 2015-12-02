#include "aps_include"

int StartingConditional()
{
    int iResult;
    object oPlayer = GetPCSpeaker();
    int sID = GetLocalInt(oPlayer, "RDD_ID");
    string sSQL = "SELECT stats FROM " + "RDD" + " WHERE rdd_id='" + IntToString(sID) + "' AND WHERE rddlevel='"
        + IntToString(2) + "'";
    SQLExecDirect(sSQL);

    if(SQLFetch() == SQL_SUCCESS)
    {
        SetLocalString(oPlayer, "RDD_2", SQLDecodeSpecialChars(SQLGetData(1)));
        iResult = TRUE;
    }
    else
    {
        iResult = FALSE;
    }
    if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPlayer) < 2)
    {
        iResult = FALSE;
    }
    return iResult;
}
