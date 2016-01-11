//::///////////////////////////////////////////////
//:: Name: Module OnPlayerChat event scrpt
//:: FileName: td_mod_def_chat
//:://////////////////////////////////////////////
/*
    OnPlayerChat script for the player book writing system
*/
//:://////////////////////////////////////////////
//:: Created By: Thales Darkshine (Russ Henson)
//:: Created On: 07-20-2008
//:://////////////////////////////////////////////

void main()
{
    // find last player to speak a chat message.
    object oPC = GetPCChatSpeaker();
    // set string variable of last chat message.
    string sLastChat = GetPCChatMessage();
    // get volume of last chat messaage.
    int iVolume = GetPCChatVolume();
    int iType = GetLocalInt(oPC, "DHDMTOOL");
    int iType2 = GetLocalInt(oPC, "DHDMTOOL2");
    // dertemine if last chat was a talk.
    //
    if (iVolume == TALKVOLUME_TALK && iType == 0)
    {
        if ((GetStringLeft(sLastChat, 5)=="name-") || (GetStringLeft(sLastChat, 6)=="write-"))
            {
            // if message was a talk then delet previous string and save new one
            // save last chat on PC.
            DeleteLocalString(oPC,"TD_QUILLCHAT");
            DelayCommand(0.5,SetLocalString(oPC,"TD_QUILLCHAT", sLastChat));
            }
    }
    if(iType == 2)
        {
        DelayCommand(0.5, SetLocalString(oPC, "DHDMDESC", GetLocalString(oPC, "DHDMDESC") + sLastChat));
        }
    if(iType == 4)
        {
        DelayCommand(0.5, SetLocalString(oPC, "DHDMTAG", sLastChat));
        }
    if(iType == 5 || iType == 7)
        {
        DelayCommand(0.5, SetLocalInt(oPC, "DHDMAMNT", StringToInt(sLastChat)));
        }
    if(iType2 == 1 && GetStringLowerCase(sLastChat) == "ban")
        {
        string sCDK = GetLocalString(oPC, "DHDMCDK");
        SetCampaignInt(sCDK + "_BANNED", sCDK, TRUE);
        DeleteLocalInt(oPC, "DHDMTOOL2");
        DeleteLocalString(oPC, "DHDMCDK");
        SendMessageToPC(oPC, "This CDKey has been banned.");
        }
    if(GetStringLeft(GetName(oPC), 7) == "Unebril" && sLastChat == "/zack")
        {
        SetPCChatMessage("");
        SendMessageToPC(oPC, "You are now going to set Zack's description. The next message you type will be the desciption.");
        SetLocalInt(oPC, "settingzack", 1);
        }
    if(GetLocalInt(oPC, "settingzack") == 1)
        {
        SetPCChatMessage("");
        SendMessageToPC(oPC, "You have set Zack's description to " + sLastChat);
        DeleteLocalInt(oPC, "settingzack");
        SetCampaignString(GetName(GetModule()), "ZACKDESC", sLastChat);
        SetDescription(GetObjectByTag("Zack_Dog"), sLastChat);
        }
}
