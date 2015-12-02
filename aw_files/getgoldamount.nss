#include "inc_bs_module"
void main()
{
object oPlayer = GetLastUsedBy();
int nXP = GetXP(oPlayer);
int nGold = GetTotalPlayerItemCost(oPlayer)+ GetGold(oPlayer) ;
int nDrop =  nGold - nXP;
string sSpeakText;
if (nDrop > 0) sSpeakText = ("Your Gold amount (gold and item value) is: "+ IntToString(nGold) + ". You must Drop: " +IntToString(nDrop)+" gold.");

else sSpeakText = ("Your Gold amount is no longer bigger than your XP. Your gold and item value is: "+ IntToString(nGold) + ". You must Drop: " +IntToString(nDrop)+" gold.");

SpeakString(sSpeakText);
}
