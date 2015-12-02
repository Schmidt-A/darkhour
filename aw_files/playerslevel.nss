///And the last script will go in the OnUsed of the object that will function as scoreboard (a sign)
#include "inc_bs_module"
#include "team_balance" //for GetAllPCofLevel

void main()
{
    if (GetLocalInt(OBJECT_SELF,"InUse"))
    {
        return;
    }

    SetLocalInt(OBJECT_SELF, "InUse", TRUE);
    DelayCommand(6.0, DeleteLocalInt(OBJECT_SELF, "InUse"));

    object oCurPC = GetLastUsedBy();
    string sGood = "";
    string sEvil = "";
    string sColor = "";
    string PCs = GetSortedPlayerList(40, 10);
    int i;
    string sSpeak = "";
    int nCount = arGetCount(PCs);
    //WriteTimestampedLogEntry("DEBUG: playerslevel: count = " + IntToString(nCount));
    for (i = 0; i < nCount; i++)
    {
        object oPC = arGetObject(PCs, i);

        if (abs(GetHitDice(oPC) - GetHitDice(oCurPC)) <= 5) { sColor = "<cý>"; } //red
        else { sColor = "<cýýý>"; } //white

        int nTeam = GetPlayerTeam(oPC);
        if (GetIsDMAW(oCurPC)) //add weight to display
        {
            sSpeak = sColor + GetStringLeft(GetName(oPC), 20) + " (" + IntToString(GetHitDice(oPC)) + "  +  " + IntToString(GetPlayerWeight(oPC)) + ") [" + IntToString(GetLocalInt(oPC, "nScore")) + "  " + IntToString(GetLocalInt(oPC, "m_nKills")) + "  " + IntToString(GetLocalInt(oPC, "m_nDeaths")) + "]</c>\n";
        }
        else
        {
            sSpeak = sColor + GetStringLeft(GetName(oPC), 30) + " (" + IntToString(GetHitDice(oPC)) + ")</c>\n";
        }

        if (nTeam == TEAM_GOOD)
        {
            sGood += sSpeak;
        }
        else
        {
            sEvil += sSpeak;
        }
    }
    arDeleteArray(PCs);

    object oModule = GetModule();
    string sGoodTitle = "\n<cýýý>[ GOOD total: " + IntToString(GetTeamCount(TEAM_GOOD)) + "  score: " + IntToString(GetLocalInt(oModule, "nScore_" + IntToString(TEAM_GOOD))) + " ]</c>\n";
    string sEvilTitle = "\n<cýýý>[ EVIL total: " + IntToString(GetTeamCount(TEAM_EVIL)) + "  score: " + IntToString(GetLocalInt(oModule, "nScore_" + IntToString(TEAM_EVIL))) + " ]</c>\n";

    sSpeak = "";
    if (GetPlayerTeam(oCurPC) == TEAM_GOOD) //show last as current team
    {
        sSpeak = sGoodTitle + sGood + sEvilTitle + sEvil;
    }
    else
    {
        sSpeak = sEvilTitle + sEvil + sGoodTitle + sGood;
    }

    AssignCommand(oCurPC, SpeakString(sSpeak, TALKVOLUME_WHISPER));

/*
    object oPlayer = GetFirstPC();
    string sSpeakText = ("...GOOD...          ...EVIL...\n");
    int nTeam;
    int Level;
     while (GetIsObjectValid(oPlayer))
    {  nTeam = GetPlayerTeam(oPlayer);
     if (nTeam == TEAM_GOOD)
       {

       Level = GetTotalPlayerLevel(oPlayer);
       sSpeakText += (GetName(oPlayer));
       sSpeakText += " ";
       sSpeakText += "/";
       sSpeakText += " ";
       sSpeakText += IntToString(Level);
       sSpeakText += "\n";
       }
        // Get the next player
       oPlayer = GetNextPC();
      }
      SpeakString(sSpeakText);
    }

 {
    object oPlayer = GetFirstPC();
    int nTeam;
    int Level;
    string sSpeakText = ("...EVIL Team...\n");
    while (GetIsObjectValid(oPlayer) == TRUE )
    {    nTeam = GetPlayerTeam(oPlayer);
    if (nTeam == TEAM_EVIL)
       {

       Level = GetTotalPlayerLevel(oPlayer);
       sSpeakText += GetName(oPlayer);
       sSpeakText += " ";
       sSpeakText += "/";
       sSpeakText += " ";
       sSpeakText += IntToString(Level);
       sSpeakText += "\n";
       }
        // Get the next player
        oPlayer = GetNextPC();
     }
   SpeakString(sSpeakText);
   }
*/
}

