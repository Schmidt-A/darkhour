#include "inc_bs_module"
#include "aw_include"
void main()
{
int nPlayers = GetNormalPlayers();
int nGMsWGs = 0;

object oPC = GetFirstPC();
while(GetIsObjectValid(oPC))
 {
  if(GetIsWingedGod(oPC) == TRUE || GetIsGMNormalChar(oPC) == TRUE)
    {
     nGMsWGs = nGMsWGs +1;
    }
   else
    {/*do nothing*/}
   oPC = GetNextPC();
 }
 SetCustomToken(199999, IntToString(nPlayers));
 SetCustomToken(299999, IntToString(nGMsWGs));
}
