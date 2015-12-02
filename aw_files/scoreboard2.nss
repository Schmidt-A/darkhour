///Antiworld scoreboard (a sign)
 // top ten score board by: Vladiat0r   [+Jan]
#include "inc_bs_module"
void main()
{
   object oTopPlayer,oPlayer;
   int a, nScore,nTopPlayerScore;
   string sInfoString;
   for (a = 1; a <= 10; a++)
   {
      nTopPlayerScore = 0;

      oPlayer = GetFirstPC();
      while (GetIsObjectValid(oPlayer) == TRUE)
      {
       if (GetLocalInt(oTopPlayer, "scoreTemp") == 0)
       {
         nScore = GetLocalInt(oPlayer, "nScore"); //score of player we're looking at
         if (nScore >= nTopPlayerScore)
         {
            oTopPlayer = oPlayer;
            nTopPlayerScore = nScore;
         }
       }
      oPlayer = GetNextPC();
      }

      if (nTopPlayerScore > 0)
      {
         sInfoString = GetTeamColour(GetPlayerTeam(oTopPlayer))+GetName(oTopPlayer)+"["+IntToString(GetTotalPlayerLevel(oTopPlayer))+"]</c>";
         SetLocalString(OBJECT_SELF,"s"+IntToString(a) , sInfoString);
         SetLocalInt(OBJECT_SELF,"s"+IntToString(a),GetLocalInt(oTopPlayer, "nScore"));
         SetLocalInt(oTopPlayer, "scoreTemp", 1);
      }
  }

 /// Print the strings
 if(GetLocalInt(OBJECT_SELF, "s"+IntToString(1)) == 0)  // checks to see if the first on teh scoreboard has 0 points, if so display that there is no scores
 {
 SpeakString("There is no Scores to Display yet");
 }
 else{
   string sSpeakText = ("...Top Ten Scores!...\n");
   for(a=1;a <=10;a++)
        {
        if( GetLocalInt(OBJECT_SELF,"s"+IntToString(a)) > 0)
        sSpeakText +=  "<c.мы>"+IntToString(a)+": "+GetLocalString(OBJECT_SELF,"s"+IntToString(a))+" with:"+IntToString(GetLocalInt(OBJECT_SELF,"s"+IntToString(a)))+" points!\n";
        }
    SpeakString(sSpeakText);
   }

   ///Reset all values to zero
    for(a=1;a <=10;a++)
    {
    SetLocalInt(OBJECT_SELF,"s"+IntToString(a),0);
    SetLocalString(OBJECT_SELF,"s"+IntToString(a),"");
    }
    oPlayer = GetFirstPC();
      while (GetIsObjectValid(oPlayer) == TRUE)
      {
      SetLocalInt(oTopPlayer, "scoreTemp", 0);
      oPlayer = GetNextPC();
      }
}

