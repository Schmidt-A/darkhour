#include "inc_bs_module"
#include "aw_include"
int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalInt(oPC, "MapVote") == 1 && !GetIsDMAW(oPC));
    return iResult;
}
