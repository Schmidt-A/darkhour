#include "aps_include"
#include "inc_rules"

void main()
{
    object oPlayer = GetPCSpeaker();
    int sID = GetLocalInt(oPlayer, "RDD_ID");
    string sSQL = "SELECT charlevel FROM " + "RDD" + " WHERE rdd_id='" + IntToString(sID) + "' AND WHERE rddlevel='"
        + IntToString(1) + "'";
    SQLExecDirect(sSQL);

    if(SQLFetch() == SQL_SUCCESS)
    {
        string stat = GetLocalString(oPlayer, "RDD_1");
        int exp = GetXP(oPlayer);
        int chlevel = StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
        int nNewXP = GetXPRequiredForLevel(chlevel);
        SetXP(oPlayer, nNewXP);
        SetXP(oPlayer, exp);
    }

}
