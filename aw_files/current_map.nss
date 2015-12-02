#include "aps_include"
void main()
{
    string sql = "UPDATE Settings SET value = '" +
                 GetName(GetObjectByTag("arena_" + IntToString(GetLocalInt(GetModule(), "nRound")))) +
                 "' WHERE name = 'CURRENT_MAP'";
    WriteTimestampedLogEntry("sql = " + sql);
    SQLExecDirect(sql);
}
