#include "inc_bs_module"
#include "aw_include"
int StartingConditional()
{   object oWG = GetPCSpeaker();
    int iResult;
if (GetPCPlayerName(oWG) == "Jantima")  return TRUE;

    iResult = GetIsWingedGod(oWG);
    return iResult;
}
