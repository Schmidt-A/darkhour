#include "aps_include"

int StartingConditional()
{
    int iResult;

    string sAccount = GetPCPlayerName(GetPCSpeaker());
    sAccount = SQLEncodeSpecialChars(sAccount);
    string sCharName = GetName(GetPCSpeaker());
    sCharName = SQLEncodeSpecialChars(sCharName);
    int sID;
    string sSQL = "SELECT id FROM " + "RDD_ID" + " WHERE account='" + sAccount +
        "' AND charname='" + sCharName + "'";
    SQLExecDirect(sSQL);

    if (SQLFirstRow() == SQL_SUCCESS)
    {
        sID = StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
        iResult = TRUE;
        SetLocalInt(GetPCSpeaker(), "RDD_ID", sID);
    }
    else
    {
        SetLocalInt(GetPCSpeaker(), "RDD_ID", 0);
        iResult = FALSE;
    }

    return iResult;
}
