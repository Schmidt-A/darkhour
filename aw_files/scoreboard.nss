#include "inc_bs_module"
void main()
{
    if (GetLocalInt(OBJECT_SELF,"InUse"))
    {
        return;
    }

    SetLocalInt(OBJECT_SELF, "InUse", TRUE);
    DelayCommand(6.0, DeleteLocalInt(OBJECT_SELF, "InUse"));

    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        DeleteLocalInt(oPC, "Listed");
        oPC = GetNextPC();
    }

    string sSpeak = "";

    int i;
    for (i = 1; i <= 10; i++)
    {
        oPC = GetFirstPC();
        object oCurPC = OBJECT_INVALID;
        int nTeam;
        while (GetIsObjectValid(oPC))
        {
            nTeam = GetPlayerTeam(oPC);
            if (!GetIsPossessedFamiliar(oPC) && GetIsPC(oPC) &&
               ((nTeam == TEAM_GOOD) || (nTeam == TEAM_EVIL)) &&
               !GetLocalInt(oPC, "Listed") &&
               (GetLocalInt(oPC, "nScore") > 0) &&
               (GetLocalInt(oPC, "nScore") >= GetLocalInt(oCurPC, "nScore")) )
            {
                DeleteLocalInt(oCurPC, "Listed");
                oCurPC = oPC;
                SetLocalInt(oCurPC, "Listed", TRUE);
            }

            oPC = GetNextPC();
        }

        if (GetLocalInt(oCurPC, "Listed"))
        {
            //DeleteLocalInt(oCurPC, "ToBePrinted");
            sSpeak += "<c.ÍÙ>" + IntToString(i) + ". " + GetTeamColour(GetPlayerTeam(oCurPC)) + GetStringLeft(GetName(oCurPC), 40) + "[" + IntToString(GetTotalPlayerLevel(oCurPC)) + "]</c> with:" + IntToString(GetLocalInt(oCurPC, "nScore")) + " points!</c>\n";
        }
    }

    if (sSpeak == "")
    {
        sSpeak = "\n<cýýý>There is no Scores to Display yet</c>";
    }
    else
    {
        sSpeak = "\n<cýýý>---Top Ten Scores---</c>\n" + sSpeak;

    }
    AssignCommand(GetLastUsedBy(), SpeakString(sSpeak, TALKVOLUME_WHISPER));
}

/*
///Antiworld scoreboard (a sign)
// top ten score board by: Jantima
#include "inc_bs_module"
void main()
{
    if (GetLocalInt(OBJECT_SELF,"InUse") == 1)
    {
        return;
    }

    SetLocalInt(OBJECT_SELF,"InUse",1);

    string sInfoString;
    int a,b,c;           //a = scores   b = displace 10 - a    c = reset to zero
    int nScore;  //temp score

    object oPlayer = GetFirstPC();
    while (GetIsObjectValid(oPlayer) == TRUE)
    {
        nScore = GetLocalInt(oPlayer, "nScore"); //score of player we're looking at
        for(a = 1; a <= 10 ; a++)//for the 10 numbers of scores we want to check
        {
            //if the score of this char is bigger then any [a] score
            if ( nScore >= GetLocalInt(OBJECT_SELF,"s"+IntToString(a)))
            {
                for(b = 10; b > a; b--)// Displace the values we have stored after the [a]
                {
                    //move [b-1]  to [b]   [down one position] the lowest one is discharged
                    // displace score
                    SetLocalInt(OBJECT_SELF,"s"+IntToString(b),GetLocalInt(OBJECT_SELF,"s"+IntToString(b-1)));
                    //displace stored name
                    SetLocalString(OBJECT_SELF,"s"+IntToString(b),GetLocalString(OBJECT_SELF,"s"+IntToString(b-1)));
                }
                //Then Store in the position [a] the score and the name
                sInfoString = GetTeamColour(GetPlayerTeam(oPlayer))+GetName(oPlayer)+"["+IntToString(GetTotalPlayerLevel(oPlayer))+"]</c>";
                SetLocalInt(OBJECT_SELF,"s"+IntToString(a),nScore);
                SetLocalString(OBJECT_SELF,"s"+IntToString(a), sInfoString);
                //we placed the score already so, exit the cycle:
                a = 11;
            }
            //else do nothing  [a++]
        }
        oPlayer = GetNextPC();
    }

    /// Print the strings
    if(GetLocalInt(OBJECT_SELF, "s"+IntToString(1)) == 0)  // checks to see if the first on teh scoreboard has 0 points, if so display that there is no scores
    {
        SpeakString("There is no Scores to Display yet");
    }
    else
    {
        string sSpeakText = ("...Top Ten Scores!...\n");
        for(c=1;c <=10;c++)
        {
            if( GetLocalInt(OBJECT_SELF,"s"+IntToString(c)) > 0)
                sSpeakText +=  "<c.ÍÙ>"+IntToString(c)+": "+GetLocalString(OBJECT_SELF,"s"+IntToString(c))+" with:"+IntToString(GetLocalInt(OBJECT_SELF,"s"+IntToString(c)))+" points!\n";
        }
        AssignCommand(GetLastUsedBy(), SpeakString(sSpeakText, TALKVOLUME_WHISPER));
   }

   ///Reset all values to zero
    for(c=1;c <=10;c++)
    {
        SetLocalInt(OBJECT_SELF,"s"+IntToString(c),0);
        SetLocalString(OBJECT_SELF,"s"+IntToString(c),"");
    }
    DelayCommand(15.0,DeleteLocalInt(OBJECT_SELF,"InUse"));
}
*/
