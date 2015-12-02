#include "criminalrecorder"
#include "aw_include"

int ParseAction(string sSpeech, object oShouter);
void ParseString(struct lds_speech input);
object GetPlayerByName(string sName);
string lds_SQLDecodeSpecialChars(string sString);
struct lds_speech PopSpeech(object oObject);
void CheckStrings();

void main()
{
    CheckStrings();
}

void CheckStrings()
{
    struct lds_speech input=PopSpeech(OBJECT_SELF);
    while(GetStringLength(input.sSpeech) > 1)
    {
        ParseString(input);
        input=PopSpeech(OBJECT_SELF);
    }
    DelayCommand(1.5f, CheckStrings());
}

struct lds_speech
{
    string sPlayer;
    string sSpeech;
    string sType;
};

struct lds_speech PopSpeech(object oObject)
{
    struct lds_speech retval;
    string sSQL="SELECT player, speech, type FROM nwn_speech LIMIT 1";
    SQLExecDirect(sSQL);
    if(SQLFetch())
    {
        retval.sPlayer=SQLGetData(1);
        retval.sSpeech=lds_SQLDecodeSpecialChars(SQLGetData(2)); // DO NOT MODIFY THIS DECODE COMMAND AS THE PLUGIN HAS A BUILT IN ENCODER!!!
        retval.sType=SQLGetData(3);
        sSQL="DELETE FROM nwn_speech LIMIT 1";
        SQLExecDirect(sSQL);
    }
    return retval;
}

string lds_SQLDecodeSpecialChars(string sString)
{
    if (FindSubString(sString, "~") == -1) // not found
        return sString;

    int i;
    string sReturn = "";
    string sChar;
    int length=GetStringLength(sString);
    // Loop over every character and replace special characters
    for (i = 0; i < length; i++)
    {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "~")
        {
            if(length>i+1)
            {
                i++;
                sChar = GetSubString(sString, i, 1);
                if(sChar == "t")
                    sReturn += "'";
                else if(sChar == "p")
                    sReturn += "%";
            }
            else
                sReturn += sChar;
        }
        else
            sReturn += sChar;
    }
    return sReturn;
}

object GetPlayerByName(string sName)
{
    object oReturn = GetLocalObject(GetModule(), "PCName_" + GetStringUpperCase(sName));
    return oReturn;
}

void ParseString(struct lds_speech input)
{
    object oShouter = GetPlayerByName(input.sPlayer);
    if(!GetIsObjectValid(oShouter)) AssignCommand(GetModule(), ActionSpeakString(input.sPlayer + " cannot be found from the PCName record.", TALKVOLUME_SILENT_SHOUT));
    int ret = ParseAction(input.sSpeech, oShouter);
}

int ParseAction(string sSpeech, object oShouter)
{
sSpeech = GetStringUpperCase(sSpeech);
        int iSpace = FindSubString(sSpeech, " ");
        if (iSpace >= 0)
        {
            string sTarget = GetStringRight(sSpeech, GetStringLength(sSpeech) - iSpace -1);
            string sCommand = GetStringLeft(sSpeech, iSpace);
            // AssignCommand(oShouter, ActionSpeakString("Target: " + sTarget + " Command: " + sCommand));
            object oTarget = GetPlayerByName(sTarget);

          if(GetIsGM(oShouter) || GetIsDMAW(oShouter) || GetIsGMNormalChar(oShouter))
          {
            int i;
            if(sCommand == "@BOOT")
            {
                i = CriminalRecordEntry(oTarget, oShouter, "", 2);
                SendMessageToPC(oTarget, "</c><cº>=======================</c>");
                SendMessageToPC(oTarget, "</c><cº>=======================</c>");
                SendMessageToPC(oTarget, "</c><cº>A moderator has chosen to remove you from the game. You will be booted in 5 seconds.</c>");
                SendMessageToPC(oTarget, "</c><cº>=======================</c>");
                SpeakString("</c><co>" + GetName(oTarget) + " [" + GetPCPlayerName(oTarget) + "]</c><cº> has been booted from the game by " + GetName(oShouter) + ".</c>", TALKVOLUME_SHOUT);
                DelayCommand(5.0f, BootPC(oTarget));
            }
            if(sCommand == "@PENGU")
            {
                i = CriminalRecordEntry(oTarget, oShouter, "", 1);
                effect ePoly = EffectPolymorph(POLYMORPH_TYPE_PENGUIN , TRUE);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, 120.0f);
            }
            if(sCommand == "@BAN")
            {
                i = CriminalRecordEntry(oTarget, oShouter, "", 3);
                BanPlayer(oShouter, oTarget, 2);
            }
            if(sCommand == "@GOTO")
            {
                AssignCommand(oShouter, JumpToObject(oTarget));
            }
            if(sCommand == "@JUMPTO")
            {
                AssignCommand(oTarget, JumpToObject(oShouter));
            }
          }
        }
        else // It's a one-liner
        {
        }

    return 1;
}
