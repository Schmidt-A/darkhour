#include "inc_bs_module"
void main()
{
  object oUser = GetItemActivator();
  int nUserLevel = GetTotalPlayerLevel(oUser);
  int nUserTeam = GetPlayerTeam(oUser);
  string sUserName = GetPCPlayerName(oUser);
  //Users Team:

    object oPlayer = GetFirstPC();
    int nTeam;
    string sSpeakText = "<c2ÆP>...Allies in your range...</c> \n";
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
   AssignCommand(oUser,SpeakString("<cýýý>"+sSpeakText+"</c>",TALKVOLUME_WHISPER));


     oPlayer = GetFirstPC();
     sSpeakText = ("<cØ(9>...Enemies in your range...</c> \n");
     while (GetIsObjectValid(oPlayer))
      {
       nTeam = GetPlayerTeam(oPlayer);
       nLevel = GetTotalPlayerLevel(oPlayer);
      if((nLevel+5) >= nUserLevel && nUserLevel >= (nLevel-5))
      {
       if (nTeam == 3-nUserTeam)
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
   AssignCommand(oUser,SpeakString("<cýýý>"+sSpeakText+"</c>",TALKVOLUME_WHISPER));
}

