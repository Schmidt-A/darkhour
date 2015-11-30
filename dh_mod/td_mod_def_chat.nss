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

void DMCommands(object oDM, string sCommand)
{
    if(GetSubString(sCommand,0,5) == "/help")
    {
        SendMessageToPC(oDM,"To use renaming and redescription functions, target someone with the Renamer Tool.");
        SendMessageToPC(oDM,"Type /name NAME_HERE to rename");
        SendMessageToPC(oDM,"Type /desc DESCRIPTION to change description");
        SetPCChatMessage();
    }
    object oTarget = GetLocalObject(oDM,"RENAMER_OBJECT");
    if(oTarget != OBJECT_INVALID)
    {
    if(GetSubString(sCommand,0,5) == "/name")
        {
            string sName = GetSubString(sCommand,6,GetStringLength(sCommand));
            SetName(oTarget,sName);
            SetPCChatMessage();
        }
    else if(GetSubString(sCommand,0,5) == "/desc")
        {
            string sDesc = GetSubString(sCommand,6,GetStringLength(sCommand));
            SetDescription(oTarget,sDesc,TRUE);
            SetPCChatMessage();
        }
    }
}

void main()
{
    // find last player to speak a chat message.
    object oPC = GetPCChatSpeaker();
    // set string variable of last chat message.
    string sLastChat = GetPCChatMessage();
    // get volume of last chat messaage.
    int iVolume = GetPCChatVolume();
    // dertemine if last chat was a talk.
    //
    if (iVolume == TALKVOLUME_TALK)
    {
        if ((GetStringLeft(sLastChat, 5)=="name-") || (GetStringLeft(sLastChat, 6)=="write-"))
            {
            // if message was a talk then delet previous string and save new one
            // save last chat on PC.
            DeleteLocalString(oPC,"TD_QUILLCHAT");
            DelayCommand(0.5,SetLocalString(oPC,"TD_QUILLCHAT", sLastChat));
            }
    }
    if(GetIsDM(oPC))
        DMCommands(oPC,sLastChat);
}
