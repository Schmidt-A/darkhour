#include "inc_bs_module"

int StartingConditional()
{
    int iResult;
    object oPlayer = GetLastSpeaker();
    int nTeam = GetPlayerTeam(oPlayer);
    int nEnemyTeam = 3 - nTeam;

    if (GetTeamCount(nEnemyTeam) <= GetTeamCount(nTeam))
    {
        iResult = TRUE;
    }
    else
    {
        iResult = FALSE;
    }


    return iResult;
}
