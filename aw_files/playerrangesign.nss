///And the last script will go in the OnUsed of the object that will function as scoreboard (a sign)
#include "inc_bs_module"
void main()
{


  object oUser = GetPCSpeaker();
  int nUserLevel = GetTotalPlayerLevel(oUser);
  int nUserTeam = GetPlayerTeam(oUser);
  string sUserName = GetPCPlayerName(oUser);

//Enemy Team:
  {
    object oPlayer = GetFirstPC();
    string sSpeakText = ("...Enemies in your range...\n");
    int nTeam = GetPlayerTeam(oPlayer);
    int nLevel = GetTotalPlayerLevel(oPlayer);
     while (GetIsObjectValid(oPlayer) == TRUE )
    {
     if((nLevel+5) >= nUserLevel && nUserLevel >= (nLevel-5))
      {
       if (nTeam == (3-nUserTeam))
         {
         sSpeakText += (GetName(oPlayer));
         sSpeakText += " ";
         sSpeakText += "/";
         sSpeakText += " ";
         sSpeakText += IntToString(nLevel);
         sSpeakText += "\n";
         }
      }
       // Get the next player
       oPlayer = GetNextPC();
    }
   SetCustomToken(555, sSpeakText);
  }
}
