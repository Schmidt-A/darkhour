// Include file for the CriminalRecorder system.

// Made by: Xargoth

#include "aps_include"

//Make the CriminalRecordEntry
//List of crime values:
//0 = Warning
//1 = Penguinization
//2 = Boot
//3 = 2 Day Ban
//4 = PermaBan
int CriminalRecordEntry(object oTarget, object oGM, string Descr, int crime);
//returns the sum of bans and boots
int GetCriminalRecords(object oTarget);
int PopulatePlayerData(object oPC);

int PopulatePlayerData(object oPC)
{
if(GetIsPC(oPC) != TRUE) { return 0; }
string CDKey = GetPCPublicCDKey(oPC);
string Account = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
string SQL = "INSERT INTO PlayerData (cdkey, account, WMGMAD) VALUES('" + CDKey + "', '" + Account + "', 0)";
string tSQL = "SELECT id FROM PlayerData WHERE cdkey = '"+ CDKey +"'";
SQLExecDirect(tSQL);
if(SQLFetch() == SQL_SUCCESS) { return 0; }
SQLExecDirect(SQL);
return 1;
}

int GetPlayerID(object oPC)
{
string SQL="SELECT id FROM PlayerData WHERE cdkey = '" + GetPCPublicCDKey(oPC) + "'";
SQLExecDirect(SQL);
if(SQLFetch() == SQL_SUCCESS)
    {
    return StringToInt(SQLGetData(1));
    }
else return 0;
}

string GetPlayerRecordedAccount(int iPlayer)
{
string SQL = "SELECT account FROM PlayerData WHERE id = " + IntToString(iPlayer);
SQLExecDirect(SQL);
if(SQLFetch() == SQL_SUCCESS)
    {
    return SQLDecodeSpecialChars(SQLGetData(1));
    }
else return "";
}


int CriminalRecordEntry(object oTarget, object oGM, string Descr, int crime)
{
int i = PopulatePlayerData(oGM);
i = PopulatePlayerData(oTarget);
int Player = GetPlayerID(oTarget);
int GM = GetPlayerID(oGM);
if(GetPCPlayerName(oTarget) != GetPlayerRecordedAccount(Player))
    {
    Descr = GetPCPlayerName(oTarget) + " is an alias of this player. " + Descr;
    }
string SQL = "INSERT INTO CriminalRecord (playerid, crime, descr, gm) VALUES(" + IntToString(Player) + ", " + IntToString(crime) + ", '" + Descr + "', " + IntToString(GM) + ")";
SQLExecDirect(SQL);
if(SQLFetch() == SQL_SUCCESS) { return 1; }
else return 0;
}

int GetCriminalRecords(object oTarget)
{
    int crimes = 0;
    string SQL = "SELECT COUNT(*) FROM CriminalRecord WHERE playerid = " + IntToString(GetPlayerID(oTarget)) + " AND crime IN (2,3,4)";
    SQLExecDirect(SQL);
    if(SQLFetch() == SQL_SUCCESS)
    {
        crimes = StringToInt(SQLGetData(1));
    }
    return crimes;
}
