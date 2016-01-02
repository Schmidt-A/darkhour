//::///////////////////////////////////////////////
//:: _handler_chat
//:: Created by: rmilne
//:: Adapted from chat_script.nss.sample by Dumbo
//:: https://github.com/NWNX/nwnx2-linux/blob/master/plugins/chat/nwn/chat_script.nss.sample
//:://////////////////////////////////////////////

#include "nwnx_chat"

// Format : CHAT_[LEVL]:[SOURCE] | [DESTINATION] | [MESSAGE]

void main()
{
    // speaking object
    object oPC = OBJECT_SELF;
    object oPCn;
    // get text
    SetLocalString(oPC, "NWNX!CHAT!TEXT", dmb_GetSpacer());
    string sText = GetLocalString(oPC, "NWNX!CHAT!TEXT");
    int nMode = StringToInt(GetStringLeft(sText,2));
    int nTo = StringToInt(GetSubString(sText,2,10));
    // trim 12 off the front to get rid of the mode data
    sText = dmb_GetStringFrom(sText, 12);

    // Portion of format : CHAT_[LEVL]:[SOURCE] |
    string sMsg = "CHAT_" + dmb_getChannelText(nMode) + ": (";
    sMsg += GetPCPlayerName(OBJECT_SELF) + ") " + GetName(OBJECT_SELF) + " | ";

    // Portion of format : [DESTINATION]
    if (nMode == CHAT_CHANNEL_TALK || nMode == CHAT_CHANNEL_WHISPER)
    {
        int nIdx = 1;
        float fDst = 3.0;
        if (nMode == CHAT_CHANNEL_TALK)
            fDst = 10.0;

        // consider all players within fDst to be [DESTINATION]
        while (GetIsObjectValid(oPCn=GetNearestCreature(
                                                    CREATURE_TYPE_PLAYER_CHAR,
                                                    PLAYER_CHAR_IS_PC,
                                                    OBJECT_SELF,
                                                    nIdx++)))
        {
            if (GetDistanceToObject(oPCn) < fDst && oPCn != oPC)
                sMsg += GetName(oPCn)+":";
            else
                break;
        }
    }
    else if (nMode == CHAT_CHANNEL_SHOUT)
        sMsg += "(ALL)";
    else if (nMode == CHAT_CHANNEL_PARTY)
    {
        oPCn = GetFirstFactionMember(OBJECT_SELF, TRUE);
        while (GetIsObjectValid(oPCn))
        {
            sMsg += GetName(oPCn)+":";
            oPCn = GetNextFactionMember(OBJECT_SELF, TRUE);
        }
    }
    else if (nMode == CHAT_CHANNEL_PRIVATE)
    {
        oPCn = dmb_getPC(nTo);
        sMsg += "(" + GetPCPlayerName(oPCn) + ") " + GetName(oPCn);
    }
    else
    {
        oPCn = GetFirstPC();
        while (GetIsObjectValid(oPCn))
        {
            if (GetIsDM(oPCn))
                sMsg += " (" + GetPCPlayerName(oPCn)+") " + GetName(oPCn) + ":";
            oPCn = GetNextPC();
        }
    }
    // Portion of format : | [MESSAGE]
    sMsg += " | ";
    SetLocalString(oPC, "NWNX!CHAT!LOG", sMsg+"\n");
    SetLocalString(oPC, "NWNX!CHAT!LOG", " *** "+sText+"\n");

    // The internet never forgets
    WriteTimestampedLogEntry(sMsg + sText);

    // remove garbage
    DeleteLocalString(oPC, "NWNX!CHAT!TEXT");
    DeleteLocalString(oPC, "NWNX!CHAT!SUPRESS");
}


