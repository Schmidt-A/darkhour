#include "aps_include"

int StartingConditional()
{
object oPC = GetPCSpeaker();
int nType = GetPersistentInt(oPC, "SantaJudgement", "christmas");
    int iResult;

    iResult = (nType == 4);
    return iResult;
}
