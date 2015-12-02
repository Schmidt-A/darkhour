#include "inc_bs_module"
#include "aw_include"
int StartingConditional()
{
    int iResult = FALSE;
    object oGM = GetPCSpeaker();
    if(GetPCPlayerName(oGM) == "Jantima" || GetPCPlayerName(oGM) == "VvV-Aez" || GetPCPlayerName(oGM) == "Jak-o-shadows" || GetPCPlayerName(oGM) == "heart-" || GetPCPlayerName(oGM) == "thesheepattackedmefirstitellyou" || GetPCPlayerName(oGM) == "Md Man Monk" || GetPCPlayerName(oGM) == "Vladiat0r" || GetPCPlayerName(oGM) == "Terminer" || GetPCPlayerName(oGM) == "Rubyn" || GetPCPlayerName(oGM) == "PDPuma" || GetPCPlayerName(oGM) == "Steve1173" || GetPCPlayerName(oGM) == "Grimstar the Drunk" || GetPCPlayerName(oGM) == "ANTIJ")
    {
        iResult = TRUE;
    }
    return iResult;
}
