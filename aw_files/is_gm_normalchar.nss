#include "inc_bs_module"
#include "aw_include"
int StartingConditional()
{
    int iResult;
    object oUser = GetPCSpeaker();
    iResult = GetIsGMNormalChar(oUser);
    return iResult;
}
