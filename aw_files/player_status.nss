//********************************************************************
// Player Status, by Vladiat0r
// This script is released under the GPL license (see gpl.txt)
//
// Credits
// Original author: Ingmar Stieger (Papillon)  (papillon@blackdagger.com or istieger@gmx.de)
// Lanthar D'Alton: http://nwvault.ign.com/Files/scripts/data/1064971848910.shtml
// NWNX/ODBC2: http://www.nwnx.org/index.php?id=doc_odbc2
//
// Prerequisites
// You must configure APS/NWNX ODBC2 according to http://www.nwnx.org/index.php?id=doc_odbc2
//
// Instructions
// 1. Add ExecuteScript("player_status", OBJECT_SELF); to your module heartbeat.
// 2. To add additional fields, edit the function below and the status.php
//********************************************************************

#include "aps_include"
#include "aw_include"

const string DELIMITER = "!";

//copied from aps_include, must use this if you add custom text data
string MySQLEncodeSpecialChars(string sString);

void UpdatePlayerStatus(object oPC)
{
    //INSERT INTO player_status (data) VALUES('account!name!0!1!1!0!10!10!0')
    SQLExecDirect("INSERT INTO player_status(data) VALUES('" +
    MySQLEncodeSpecialChars(GetPCPlayerName(oPC)) + DELIMITER +
    MySQLEncodeSpecialChars(GetName(oPC)) + DELIMITER +
    IntToString(GetIsDM(oPC)) + DELIMITER +
    IntToString(GetClassByPosition(1, oPC)) + DELIMITER +  //3
    IntToString(GetClassByPosition(2, oPC)) + DELIMITER +  //4
    IntToString(GetClassByPosition(3, oPC)) + DELIMITER +  //5
    IntToString(GetLevelByPosition(1, oPC)) + DELIMITER +      //6
    IntToString(GetLevelByPosition(2, oPC)) + DELIMITER +      //7
    IntToString(GetLevelByPosition(3, oPC)) + DELIMITER +      //8
//***************************************************************************
//***************************************************************************
// Concatenate any additional data here as strings, separated by DELIMITER
// Don't forget to use MySQLEncodeSpecialChars for string data
    IntToString(GetIsWingedGod(oPC)) + DELIMITER +
    IntToString(GetIsGMNormalChar(oPC) || GetIsGM(oPC) || GetIsDMAW(oPC)) + DELIMITER +
    IntToString(GetLocalInt(oPC, "m_nKills")) + DELIMITER +
    IntToString(GetLocalInt(oPC, "m_nDeaths")) + DELIMITER +
    IntToString(GetLocalInt(oPC, "nTeam")) + DELIMITER +
    IntToString(GetLocalInt(oPC, "nScore")) +

//***************************************************************************
//***************************************************************************
    "')");
}


string MySQLEncodeSpecialChars(string sString)
{
    string BS = GetLocalString(GetModule(), "BACKSLASH"); //Must set the module var BACKSLASH to \
    if ((FindSubString(sString, "~") == -1) &&
        (FindSubString(sString, BS) == -1) &&
        (FindSubString(sString, "'") == -1) &&
        (FindSubString(sString, DELIMITER) == -1))
    {
        return sString;
    }

    int i;
    string sReturn = "";
    string sChar;
    int len = GetStringLength(sString);

    // Loop over every character and replace special characters
    for (i = 0; i < len; i++)
    {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "~")
            sReturn += "~~";
        else if (sChar == BS)
            sReturn += "~b";
        else if (sChar == "'")
            sReturn += "~q";
        else if (sChar == DELIMITER)
            sReturn += "~d";
        else
            sReturn += sChar;
    }
    return sReturn;
}
