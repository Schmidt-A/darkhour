#include "aps_include"

int StartingConditional()
{
    int iResult;
    object oPlayer = GetPCSpeaker();
    int sID = GetLocalInt(oPlayer, "RDD_ID");
    string sSQL = "SELECT stats FROM " + "RDD" + " WHERE rdd_id='" + IntToString(sID) + "' AND WHERE rddlevel='"
        + IntToString(1) + "'";
    SQLExecDirect(sSQL);

    if(SQLFetch() == SQL_SUCCESS)
    {
        SetLocalString(oPlayer, "RDD_1", SQLDecodeSpecialChars(SQLGetData(1)));
        iResult = TRUE;
    }
    else
    {
        iResult = FALSE;
    }
    if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPlayer) < 1)
    {
        iResult = FALSE;
    }
    return iResult;
}
