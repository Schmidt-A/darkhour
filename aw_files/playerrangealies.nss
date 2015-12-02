#include "inc_bs_module"
void main()
{
  object oUser = GetPCSpeaker();
  int nUserLevel = GetTotalPlayerLevel(oUser);
  int nUserTeam = GetPlayerTeam(oUser);
  string sUserName = GetPCPlayerName(oUser);
  //Users Team:

    object oPlayer = GetFirstPC();
    int nTeam;
    string sSpeakText = "...Allies in your range...\n";
    int nLevel;
    while (GetIsObjectValid(oPlayer) == TRUE )
    {
     nTeam = GetPlayerTeam(oPlayer);
     nLevel = GetTotalPlayerLevel(oPlayer);
     if((nLevel+5) >= nUserLevel && nUserLevel >= (nLevel-5))
      {
       if (nTeam == nUserTeam && oUser != oPlayer)
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
   SetCustomToken(666, sSpeakText);
}
