#include "inc_bs_module"

int StartingConditional()
{
    int iResult;
    object oSpeaker = GetLastSpeaker();

    iResult = GetIsEnemyTeam(OBJECT_SELF, oSpeaker);
    return iResult;
}
