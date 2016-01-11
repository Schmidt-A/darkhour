#include "nwnx_odbc"
#include "nwnx_funcs"

void main()
{
    object oPC          = OBJECT_SELF;
    object oBardToken   = GetItemPossessedBy(oPC, "bard_boosts");
    string sConvPos     = IntToString(GetLocalInt(oPC, "iConvPos"));

    SQLExecDirect("SELECT skill_id FROM conv_bardskills " +
                  "WHERE conv_id = " + sConvPos + ";");
    if(SQLFetch() == SQL_SUCCESS)
    {
        int iSkillID = StringToInt(SQLGetData(1));
        ModifySkillRank(oPC, iSkillID, 5);
        SetLocalInt(oBardToken, "iSkillID", iSkillID);
    }
}
