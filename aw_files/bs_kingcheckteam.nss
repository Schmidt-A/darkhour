#include "inc_bs_module"

int StartingConditional()
{
    object oPlayer = GetLastSpeaker();
    int nTeam = GetPlayerTeam(oPlayer);
    int nEnemyTeam = 3 - nTeam;

    SetCustomToken(701, GetTeamName(nTeam));
    SetCustomToken(702, IntToString(GetTeamCount(nTeam)));
    SetCustomToken(703, GetTeamName(nEnemyTeam));
    SetCustomToken(704, IntToString(GetTeamCount(nEnemyTeam)));

    if (GetTeamCount(nTeam) < GetTeamCount(nEnemyTeam))
    {
        SetCustomToken(705, "will not");
    }
    else
    {
        SetCustomToken(705, "will");
    }

    return TRUE;
}
