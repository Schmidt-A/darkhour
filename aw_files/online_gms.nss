#include "inc_bs_module"
#include "aw_include"
void main()
{
object oPlayer = GetFirstPC();
string sSpeakText = ("\n<cýýý>---Current Online GMs---</c>\n");
  while (GetIsObjectValid(oPlayer))
   {
    if(GetIsGMNormalChar(oPlayer) == TRUE)
     {
       sSpeakText += "<cýýý>Char Name: "+(GetName(oPlayer));
       sSpeakText += " / ";
       sSpeakText += "Name: "+(GetPCPlayerName(oPlayer));
       sSpeakText += "</c>\n";
     }
    oPlayer = GetNextPC();
   }

   AssignCommand(GetLastUsedBy(), SpeakString(sSpeakText, TALKVOLUME_WHISPER));
}
