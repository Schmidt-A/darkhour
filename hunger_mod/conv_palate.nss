#include "nwnx_odbc"

void main()
{
    object oPC          = OBJECT_SELF;
    object oPCToken     = GetItemPossessedBy(oPC, "token_pc");
    string sConvPos     = IntToString(GetLocalInt(oPC, "iConvPos"));

    // Maps conversation IDs to their respective palates.
    SQLExecDirect("SELECT palate, disliked FROM conv_palate " +
                  "WHERE conv_id = " + sConvPos + ";");
    if(SQLFetch() == SQL_SUCCESS)
    {
        SetLocalInt(oPCToken, "iPalate", StringToInt(SQLGetData(1)));
        SetLocalInt(oPCToken, "iDisliked", StringToInt(SQLGetData(2)));
    }
}
