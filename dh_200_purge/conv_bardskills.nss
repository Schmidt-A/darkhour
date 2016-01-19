#include "nwnx_odbc"
#include "nwnx_funcs"

void main()
{
    object oPC          = OBJECT_SELF;
    object oPCToken   = GetItemPossessedBy(oPC, "bard_boosts");
    string sConvPos     = IntToString(GetLocalInt(oPC, "iConvPos"));

    /* This is a really simple table that just maps the conversational skill
     * option positions to the NWN skill IDs.
     * We fetch that mapped ID and then increment it. */
    SQLExecDirect("SELECT skill_id FROM conv_bardskills " +
                  "WHERE conv_id = " + sConvPos + ";");
    if(SQLFetch() == SQL_SUCCESS)
    {
        int iSkillID = StringToInt(SQLGetData(1));
        ModifySkillRank(oPC, iSkillID, 5);
        /* Keep track of what skill they chose to increase, since we may have
         * to increase it for them at later levels. */
        SetLocalInt(oPCToken, "iSkillID", iSkillID);
    }
}
