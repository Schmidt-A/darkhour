#include "inc_bs_module"
#include "aw_include"
int StartingConditional()
{   object oWG = GetPCSpeaker();
    int iResult;

    iResult = GetIsDMAW(oWG);
    return iResult;
}
