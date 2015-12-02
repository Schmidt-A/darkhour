#include "inc_bs_module"
#include "aw_include"
int StartingConditional()
{   object oGM = GetPCSpeaker();
    int iResult;

    iResult = GetIsGM(oGM);
    return iResult;
}
