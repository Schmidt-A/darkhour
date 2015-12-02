#include "aps_include"
#include "aw_include"
// Update the info about the player -> for the Status Webpage <- www.antiworld.biz/antiworld/ServerStatus/status.php
void UpdatePlayerStatus(object oPC);
void UpdatePlayerStatus(object oPC)
{
    if (!GetIsPC(oPC) || GetIsDMPossessed(oPC) || GetIsPossessedFamiliar(oPC))
    {
        return;
    }
    string sSQL;

    sSQL="DELETE FROM player_tracking WHERE account='" + SQLEncodeSpecialChars(GetPCPlayerName(oPC))+"'";
    SQLExecDirect(sSQL);

    int cbp2 = GetClassByPosition(2, oPC);
    int cbp3 = GetClassByPosition(3, oPC);
    sSQL="INSERT INTO player_tracking(account, charname, isgod, isgm, class_1, class_2, class_3, level_1, level_2, level_3, kills, deaths, team, score, last_seen) VALUES('" +
    SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "','" +
    SQLEncodeSpecialChars(GetName(oPC)) + "','" +
    IntToString(GetIsWingedGod(oPC)) + "','" +
    IntToString(GetIsGMNormalChar(oPC) || GetIsGM(oPC) || GetIsDMAW(oPC)) + "','" +
    IntToString(GetClassByPosition(1, oPC)) + "','" +
    IntToString(cbp2 == CLASS_TYPE_INVALID ? 0 : cbp2) + "','" +
    IntToString(cbp3 == CLASS_TYPE_INVALID ? 0 : cbp3) + "','" +
    IntToString(GetLevelByPosition(1, oPC)) + "','" +
    IntToString(GetLevelByPosition(2, oPC)) + "','" +
    IntToString(GetLevelByPosition(3, oPC)) + "','" +
    IntToString(GetLocalInt(oPC, "m_nKills")) + "','" +
    IntToString(GetLocalInt(oPC, "m_nDeaths")) + "','" +
    IntToString(GetLocalInt(oPC, "nTeam")) + "','" +
    IntToString(GetLocalInt(oPC, "nScore")) + "',now())";
    //SendMessageToPC(oPC, sSQL);
    SQLExecDirect(sSQL);
}
//// Update the info about the players -> for the Status Webpage <- www.antiworld.biz/antiworld/ServerStatus/status.php
void UpdateAllPlayerStatus();
void UpdateAllPlayerStatus()
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        UpdatePlayerStatus(oPC);
        oPC = GetNextPC();
    }
}



